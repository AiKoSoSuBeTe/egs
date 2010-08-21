%% @author Lo�c Hoguin <essen@dev-extend.eu>
%% @copyright 2010 Lo�c Hoguin.
%% @doc Handle game clients.
%%
%%	This file is part of EGS.
%%
%%	EGS is free software: you can redistribute it and/or modify
%%	it under the terms of the GNU General Public License as published by
%%	the Free Software Foundation, either version 3 of the License, or
%%	(at your option) any later version.
%%
%%	EGS is distributed in the hope that it will be useful,
%%	but WITHOUT ANY WARRANTY; without even the implied warranty of
%%	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%	GNU General Public License for more details.
%%
%%	You should have received a copy of the GNU General Public License
%%	along with EGS.  If not, see <http://www.gnu.org/licenses/>.

-module(psu_game).
-export([start_link/1, cleanup/1]). %% External.
-export([listen/2, accept/2, process_init/2, process/0, char_select/0, area_load/4, loop/1]). %% Internal.

-include("include/records.hrl").
-include("include/maps.hrl").
-include("include/missions.hrl").
-include("include/psu/npc.hrl").

-define(OPTIONS, [binary, {active, false}, {reuseaddr, true}, {certfile, "priv/ssl/servercert.pem"}, {keyfile, "priv/ssl/serverkey.pem"}, {password, "alpha"}]).

%% @spec start_link(Port) -> {ok,Pid::pid()}
%% @doc Start the game server.
start_link(Port) ->
	{ok, MPid} = egs_exit_mon:start_link({?MODULE, cleanup}),
	LPid = spawn(?MODULE, listen, [Port, MPid]),
	{ok, LPid}.

%% @spec cleanup(Pid) -> ok
%% @doc Cleanup the data associated with the failing process.
%% @todo Cleanup the instance process if there's nobody in it anymore.
cleanup(Pid) ->
	case egs_user_model:read({pid, Pid}) of
		{ok, User} ->
			egs_user_model:delete(User#egs_user_model.id),
			{ok, List} = egs_user_model:select({neighbors, User}),
			lists:foreach(fun(Other) -> Other#egs_user_model.pid ! {psu_player_unspawn, User} end, List),
			io:format("game (~p): quit~n", [User#egs_user_model.id]);
		{error, _Reason} ->
			ignore
	end.

%% @doc Listen for connections.
listen(Port, MPid) ->
	error_logger:info_report(io_lib:format("psu_game listening on port ~b", [Port])),
	{ok, LSocket} = ssl:listen(Port, ?OPTIONS),
	?MODULE:accept(LSocket, MPid).

%% @doc Accept connections.
accept(LSocket, MPid) ->
	case ssl:transport_accept(LSocket, 5000) of
		{ok, CSocket} ->
			case ssl:ssl_accept(CSocket, 5000) of
				ok ->
					Pid = spawn(?MODULE, process_init, [CSocket, MPid]),
					ssl:controlling_process(CSocket, Pid);
				{error, _Reason} ->
					reload
			end;
		_ ->
			reload
	end,
	?MODULE:accept(LSocket, MPid).

%% @doc Initialize the client process by saving the socket to the process dictionary.
process_init(CSocket, MPid) ->
	link(MPid),
	put(socket, CSocket),
	send_0202(),
	timer:send_interval(5000, {psu_keepalive}),
	process().

%% @doc Process the new connections.
%%      Send an hello packet, authenticate the user and send him to character select.
process() ->
	case psu_proto:packet_recv(get(socket), 5000) of
		{ok, Orig} ->
			{command, Command, _, Data} = psu_proto:packet_parse(Orig),
			process_handle(Command, Data);
		{error, timeout} ->
			reload,
			?MODULE:process();
		{error, closed} ->
			closed
	end.

%% @doc Game server auth request handler. Save the GID in the process dictionary after checking it.
process_handle(16#020d, << GID:32/little-unsigned-integer, Auth:32/bits, _/bits >>) ->
	CSocket = get(socket),
	case egs_user_model:read(GID) of
		{error, badarg} ->
			log("can't find user, closing"),
			ssl:close(CSocket);
		{ok, User} ->
			case User#egs_user_model.state of
				{wait_for_authentication, Auth} ->
					put(gid, GID),
					log("auth success"),
					LID = 1 + mnesia:dirty_update_counter(counters, lobby, 1) rem 1023,
					Time = calendar:datetime_to_gregorian_seconds(calendar:universal_time()),
					egs_user_model:write(#egs_user_model{id=GID, pid=self(), socket=CSocket, state=authenticated, time=Time, folder=User#egs_user_model.folder, lid=LID}),
					send_0d05(),
					?MODULE:char_select();
				_ ->
					log("quit, auth failed"),
					egs_user_model:delete(GID),
					ssl:close(CSocket)
			end
	end;

%% @doc Platform information handler. Obtain the game version and save it into the process dictionary.
process_handle(16#080e, << _:64, Version:32/little-unsigned-integer, _/bits >>) ->
	put(version, Version),
	?MODULE:process();

%% @doc Unknown command handler. Do nothing.
process_handle(Command, _) ->
	log("(process) dismissed packet ~4.16.0b", [Command]),
	?MODULE:process().

%% @doc Character selection screen loop.
char_select() ->
	case psu_proto:packet_recv(get(socket), 5000) of
		{ok, Orig} ->
			{command, Command, _, Data} = psu_proto:packet_parse(Orig),
			char_select_handle(Command, Data);
		{error, timeout} ->
			psu_proto:send_keepalive(get(socket)),
			reload,
			?MODULE:char_select();
		{error, closed} ->
			closed %% exit
	end.

%% @doc Character selection handler.
char_select_handle(16#020b, << Number:32/little-unsigned-integer, _/bits >>) ->
	log("selected character ~b", [Number]),
	char_select_load(Number);

%% @doc Character creation handler.
%% @todo Reenable appearance validation whenever things go live.
char_select_handle(16#0d02, << Number:32/little-unsigned-integer, Char/bits >>) ->
	log("character creation"),
	%% check for valid character appearance
	%~ << _Name:512, RaceID:8, GenderID:8, _TypeID:8, AppearanceBin:776/bits, _/bits >> = Char,
	%~ Race = proplists:get_value(RaceID, [{0, human}, {1, newman}, {2, cast}, {3, beast}]),
	%~ Gender = proplists:get_value(GenderID, [{0, male}, {1, female}]),
	%~ Appearance = psu_appearance:binary_to_tuple(Race, AppearanceBin),
	%~ psu_appearance:validate_char_create(Race, Gender, Appearance),
	%% end of check, continue doing it wrong past that point for now
	{ok, User} = egs_user_model:read(get(gid)),
	_ = file:make_dir(io_lib:format("save/~s", [User#egs_user_model.folder])),
	file:write_file(io_lib:format("save/~s/~b-character", [User#egs_user_model.folder, Number]), Char),
	file:write_file(io_lib:format("save/~s/~b-character.options", [User#egs_user_model.folder, Number]), << 0:128, 4, 0:56 >>), % default 0 to everything except brightness 4
	char_select_load(Number);

%% @doc Character selection screen request.
char_select_handle(16#0d06, _) ->
	{ok, User} = egs_user_model:read(get(gid)),
	send_0d03(data_load(User#egs_user_model.folder, 0), data_load(User#egs_user_model.folder, 1), data_load(User#egs_user_model.folder, 2), data_load(User#egs_user_model.folder, 3)),
	?MODULE:char_select();

%% @doc Silently ignore packet 0818. Gives CPU/GPU information.
char_select_handle(16#0818, _) ->
	?MODULE:char_select();

%% @doc Unknown command handler. Do nothing.
char_select_handle(Command, _) ->
	log("(char_select) dismissed packet ~4.16.0b", [Command]),
	?MODULE:char_select().

%% @doc Load the selected character in the start lobby and start the main game's loop.
%%      The default entry point currently is 4th floor, Linear Line counter.
char_select_load(Number) ->
	{ok, OldUser} = egs_user_model:read(get(gid)),
	[{status, 1}, {char, CharBin}, {options, OptionsBin}] = data_load(OldUser#egs_user_model.folder, Number),
	<< Name:512/bits, RaceBin:8, GenderBin:8, ClassBin:8, AppearanceBin:776/bits, _/bits >> = CharBin,
	psu_characters:validate_name(Name), % TODO: don't validate name when loading character, do it at creation
	Race = psu_characters:race_binary_to_atom(RaceBin),
	Gender = psu_characters:gender_binary_to_atom(GenderBin),
	Class = psu_characters:class_binary_to_atom(ClassBin),
	Appearance = psu_appearance:binary_to_tuple(Race, AppearanceBin),
	Options = psu_characters:options_binary_to_tuple(OptionsBin),
	Character = #characters{slot=Number, name=Name, race=Race, gender=Gender, class=Class, appearance=Appearance, options=Options}, % TODO: temporary set the slot here, won't be needed later
	User = OldUser#egs_user_model{state=online, character=Character, area=#psu_area{questid=undefined, zoneid=undefined, mapid=undefined},
		prev_area={psu_area, 0, 0, 0}, prev_entryid=0, pos=#pos{x=0.0, y=0.0, z=0.0, dir=0.0}, setid=0},
	egs_user_model:write(User),
	char_load(User),
	send_021b(),
	area_load(1100000, 0, 4, 5),
	ssl:setopts(get(socket), [{active, true}]),
	?MODULE:loop(<< >>).

%% @doc Load the given character's data.
data_load(Folder, Number) ->
	Filename = io_lib:format("save/~s/~b-character", [Folder, Number]),
	case file:read_file(Filename) of
		{ok, Char} ->
			{ok, Options} = file:read_file(io_lib:format("~s.options", [Filename])),
			[{status, 1}, {char, Char}, {options, Options}];
		{error, _} ->
			[{status, 0}, {char, << 0:2208 >>}]
	end.

%% @doc Load and send the character information to the client.
char_load(User) ->
	send_0d01(User),
	% 0246
	send_0a0a(),
	send_1006(5),
	send_1005((User#egs_user_model.character)#characters.name),
	send_1006(12),
	send_0210(),
	send_0222(),
	send_1500(User),
	send_1501(),
	send_1512(),
	% 0303
	send_1602().

%% @doc Return the current season information.
area_get_season(QuestID) ->
	{{_, Month, Day}, _} = calendar:universal_time(),
	[IsSeasonal, SeasonID, SeasonQuestIDs] = if
		Month =:=  1, Day =< 14            -> ?SEASON_NEWYEAR;
		Month =:=  1, Day >= 25            -> ?SEASON_WINTER;
		Month =:=  2, Day =< 7             -> ?SEASON_WINTER;
		Month =:=  2, Day >= 14            -> ?SEASON_VALENTINE;
		Month =:=  3, Day =< 6             -> ?SEASON_VALENTINE;
		Month =:=  3, Day >= 14            -> ?SEASON_WHITEDAY;
		Month =:=  4, Day =< 3             -> ?SEASON_WHITEDAY;
		Month =:=  4, Day >= 4, Day =< 24  -> ?SEASON_EASTER;
		Month =:=  4, Day >= 25            -> ?SEASON_SPRING;
		Month =:=  5, Day =< 8             -> ?SEASON_SPRING;
		Month =:=  5, Day >= 17, Day =< 30 -> ?SEASON_WEDDING;
		Month =:=  6, Day >= 3, Day =< 16  -> ?SEASON_PARUMUNIF;
		Month =:=  6, Day >= 23            -> ?SEASON_SONIC;
		Month =:=  7, Day =< 13            -> ?SEASON_SONIC;
		Month =:=  7, Day >= 18            -> ?SEASON_HOLYLIGHT;
		Month =:=  8, Day =< 21            -> ?SEASON_FIREWORKS;
		Month =:=  8, Day >= 28            -> ?SEASON_NATIVE;
		Month =:=  9, Day =< 10            -> ?SEASON_NATIVE;
		Month =:=  9, Day >= 24            -> ?SEASON_AUTUMN;
		Month =:= 10, Day =< 7             -> ?SEASON_AUTUMN;
		Month =:= 10, Day >= 15, Day =< 28 -> ?SEASON_PARTY;
		Month =:= 10, Day >= 31            -> ?SEASON_HALLOWEEN;
		Month =:= 11, Day =< 20            -> ?SEASON_HALLOWEEN;
		Month =:= 12, Day >= 11            -> ?SEASON_CHRISTMAS;
		true                               -> ?SEASON_NONE
	end,
	if	IsSeasonal =:= 1 ->
			case lists:member(QuestID, SeasonQuestIDs) of
				true  -> [{status, IsSeasonal}, {season, SeasonID}];
				false -> [{status, 0}, {season, 255}]
			end;
		true ->
			[{status, 0}, {season, 255}]
	end.

%% @doc Load the given map as a standard lobby.
area_load(QuestID, ZoneID, MapID, EntryID) ->
	{ok, OldUser} = egs_user_model:read(get(gid)),
	[{type, AreaType}, {file, QuestFile}|MissionInfo] = proplists:get_value(QuestID, ?QUESTS, [{type, undefined}, {file, undefined}]),
	[IsStart, RealZoneID, RealMapID, RealEntryID, NbSetsInQuest] = case AreaType of
		mission ->
			if	ZoneID =:= 65535 ->
					[{start, [TmpZoneID, TmpMapID, TmpEntryID]}, {sets, TmpNbSets}] = MissionInfo,
					[true, TmpZoneID, TmpMapID, TmpEntryID, TmpNbSets];
				true -> [false, ZoneID, MapID, EntryID, ignored]
			end;
		myroom ->
			if	ZoneID =:= 0 ->
					[false, 0, 423, EntryID, ignored];
				true -> [false, ZoneID, MapID, EntryID, ignored]
			end;
		_ ->
			[false, ZoneID, MapID, EntryID, ignored]
	end,
	[{file, ZoneFile}|ZoneSetInfo] = proplists:get_value([QuestID, RealZoneID], ?ZONES, [{file, undefined}]),
	NbSetsInZone = case ZoneSetInfo of [] -> 1; [{sets, TmpNbSetsInZone}] -> TmpNbSetsInZone end,
	if	AreaType =:= myroom ->
			AreaName = "Your Room";
		true ->
			[{name, AreaName}] = proplists:get_value([QuestID, RealMapID], ?MAPS, [{name, "dammy"}])
	end,
	{InstancePid, SetID} = if IsStart =:= true -> % initialize the mission
			Zones = proplists:get_value(QuestID, ?MISSIONS),
			{ok, RetPid} = psu_instance:start_link(Zones),
			RetSetID = crypto:rand_uniform(0, NbSetsInQuest),
			{RetPid, RetSetID};
		true -> {OldUser#egs_user_model.instancepid, OldUser#egs_user_model.setid}
	end,
	User = OldUser#egs_user_model{instancepid=InstancePid, areatype=AreaType, area={psu_area, QuestID, RealZoneID, RealMapID}, entryid=RealEntryID, counterid=undefined},
	egs_user_model:write(User),
	RealSetID = if SetID > NbSetsInZone - 1 -> NbSetsInZone - 1; true -> SetID end,
	area_load(AreaType, IsStart, RealSetID, OldUser, User, QuestFile, ZoneFile, AreaName).

area_load(AreaType, IsStart, SetID, OldUser, User, QuestFile, ZoneFile, AreaName) ->
	#psu_area{questid=OldQuestID, zoneid=OldZoneID} = OldUser#egs_user_model.area,
	#psu_area{questid=QuestID, zoneid=ZoneID, mapid=_MapID} = User#egs_user_model.area,
	QuestChange = if OldQuestID /= QuestID, QuestFile /= undefined -> true; true -> false end,
	if	ZoneFile =:= undefined ->
			ZoneChange = false;
		true ->
			ZoneChange = if OldQuestID =:= QuestID, OldZoneID =:= ZoneID -> false; true -> true end
	end,
	[{status, IsSeasonal}, {season, SeasonID}] = area_get_season(QuestID),
	% broadcast spawn and unspawn to other people
	{ok, UnspawnList} = egs_user_model:select({neighbors, OldUser}),
	{ok, SpawnList} = egs_user_model:select({neighbors, User}),
	lists:foreach(fun(Other) -> Other#egs_user_model.pid ! {psu_player_unspawn, User} end, UnspawnList),
	if	AreaType =:= lobby ->
			lists:foreach(fun(Other) -> Other#egs_user_model.pid ! {psu_player_spawn, User} end, SpawnList);
		true -> ignore
	end,
	% load area
	if	QuestChange =:= true ->
			% reload the character if entering or leaving the room quest
			if	OldQuestID =:= 1120000; QuestID =:= 1120000 ->
					char_load(User);
				true -> ignore
			end,
			% load new quest
			send_0c00(QuestID),
			send_020e(QuestFile);
		true -> ignore
	end,
	if	IsStart =:= true ->
			send_0215(16#ffffffff);
		true -> ignore
	end,
	if	ZoneChange =:= true ->
			% load new zone
			send_0a05(),
			if AreaType =:= lobby ->
					send_0111(6, 0);
				true -> ignore
			end,
			send_010d(User#egs_user_model{lid=0}),
			send_0200(AreaType),
			send_020f(ZoneFile, SetID, SeasonID);
		true -> ignore
	end,
	send_0205(ZoneID, (User#egs_user_model.area)#psu_area.mapid, User#egs_user_model.entryid, IsSeasonal),
	send_100e(QuestID, ZoneID, (User#egs_user_model.area)#psu_area.mapid, AreaName, 16#ffffffff),
	if	AreaType =:= mission ->
			send_0215(0),
			if	IsStart =:= true ->
					send_0215(0),
					send_0c09();
				true -> ignore
			end;
		true ->
			send_020c()
	end,
	case AreaType of
		myroom ->
			send_1332(),
			send_1202(),
			send_1204(),
			send_1206();
		mission ->
			send_1202(),
			send_1204(),
			send_1206(),
			send_1207();
		_ -> ignore
	end,
	if	AreaType /= spaceport ->
			send_1212();
		true -> ignore
	end,
	if	AreaType =:= myroom ->
			send_1309();
		true -> ignore
	end,
	send_0201(User#egs_user_model{lid=0}),
	if	ZoneChange =:= true ->
			send_0a06();
		true -> ignore
	end,
	send_0233(SpawnList),
	send_0208(),
	send_0236(),
	if	User#egs_user_model.partypid =/= undefined, AreaType =:= mission ->
			{ok, NPCList} = psu_party:get_npc(User#egs_user_model.partypid),
			npc_load(User, NPCList);
		true -> ok
	end.

%% @todo Make NPC hide in lobbies but show-up in missions.
%% @todo Don't change the NPC info unless you are the leader!
npc_load(_Leader, []) ->
	ok;
npc_load(Leader, [{PartyPos, NPCGID}|NPCList]) ->
	{ok, OldNPCUser} = egs_user_model:read(NPCGID),
	#egs_user_model{instancepid=InstancePid, area=Area, entryid=EntryID, pos=Pos} = Leader,
	NPCUser = OldNPCUser#egs_user_model{lid=PartyPos, instancepid=InstancePid, areatype=mission, area=Area, entryid=EntryID, pos=Pos},
	%% @todo This one on mission end/abort?
	%~ OldNPCUser#egs_user_model{lid=PartyPos, instancepid=undefined, areatype=AreaType, area={psu_area, 0, 0, 0}, entryid=0, pos={pos, 0.0, 0.0, 0.0, 0}}
	egs_user_model:write(NPCUser),
	send_010d(NPCUser),
	send_0201(NPCUser),
	send_0215(0),
	send_0a04(NPCUser#egs_user_model.id),
	send_1004(npc_mission, NPCUser, PartyPos),
	send_100f((NPCUser#egs_user_model.character)#characters.npcid, PartyPos),
	send_1601(),
	send_1016(PartyPos),
	npc_load(Leader, NPCList).

%% @doc Game's main loop.
%% @todo We probably don't want to send a keepalive packet unnecessarily.
loop(SoFar) ->
	receive
		{psu_broadcast, Orig} ->
			<< A:64/bits, _:32, B:96/bits, _:64, C/bits >> = Orig,
			GID = get(gid),
			send(<< A/binary, 16#00011300:32, B/binary, 16#00011300:32, GID:32/little-unsigned-integer, C/binary >>),
			?MODULE:loop(SoFar);
		{psu_chat, ChatTypeID, ChatGID, ChatName, ChatModifiers, ChatMessage} ->
			send_0304(ChatTypeID, ChatGID, ChatName, ChatModifiers, ChatMessage),
			?MODULE:loop(SoFar);
		{psu_keepalive} ->
			psu_proto:send_keepalive(get(socket)),
			?MODULE:loop(SoFar);
		{psu_player_spawn, _Spawn} ->
			% Should be something along the lines of 203 201 204 or something.
			{ok, User} = egs_user_model:read(get(gid)),
			{ok, SpawnList} = egs_user_model:select({neighbors, User}),
			send_0233(SpawnList),
			?MODULE:loop(SoFar);
		{psu_player_unspawn, Spawn} ->
			send_0204(Spawn#egs_user_model.id, Spawn#egs_user_model.lid, 5),
			?MODULE:loop(SoFar);
		{psu_warp, QuestID, ZoneID, MapID, EntryID} ->
			area_load(QuestID, ZoneID, MapID, EntryID),
			?MODULE:loop(SoFar);
		{ssl, _, Data} ->
			{Packets, Rest} = psu_proto:packet_split(<< SoFar/bits, Data/bits >>),
			[dispatch(Orig) || Orig <- Packets],
			?MODULE:loop(Rest);
		{ssl_closed, _} ->
			ssl_closed; %% exit
		{ssl_error, _, _} ->
			ssl_error; %% exit
		_ ->
			?MODULE:loop(SoFar)
	after 1000 ->
		reload,
		?MODULE:loop(SoFar)
	end.

%% @doc Dispatch the command to the right handler.
dispatch(Orig) ->
	case psu_proto:parse(Orig) of
		{command, Command, Channel, Data} ->
			case Channel of
				1 -> broadcast(Command, Orig);
				_ -> handle(Command, Data)
			end;
		ignore ->
			ignore;
		Event ->
			event(Event)
	end.

%% @doc Position change broadcast handler. Save the position and then dispatch it.
broadcast(16#0503, Orig) ->
	<< _:424, Dir:24/little-unsigned-integer, _PrevCoords:96, X:32/little-float, Y:32/little-float, Z:32/little-float,
		QuestID:32/little-unsigned-integer, ZoneID:32/little-unsigned-integer, MapID:32/little-unsigned-integer, EntryID:32/little-unsigned-integer, _:32 >> = Orig,
	FloatDir = Dir / 46603.375,
	{ok, User} = egs_user_model:read(get(gid)),
	NewUser = User#egs_user_model{pos=#pos{x=X, y=Y, z=Z, dir=FloatDir}, area=#psu_area{questid=QuestID, zoneid=ZoneID, mapid=MapID}, entryid=EntryID},
	egs_user_model:write(NewUser),
	broadcast(default, Orig);

%% @doc Stand still broadcast handler. Save the position and then dispatch it.
broadcast(16#0514, Orig) ->
	<< _:424, Dir:24/little-unsigned-integer, X:32/little-float, Y:32/little-float, Z:32/little-float,
		QuestID:32/little-unsigned-integer, ZoneID:32/little-unsigned-integer,
		MapID:32/little-unsigned-integer, EntryID:32/little-unsigned-integer, _/bits >> = Orig,
	FloatDir = Dir / 46603.375,
	{ok, User} = egs_user_model:read(get(gid)),
	NewUser = User#egs_user_model{pos=#pos{x=X, y=Y, z=Z, dir=FloatDir}, area=#psu_area{questid=QuestID, zoneid=ZoneID, mapid=MapID}, entryid=EntryID},
	egs_user_model:write(NewUser),
	broadcast(default, Orig);

%% @doc Default broadcast handler. Dispatch the command to everyone.
%%      We clean up the command and use the real GID and LID of the user, disregarding what was sent and possibly tampered with.
%%      Only a handful of commands are allowed to broadcast. An user tampering with it would get disconnected instantly.
%% @todo Don't query the user data everytime! Keep an User instead of a GID probably.
broadcast(Command, Orig)
	when	Command =:= 16#0101;
			Command =:= 16#0102;
			Command =:= 16#0104;
			Command =:= 16#0107;
			Command =:= 16#010f;
			Command =:= 16#050f;
			Command =:= default ->
	<< _:32, A:64/bits, _:64, B:192/bits, _:64, C/bits >> = Orig,
	GID = get(gid),
	case egs_user_model:read(GID) of
		{error, _Reason} ->
			ignore;
		{ok, Self} ->
			LID = Self#egs_user_model.lid,
			Packet = << A/binary, 16#00011300:32, GID:32/little-unsigned-integer, B/binary,
				GID:32/little-unsigned-integer, LID:32/little-unsigned-integer, C/binary >>,
			{ok, SpawnList} = egs_user_model:select({neighbors, Self}),
			lists:foreach(fun(User) -> User#egs_user_model.pid ! {psu_broadcast, Packet} end, SpawnList)
	end.

%% @todo When changing lobby to the room, 0230 must also be sent. Same when going from room to lobby.
%% @todo Probably move area_load inside the event and make other events call this one when needed.
event({area_change, QuestID, ZoneID, MapID, EntryID}) ->
	log("area change (~b,~b,~b,~b)", [QuestID, ZoneID, MapID, EntryID]),
	area_load(QuestID, ZoneID, MapID, EntryID);

%% @todo Make sure non-mission counters follow the same loading process.
%% @todo Probably validate the From* values, to not send the player back inside a mission.
event({counter_enter, CounterID, FromZoneID, FromMapID, FromEntryID}) ->
	log("counter load ~b", [CounterID]),
	{ok, OldUser} = egs_user_model:read(get(gid)),
	OldArea = OldUser#egs_user_model.area,
	FromArea = {psu_area, OldArea#psu_area.questid, FromZoneID, FromMapID},
	User = OldUser#egs_user_model{areatype=counter, area={psu_area, 16#7fffffff, 0, 0}, entryid=0, counterid=CounterID, prev_area=FromArea, prev_entryid=FromEntryID},
	egs_user_model:write(User),
	AreaName = "Counter",
	QuestFile = "data/lobby/counter.quest.nbl",
	ZoneFile = "data/lobby/counter.zone.nbl",
	%% broadcast unspawn to other people
	{ok, UnspawnList} = egs_user_model:select({neighbors, OldUser}),
	lists:foreach(fun(Other) -> Other#egs_user_model.pid ! {psu_player_unspawn, User} end, UnspawnList),
	%% load counter
	send_0c00(16#7fffffff),
	send_020e(QuestFile),
	send_0a05(),
	send_010d(User#egs_user_model{lid=0}),
	send_0200(mission),
	send_020f(ZoneFile, 0, 16#ff),
	send_0205(0, 0, 0, 0),
	send_100e(16#7fffffff, 0, 0, AreaName, CounterID),
	send_0215(0),
	send_0215(0),
	send_020c(),
	send_1202(),
	send_1204(),
	send_1206(),
	send_1207(),
	send_1212(),
	send_0201(User#egs_user_model{lid=0}),
	send_0a06(),
	send_0208(),
	send_0236();

%% @doc Leave mission counter handler.
event(counter_leave) ->
	{ok, User} = egs_user_model:read(get(gid)),
	PrevArea = User#egs_user_model.prev_area,
	area_load(PrevArea#psu_area.questid, PrevArea#psu_area.zoneid, PrevArea#psu_area.mapid, User#egs_user_model.prev_entryid);

%% @doc Request the counter's quest files.
event({counter_quest_files_request, CounterID}) ->
	log("counter quest files request ~p", [CounterID]),
	[{quests, Filename}|_Tail] = proplists:get_value(CounterID, ?COUNTERS),
	send_0c06(Filename);

%% @todo A and B are unknown.
%%      Melee uses a format similar to: AAAA--BBCCCC----DDDDDDDDEE----FF with
%%      AAAA the attack sound effect, BB the range, CCCC and DDDDDDDD unknown but related to angular range or similar, EE number of targets and FF the model.
%%      Bullets and tech weapons formats are unknown but likely use a slightly different format.
%% @todo Others probably want to see that you changed your weapon.
%% @todo Apparently B is always ItemID+1. Not sure why.
%% @todo Currently use a separate file for the data sent for the weapons.
%% @todo TargetGID and TargetLID must be validated, they're either the player's or his NPC characters.
event({item_equip, ItemID, TargetGID, TargetLID, A, B}) ->
	GID = get(gid),
	Category = case ItemID of
		% units would be 8, traps would be 12
		19 -> 2; % armor
		Y when Y =:= 5; Y =:= 6; Y =:= 7 -> 0; % clothes
		_ -> 1 % weapons
	end,
	Filename = case ItemID of
		% weapons
		16 -> "p/packet0105_sword.bin";
		13 -> "p/packet0105_twindaggers.bin";
		15 -> "p/packet0105_dagger.bin";
		 9 -> "p/packet0105_rcsm.bin";
		14 -> "p/packet0105_saber.bin";
		 8 -> "p/packet0105_mgun.bin";
		X when X =:= 17; X =:= 18 ->
			"p/packet0105_twinguns.bin";
		% armor
		19 -> "p/packet0105_armor.bin";
		% clothes
		X when X =:= 5; X =:= 6; X =:= 7 ->
			none;
		_ -> % default, for lou
			"p/packet0105_twindaggers.bin"
	end,
	case Filename of
		none -> File = << >>;
		_ -> {ok, File} = file:read_file(Filename)
	end,
	send(<< 16#01050300:32, 0:64, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer,
		0:64, TargetGID:32/little-unsigned-integer, TargetLID:32/little-unsigned-integer, ItemID, 1, Category, A, B:32/little-unsigned-integer,
		File/binary >>);

%% @todo A and B are unknown.
%% @see item_equip
event({item_unequip, ItemID, TargetGID, TargetLID, A, B}) ->
	GID = get(gid),
	Category = case ItemID of
		% units would be 8, traps would be 12
		19 -> 2; % armor
		Y when Y =:= 5; Y =:= 6; Y =:= 7 -> 0; % clothes
		_ -> 1 % weapons
	end,
	send(<< 16#01050300:32, 0:64, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer,
		0:64, TargetGID:32/little-unsigned-integer, TargetLID:32/little-unsigned-integer, ItemID, 2, Category, A, B:32/little-unsigned-integer >>);

%% @todo Just ignore the meseta price for now and send the player where he wanna be!
event(lobby_transport_request) ->
	send_0c08(true);

%% @todo Probably replenish the player HP when entering a non-mission area rather than when aborting the mission?
event(mission_abort) ->
	send_1006(11),
	{ok, User} = egs_user_model:read(get(gid)),
	%% delete the mission
	psu_instance:stop(User#egs_user_model.instancepid),
	%% full hp
	Character = User#egs_user_model.character,
	MaxHP = Character#characters.maxhp,
	NewCharacter = Character#characters{currenthp=MaxHP},
	NewUser = User#egs_user_model{character=NewCharacter, setid=0},
	egs_user_model:write(NewUser),
	%% map change
	if	User#egs_user_model.areatype =:= mission ->
			Area = User#egs_user_model.prev_area,
			area_load(Area#psu_area.questid, Area#psu_area.zoneid, Area#psu_area.mapid, User#egs_user_model.prev_entryid);
		true -> ignore
	end;

%% @todo Forward the mission start to other players of the same party, whatever their location is.
event({mission_start, QuestID}) ->
	log("mission start ~b", [QuestID]),
	send_170c(),
	send_1020(),
	send_1015(QuestID),
	send_0c02();

%% @todo Also happening a 1506 -> 1507? Only on first selection from menu.
%% @todo Also at the end send a 101a (NPC:16, PartyPos:16, ffffffff). Not sure about PartyPos.
event({npc_invite, NPCid}) ->
	GID = get(gid),
	{ok, User} = egs_user_model:read(GID),
	%% Create NPC.
	log("invited npcid ~b", [NPCid]),
	TmpNPCUser = psu_npc:user_init(NPCid, ((User#egs_user_model.character)#characters.mainlevel)#level.number),
	%% Create and join party.
	%% @todo Check if party already exists.
	{ok, PartyPid} = psu_party:start_link(GID),
	{ok, PartyPos} = psu_party:join(PartyPid, npc, TmpNPCUser#egs_user_model.id),
	NPCUser = TmpNPCUser#egs_user_model{lid=PartyPos, partypid=PartyPid},
	egs_user_model:write(NPCUser),
	egs_user_model:write(User#egs_user_model{partypid=PartyPid}),
	%% Send stuff.
	Character = NPCUser#egs_user_model.character,
	SentNPCCharacter = Character#characters{gid=NPCid},
	SentNPCUser = NPCUser#egs_user_model{id=NPCid, character=SentNPCCharacter},
	%% @todo send_022c(0, 2),
	send_1004(npc_invite, SentNPCUser, PartyPos),
	send_101a(NPCid, PartyPos);

%% @todo If the player has a scape, use it! Otherwise red screen.
%% @todo Right now we force revive and don't update the player's HP.
event(player_death) ->
	% @todo send_0115(get(gid), 16#ffffffff, LV=1, EXP=idk, Money=1000), % apparently sent everytime you die...
	%% use scape:
	NewHP = 10,
	send_0117(NewHP),
	send_1022(NewHP);
	%% red screen with return to lobby choice:
	%~ send_0111(3, 1);

%% @todo Refill the player's HP to maximum, remove SEs etc.
event(player_death_return_to_lobby) ->
	{ok, User} = egs_user_model:read(get(gid)),
	Area = User#egs_user_model.prev_area,
	area_load(Area#psu_area.questid, Area#psu_area.zoneid, Area#psu_area.mapid, User#egs_user_model.prev_entryid);

event(player_type_capabilities_request) ->
	send_0113();

%% @doc Uni cube handler.
event(unicube_request) ->
	send_021e();

%% @doc Uni selection handler.
%% @todo When selecting 'Your room', load a default room.
%% @todo When selecting 'Reload', reload the character in the current lobby.
event({unicube_select, Selection, EntryID}) ->
	case Selection of
		cancel -> ignore;
		16#ffffffff ->
			log("uni selection (my room)"),
			send_0230(),
			% 0220
			area_load(1120000, 0, 100, 0);
		_UniID ->
			log("uni selection (reload)"),
			send_0230(),
			% 0220
			%% force reloading the character and data files (@todo hack, uses myroom questid to do it)
			{ok, User} = egs_user_model:read(get(gid)),
			if	User#egs_user_model.partypid =:= undefined ->
					ignore;
				true ->
					%% @todo Replace stop by leave when leaving stops the party correctly when nobody's there anymore.
					%~ psu_party:leave(User#egs_user_model.partypid, User#egs_user_model.id)
					psu_party:stop(User#egs_user_model.partypid)
			end,
			Area = User#egs_user_model.area,
			NewRow = User#egs_user_model{partypid=undefined, area=Area#psu_area{questid=1120000, zoneid=undefined}, entryid=EntryID},
			egs_user_model:write(NewRow),
			area_load(Area#psu_area.questid, Area#psu_area.zoneid, Area#psu_area.mapid, EntryID)
	end.

%% @doc Movement (non-broadcast) handler. Do nothing.
handle(16#0102, _) ->
	ignore;

%% @doc Shop listing request. Currently return the normal item shop for everything.
%% @todo Return the other shops appropriately.
handle(16#010a, Data) ->
	<< _:32, A:32/little-unsigned-integer, B:32/little-unsigned-integer, C:32/little-unsigned-integer >> = Data,
	log("shop listing request (~b, ~b, ~b)", [A, B, C]),
	GID = get(gid),
	{ok, File} = file:read_file("p/itemshop.bin"),
	send(<< 16#010a0300:32, 0:64, GID:32/little-unsigned-integer, 0:64, 16#00011300:32,
		GID:32/little-unsigned-integer, 0:64, GID:32/little-unsigned-integer, 0:32, File/binary >>);

%% @doc Shortcut changes handler. Do nothing.
%% @todo Save it.
handle(16#0302, _) ->
	log("dismissed shortcut changes");

%% @doc Chat broadcast handler. Dispatch the message to everyone (for now).
%%      We must take extra precautions to handle different versions of the game correctly.
%%      Disregard the name sent by the server in later versions of the game. Use the name saved in memory instead, to prevent client-side editing.
%% @todo Only broadcast to people in the same map.
%% @todo In the case of NPC characters, when FromTypeID is 00001d00, check that the NPC is in the party and broadcast only to the party (probably).
%% @todo When the game doesn't find an NPC and forces it to talk like in the tutorial mission it seems FromTypeID, FromGID and Name are both 0.
handle(16#0304, Data) ->
	case get(version) of
		0 -> % AOTI v2.000
			<< FromTypeID:32/unsigned-integer, FromGID:32/little-unsigned-integer, Modifiers:128/bits, Message/bits >> = Data;
		_ -> % Above
			<< FromTypeID:32/unsigned-integer, FromGID:32/little-unsigned-integer, Modifiers:128/bits, _:512, Message/bits >> = Data
	end,

	UserGID = get(gid),
	GID = if UserGID =:= FromGID ->
			UserGID;
		true ->
			%% @todo Check that FromGID is an NPC in the UserGID's party; that UserGID is the party leader; that the message is using party chat.
			FromGID
	end,

	{ok, User} = egs_user_model:read(GID),

	[LogName|_] = re:split((User#egs_user_model.character)#characters.name, "\\0\\0", [{return, binary}]),
	[TmpMessage|_] = re:split(Message, "\\0\\0", [{return, binary}]),
	LogMessage = re:replace(TmpMessage, "\\n", " ", [global, {return, binary}]),
	log("chat from ~s: ~s", [[re:replace(LogName, "\\0", "", [global, {return, binary}])], [re:replace(LogMessage, "\\0", "", [global, {return, binary}])]]),
	{ok, List} = egs_user_model:select(all),
	lists:foreach(fun(X) -> X#egs_user_model.pid ! {psu_chat, FromTypeID, GID, (User#egs_user_model.character)#characters.name, Modifiers, Message} end, List);

%% @todo Handle this packet properly.
%% @todo Spawn cleared response event shouldn't be handled following this packet but when we see the spawn actually dead HP-wise.
handle(16#0402, Data) ->
	<< SpawnID:32/little-unsigned-integer, _:64, Type:32/little-unsigned-integer, _:64 >> = Data,
	case Type of
		7 -> % spawn cleared @todo 1201 sent back with same values apparently, but not always
			log("cleared spawn ~b", [SpawnID]),
			{ok, User} = egs_user_model:read(get(gid)),
			{BlockID, EventID} = psu_instance:spawn_cleared_event(User#egs_user_model.instancepid, (User#egs_user_model.area)#psu_area.zoneid, SpawnID),
			if	EventID =:= false -> ignore;
				true -> send_1205(EventID, BlockID, 0)
			end;
		_ ->
			ignore
	end;

%% @todo Handle this packet.
%% @todo 3rd Unsafe Passage C, EventID 10 BlockID 2 = mission cleared?
handle(16#0404, Data) ->
	<< EventID:8, BlockID:8, _:16, Value:8, _/bits >> = Data,
	log("unknown command 0404: eventid ~b blockid ~b value ~b", [EventID, BlockID, Value]),
	send_1205(EventID, BlockID, Value);

%% @todo Used in the tutorial. Not sure what it does. Give an item (the PA) maybe?
handle(16#0a09, Data) ->
	log("~p", [Data]),
	GID = get(gid),
	send(<< 16#0a090300:32, 0:32, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, 16#00003300:32, 0:32 >>);

%% @doc Item description request.
%% @todo Send something other than just "dammy".
handle(16#0a10, << ItemID:32/unsigned-integer >>) ->
	send_0a11(ItemID, "dammy");

%% @doc Counter available mission list request handler.
handle(16#0c0f, _) ->
	{ok, User} = egs_user_model:read(get(gid)),
	[{quests, _}, {bg, _}, {options, Options}] = proplists:get_value(User#egs_user_model.counterid, ?COUNTERS),
	send_0c10(Options);

%% @doc Set flag handler. Associate a new flag with the character.
%%      Just reply with a success value for now.
%% @todo God save the flags.
handle(16#0d04, Data) ->
	<< Flag:128/bits, A:16/bits, _:8, B/bits >> = Data,
	log("flag handler for ~s", [re:replace(Flag, "\\0+", "", [global, {return, binary}])]),
	GID = get(gid),
	send(<< 16#0d040300:32, 0:160, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, Flag/binary, A/binary, 1, B/binary >>);

%% @doc Options changes handler.
handle(16#0d07, Data) ->
	log("options changes"),
	% Translate options into a tuple, validate them and do nothing with it for now
	Options = psu_characters:options_binary_to_tuple(Data),
	psu_characters:validate_options(Options),
	% End of validation
	{ok, User} = egs_user_model:read(get(gid)),
	file:write_file(io_lib:format("save/~s/~b-character.options", [User#egs_user_model.folder, (User#egs_user_model.character)#characters.slot]), Data);

%% @doc Hit handler.
%% @todo Finish the work on it.
%% @todo First value at 2C is the number of hits. We don't need to know it though.
handle(16#0e00, Data) ->
	<< _:96, Hits/bits >> = Data,
	handle_hits(Hits);

%% @doc Initialize a vehicle object.
%% @todo Find what are the many values, including the odd Whut value (and whether it's used in the reply).
%% @todo Separate the reply.
handle(16#0f00, Data) ->
	<< A:32/little-unsigned-integer, 0:16, B:16/little-unsigned-integer, 0:16, C:16/little-unsigned-integer, 0, Whut:8, D:16/little-unsigned-integer, 0:16,
		E:16/little-unsigned-integer, 0:16, F:16/little-unsigned-integer, G:16/little-unsigned-integer, H:16/little-unsigned-integer, I:32/little-unsigned-integer >> = Data,
	log("init vehicle: ~b ~b ~b ~b ~b ~b ~b ~b ~b ~b", [A, B, C, Whut, D, E, F, G, H, I]),
	send(<< (header(16#1208))/binary, A:32/little-unsigned-integer, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32,
		0:16, B:16/little-unsigned-integer, 0:16, C:16/little-unsigned-integer, 0:16, D:16/little-unsigned-integer, 0:112,
		E:16/little-unsigned-integer, 0:16, F:16/little-unsigned-integer, H:16/little-unsigned-integer, 1, 0, 100, 0, 10, 0, G:16/little-unsigned-integer, 0:16 >>);

%% @doc Enter vehicle.
%% @todo Separate the reply.
handle(16#0f02, Data) ->
	<< A:32/little-unsigned-integer, B:32/little-unsigned-integer, C:32/little-unsigned-integer >> = Data,
	log("enter vehicle: ~b ~b ~b", [A, B, C]),
	HP = 100,
	send(<< (header(16#120a))/binary, A:32/little-unsigned-integer, B:32/little-unsigned-integer, C:32/little-unsigned-integer, HP:32/little-unsigned-integer >>);

%% @doc Sent right after entering the vehicle. Can't move without it.
%% @todo Separate the reply.
handle(16#0f07, Data) ->
	<< A:32/little-unsigned-integer, B:32/little-unsigned-integer >> = Data,
	log("after enter vehicle: ~b ~b", [A, B]),
	send(<< (header(16#120f))/binary, A:32/little-unsigned-integer, B:32/little-unsigned-integer >>);

%% @doc Object event handler.
%% @todo Handle all events appropriately.
%% @todo B should be the ObjType.
handle(16#0f0a, Data) ->
	<< BlockID:16/little-unsigned-integer, ListNb:16/little-unsigned-integer, ObjectNb:16/little-unsigned-integer, _MapID:16/little-unsigned-integer, ObjectID:16/little-unsigned-integer,
		_:16, A:32/little-unsigned-integer, B:32/little-unsigned-integer, _:32, C:32/little-unsigned-integer, _:272, Action:8, _/bits >> = Data,
	log("object event handler: action ~b object ~b a ~b b ~b c ~b", [Action, ObjectID, A, B, C]),
	case Action of
		0 -> % warp
			{ok, User} = egs_user_model:read(get(gid)),
			Pos = psu_instance:warp_event(User#egs_user_model.instancepid, (User#egs_user_model.area)#psu_area.zoneid, BlockID, ListNb, ObjectNb),
			NewUser = User#egs_user_model{pos=Pos},
			egs_user_model:write(NewUser),
			send_0503(User#egs_user_model.pos),
			send_1211(A, C, B, 0);
		3 -> % crystal activation
			send_1213(ObjectID, 1);
		4 -> % enter boss gate
			send_1213(ObjectID, 1);
		5 -> % leave boss gate
			% probably 1213, unknown last value
			ignore;
		6 -> % activate boss gate
			send_1213(ObjectID, 0),
			send_1215(2, 16#7008),
			%% @todo Sent after warp but not necessarily, also what's 37 (should be a B1 object) and why resend the 1213(id)?
			send_1213(37, 0),
			send_1213(ObjectID, 0);
		9 -> % healing pad
			% 0117, 0111, 0117?
			ignore;
		12 -> % pick/use key, pick vehicle_boost
			{ok, User} = egs_user_model:read(get(gid)),
			Args = psu_instance:std_event(User#egs_user_model.instancepid, (User#egs_user_model.area)#psu_area.zoneid, ObjectID),
			case Args of
				undefined -> %% vehicle boost doesn't send an event
					ignore;
				{BlockID, [EventID|_]} ->
					send_1205(EventID, BlockID, 0)
			end,
			send_1213(ObjectID, 1);
		13 -> % floor_button on (also sent when clearing a few of the rooms in black nest)
			{ok, User} = egs_user_model:read(get(gid)),
			{BlockID, EventID} = psu_instance:std_event(User#egs_user_model.instancepid, (User#egs_user_model.area)#psu_area.zoneid, ObjectID),
			send_1205(EventID, BlockID, 0),
			send_1213(ObjectID, 1);
		14 -> % floor_button off
			%% @todo Apparently when it's not a floor_button but a light switch, this here should be handled differently.
			{ok, User} = egs_user_model:read(get(gid)),
			{BlockID, EventID} = psu_instance:std_event(User#egs_user_model.instancepid, (User#egs_user_model.area)#psu_area.zoneid, ObjectID),
			send_1205(EventID, BlockID, 1),
			send_1213(ObjectID, 0);
		%~ 19 -> % activate trap
			%~ ignore;
		20 -> % enter counter/elevator/room/spaceport/pick key/use key
			ignore;
		23 -> % initialize key slots (called when picking a key or checking the gate directly with no key)
			{ok, User} = egs_user_model:read(get(gid)),
			{BlockID, [_, EventID, _]} = psu_instance:std_event(User#egs_user_model.instancepid, (User#egs_user_model.area)#psu_area.zoneid, ObjectID),
			send_1205(EventID, BlockID, 0); % in block 1, 202 = key [1] x1, 203 = key [-] x1
		24 -> % open gate (only when client has key)
			{ok, User} = egs_user_model:read(get(gid)),
			{BlockID, [_, _, EventID]} = psu_instance:std_event(User#egs_user_model.instancepid, (User#egs_user_model.area)#psu_area.zoneid, ObjectID),
			send_1205(EventID, BlockID, 0),
			send_1213(ObjectID, 1);
		25 -> % sit on chair
			send_1211(A, C, 8, 0);
		26 -> % sit out of chair
			send_1211(A, C, 8, 2);
		28 -> % respawn object picked (like vehicle_boost)
			send_1213(ObjectID, 0);
		%~ 30 -> % @todo (phantom ruins block 4, dark god 2 block 1 (fake key block))
			%~ ignore;
		_ ->
			log("object event ~b", [Action])
	end;

%% @todo Not sure yet.
handle(16#1019, Data) ->
	<< Value:32/little-unsigned-integer >> = Data,
	log("command 1019 with value ~b", [Value]);
	%~ send(<< (header(16#1019))/binary, 0:192, 16#00200000:32, 0:32 >>);

%% @todo Not sure about that one though. Probably related to 1112 still.
handle(16#1106, Data) ->
	send_110e(Data);

%% @doc Probably asking permission to start the video (used for syncing?).
handle(16#1112, Data) ->
	send_1113(Data);

%% @todo Not sure yet. Value is probably a TargetID. Used in Airboard Rally. Replying with the same value starts the race.
handle(16#1216, Data) ->
	<< Value:32/little-unsigned-integer >> = Data,
	log("command 1216 with value ~b", [Value]),
	send_1216(Value);

%% @doc Party information recap request.
%% @todo Handle when the party already exists! And stop doing it wrong.
handle(16#1705, _) ->
	{ok, User} = egs_user_model:read(get(gid)),
	send_1706((User#egs_user_model.character)#characters.name);

%% @doc Mission selected handler. Send the currently selected mission.
%% @todo Probably need to dispatch that info to other party members in the same counter.
handle(16#1707, _) ->
	ignore;

%% @doc Party settings request handler. Item distribution is random for now.
%% @todo Handle correctly.
handle(16#1709, _) ->
	send_170a();

%% @doc Counter-related handler.
handle(16#170b, _) ->
	send_170c();

%% @doc Counter initialization handler? Send the code for the background image to use.
%% @todo Handle correctly.
handle(16#1710, _) ->
	{ok, User} = egs_user_model:read(get(gid)),
	[{quests, _}, {bg, Background}, {options, _}] = proplists:get_value(User#egs_user_model.counterid, ?COUNTERS),
	send_1711(Background);

%% @doc Dialog request handler. Do what we can.
%% @todo Handle correctly.
handle(16#1a01, Data) ->
	<< _:32, A:8, B:8, _:16, C:8, _/bits >> = Data,
	case [A, B, C] of
		[ 0, 0, 2] ->
			log("lumilass (and more?)"),
			send_1a03();
		[ 0, 0, 3] ->
			log("pp cube"),
			send_1a04();
		[ 0, 0, 9] ->
			log("types menu"),
			send_1a07();
		[80, 0, _] ->
			log("npc dialog choice"),
			send_1a02(0, 17, 17, 3, 9);
		[90, 0, _] -> % All the replies from here are consistent but their effect is unknown.
			log("1a01 unknown (~b ~b ~b)", [A, B, C]),
			send_1a02(0, 5, 1, 4, 5);
		[91, 0, _] ->
			log("1a01 unknown (~b ~b ~b)", [A, B, C]),
			send_1a02(0, 5, 5, 4, 7);
		[92, 0, _] ->
			log("1a01 unknown (~b ~b ~b)", [A, B, C]),
			send_1a02(0, 5, 0, 4, 0);
		[93, 0, _] ->
			log("1a01 unknown (~b ~b ~b)", [A, B, C]),
			send_1a02(0, 5, 18, 4, 0);
		[ _, 2, _] ->
			log("1a01 unknown (~b ~b ~b)", [A, B, C]),
			send_1a02(0, 0, 1, 0, 0);
		_ ->
			log("1a01 unknown (~b ~b ~b) - do nothing", [A, B, C])
	end;

%% @doc Unknown command handler. Do nothing.
handle(Command, _) ->
	log("dismissed packet ~4.16.0b", [Command]).

%% @doc Handle all hits received.
%% @todo Finish the work on it.
%% @todo Type EXP.
%% @todo Boxes give EXP too but it doesn't show up on the screen.

%~ log_hits(Data) ->
	%~ <<	A:32/unsigned-integer, B:32/unsigned-integer, C:32/unsigned-integer, D:32/unsigned-integer,
		%~ E:32/unsigned-integer, F:32/unsigned-integer, G:32/unsigned-integer, H:32/unsigned-integer,
		%~ I:32/unsigned-integer, J:32/unsigned-integer, K:32/unsigned-integer, L:32/unsigned-integer,
		%~ M:32/unsigned-integer, N:32/unsigned-integer, O:32/unsigned-integer, P:32/unsigned-integer,
		%~ Q:32/unsigned-integer, R:32/unsigned-integer, S:32/unsigned-integer, T:32/unsigned-integer, _/bits >> = Data,
	%~ log("hit!~n    ~8.16.0b ~8.16.0b ~8.16.0b ~8.16.0b~n    ~8.16.0b ~8.16.0b ~8.16.0b ~8.16.0b~n    ~8.16.0b ~8.16.0b ~8.16.0b ~8.16.0b~n    ~8.16.0b ~8.16.0b ~8.16.0b ~8.16.0b~n    ~8.16.0b ~8.16.0b ~8.16.0b ~8.16.0b", [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T]).

handle_hits(<< >>) ->
	ok;
handle_hits(Data) ->
	%~ log_hits(Data),
	% parse
	<< A:224/bits, B:128/bits, _:288, Rest/bits >> = Data,
	<< _:96, SourceID:32/little-unsigned-integer, TargetID:32/little-unsigned-integer, _/bits >> = A,
	% retrieve
	GID = get(gid),
	{ok, User} = egs_user_model:read(GID),
	% hit!
	#hit_response{type=Type, user=NewUser, exp=HasEXP, damage=Damage, targethp=TargetHP, targetse=TargetSE, events=Events} = psu_instance:hit(User, SourceID, TargetID),
	case Type of
		box ->
			% TODO: also has a hit sent, we should send it too
			handle_events(Events);
		_ ->
			PlayerHP = (NewUser#egs_user_model.character)#characters.currenthp,
			case lists:member(death, TargetSE) of
				true -> SE = 16#01000200;
				false -> SE = 16#01000000
			end,
			send(<< 16#0e070300:32, 0:160, 16#00011300:32, GID:32/little-unsigned-integer, 0:64,
				1:32/little-unsigned-integer, 16#01050000:32, Damage:32/little-unsigned-integer,
				A/binary, 0:64, PlayerHP:32/little-unsigned-integer, 0:32, SE:32,
				0:32, TargetHP:32/little-unsigned-integer, 0:32, B/binary, 16#04320000:32, 16#80000000:32, 16#26030000:32, 16#89068d00:32, 16#0c1c0105:32, 0:64 >>)
				% after TargetHP is SE-related too?
	end,
	% exp
	if	HasEXP =:= true ->
			Character = NewUser#egs_user_model.character,
			Level = Character#characters.mainlevel,
			send_0115(GID, TargetID, Level#level.number, Level#level.exp, Character#characters.money);
		true -> ignore
	end,
	% save
	egs_user_model:write(NewUser),
	% next
	handle_hits(Rest).

%% @doc Handle a list of events.
handle_events([]) ->
	ok;
handle_events([{explode, ObjectID}|Tail]) ->
	send_1213(ObjectID, 3),
	handle_events(Tail);
handle_events([{event, [BlockID, EventID]}|Tail]) ->
	send_1205(EventID, BlockID, 0),
	handle_events(Tail).

%% @doc Build the packet header.
header(Command) ->
	GID = get(gid),
	<< Command:16/unsigned-integer, 16#0300:16, 0:160, 16#00011300:32, GID:32/little-unsigned-integer, 0:64 >>.

%% @doc Send the given packet to the client.
%% @todo Consolidate the receive and send functions better.
send(Packet) ->
	psu_proto:packet_send(get(socket), Packet).

%% @todo Figure out what this does compared to 0201(self).
%% @todo Figure out the unknown values.
%% @todo Probably don't pattern match the data like this...
send_010d(User) ->
	GID = get(gid),
	CharGID = User#egs_user_model.id,
	CharLID = User#egs_user_model.lid,
	<< _:640, CharBin/bits >> = psu_characters:character_user_to_binary(User),
	send(<< 16#010d0300:32, 0:160, 16#00011300:32, GID:32/little-unsigned-integer, 0:64,
		1:32/little-unsigned-integer, 0:32, 16#00000300:32, 16#ffff0000:32, 0:32, CharGID:32/little-unsigned-integer,
		0:192, CharGID:32/little-unsigned-integer, CharLID:32/little-unsigned-integer, 16#ffffffff:32, CharBin/binary >>).

%% @todo Possibly related to 010d. Just send seemingly safe values.
send_0111(A, B) ->
	GID = get(gid),
	send(<< 16#01110300:32, 0:64, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:64,
		GID:32/little-unsigned-integer, 0:32, A:32/little-unsigned-integer, B:32/little-unsigned-integer >>).

%% @todo Types capability list.
send_0113() ->
	{ok, File} = file:read_file("p/typesinfo.bin"),
	GID = get(gid),
	send(<< 16#01130300:32, 0:64, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, GID:32/little-unsigned-integer, File/binary >>).

%% @doc Update the character's EXP.
send_0115(GID, TargetID, LV, EXP, Money) ->
	send(<< 16#01150300:32, 0:64, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, GID:32/little-unsigned-integer,
		0:32, TargetID:32/little-unsigned-integer, LV:32/little-unsigned-integer, 0:32, 0:32, EXP:32/little-unsigned-integer, 0:32, Money:32/little-unsigned-integer, 16#f5470500:32, 0:96, 0:64,
		16#01000000:32, 16#01000000:32, 16#01000000:32, 16#01000000:32, 16#01000000:32, 16#01000000:32, 16#01000000:32, 16#01000000:32,
		16#01000000:32, 16#01000000:32, 16#01000000:32, 16#01000000:32, 16#01000000:32, 16#01000000:32, 16#01000000:32, 16#01000000:32 >>).

%% @doc Revive player?
%% @todo Figure out more of it.
send_0117(HP) ->
	GID = get(gid),
	send(<< 16#01170300:32, 0:64, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:64,
		GID:32/little-unsigned-integer, 0:96, HP:32/little-unsigned-integer, 0:32 >>).

%% @doc Send the zone initialization notification.
send_0200(ZoneType) ->
	case ZoneType of
		mission ->
			Var = << 16#06000500:32, 16#01000000:32, 0:64, 16#00040000:32, 16#00010000:32, 16#00140000:32 >>;
		myroom ->
			Var = << 16#06000000:32, 16#02000000:32, 0:64, 16#40000000:32, 16#00010000:32, 16#00010000:32 >>;
		_ ->
			Var = << 16#00040000:32, 0:160, 16#00140000:32 >>
	end,
	send(<< (header(16#0200))/binary, 0:32, 16#01000000:32, 16#ffffffff:32, Var/binary, 16#ffffffff:32, 16#ffffffff:32 >>).

%% @todo Figure out what the other things are.
%% @todo Handle LID correctly (should be ffffffff for self, apparently).
send_0201(User) ->
	GID = get(gid),
	CharGID = User#egs_user_model.id,
	CharBin = psu_characters:character_user_to_binary(User),
	IsGM = 0,
	OnlineStatus = 0,
	GameVersion = 0,
	send(<< 16#02010300:32, 0:32, 16#00001200:32, CharGID:32/little-unsigned-integer, 0:64, 16#00011300:32,
		GID:32/little-unsigned-integer, 0:64, CharBin/binary, IsGM:8, 0:8, OnlineStatus:8, GameVersion:8, 0:608 >>).

%% @doc Hello packet, always sent on client connection.
send_0202() ->
	send(<< 16#02020300:32, 0:352 >>).

%% @todo Not sure. Used for unspawning, and more.
send_0204(PlayerGID, PlayerLID, Action) ->
	GID = get(gid),
	send(<< 16#02040300:32, 0:32, 16#00001200:32, PlayerGID:32/little-unsigned-integer, 0:64,
		16#00011300:32, GID:32/little-unsigned-integer, 0:64, PlayerGID:32/little-unsigned-integer,
		PlayerLID:32/little-unsigned-integer, Action:32/little-unsigned-integer >>).

%% @doc Send the map ID to be loaded by the client.
%% @todo Last two values are unknown.
send_0205(MapType, MapNumber, MapEntry, IsSeasonal) ->
	send(<< 16#02050300:32, 0:288, 16#ffffffff:32, MapType:32/little-unsigned-integer,
		MapNumber:32/little-unsigned-integer, MapEntry:32/little-unsigned-integer, 0:56, IsSeasonal >>).

%% @doc Indicate to the client that loading should finish.
%% @todo Last value seems to be 2 most of the time. Never 0 though. Apparently counters have it at 4.
send_0208() ->
	send(<< (header(16#0208))/binary, 2:32/little-unsigned-integer >>).

%% @todo No idea what this one does. For unknown reasons it uses channel 2.
send_020c() ->
	send(<< 16#020c020c:32, 16#fffff20c:32, 0:256 >>).

%% @doc Send the quest file to be loaded.
%% @todo Probably should try sending the checksum like value (right before the file) and see if it magically fixes anything.
send_020e(Filename) ->
	{ok, File} = file:read_file(Filename),
	Size = byte_size(File),
	send(<< 16#020e0300:32, 0:288, Size:32/little-unsigned-integer, 0:32, File/binary, 0:32 >>).

%% @doc Send the zone file to be loaded.
send_020f(Filename, SetID, SeasonID) ->
	{ok, File} = file:read_file(Filename),
	Size = byte_size(File),
	send(<< 16#020f0300:32, 0:288, SetID, SeasonID, 0:16, Size:32/little-unsigned-integer, File/binary >>).

%% @doc Send the current UNIX time.
send_0210() ->
	CurrentTime = calendar:datetime_to_gregorian_seconds(calendar:now_to_universal_time(now()))
		- calendar:datetime_to_gregorian_seconds({{1970, 1, 1}, {0, 0, 0}}),
	send(<< (header(16#0210))/binary, 0:32, CurrentTime:32/little-unsigned-integer >>).

%% @todo No idea what this do. Nor why it's sent twice when loading a counter.
send_0215(N) ->
	send(<< (header(16#0215))/binary, N:32/little-unsigned-integer >>).

%% @todo End of character loading. Just send it.
send_021b() ->
	send(header(16#021b)).

%% @doc Send the list of available universes.
send_021e() ->
	{ok, Count} = egs_user_model:count(),
	[StrCount] = io_lib:format("~b", [Count]),
	Unis = [{16#ffffffff, center, "Your Room", ""}, {1, justify, "Reload", "     "}, {2, justify, "EGS Test", StrCount}],
	NbUnis = length(Unis),
	Bin = send_021e_build(Unis, []),
	send(<< 16#021e0300:32, 0:288, NbUnis:32/little-unsigned-integer, Bin/binary >>).

send_021e_build([], Acc) ->
	iolist_to_binary(lists:reverse(Acc));
send_021e_build([{ID, Align, Name, Pop}|Tail], Acc) ->
	UCS2Name = << << X:8, 0:8 >> || X <- Name >>,
	UCS2Pop = << << X:8, 0:8 >> || X <- Pop >>,
	NamePadding = 8 * (32 - byte_size(UCS2Name)),
	PopPadding = 8 * (12 - byte_size(UCS2Pop)),
	IntAlign = case Align of justify -> 643; center -> 0 end,
	send_021e_build(Tail, [<< ID:32/little-unsigned-integer, 0:16, IntAlign:16/little-unsigned-integer, UCS2Name/binary, 0:NamePadding, UCS2Pop/binary, 0:PopPadding >>|Acc]).

%% @doc Send the current universe name and number.
%% @todo Currently only have universe number 2, named EGS Test.
send_0222() ->
	UCS2Name = << << X:8, 0:8 >> || X <- "EGS Test" >>,
	GID = get(gid),
	send(<< 16#02220300:32, 0:32, 16#00001200:32, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:64,
		2:32/little-unsigned-integer, 0:32, UCS2Name/binary, 0:16 >>).

%% @todo No idea!
send_022c(A, B) ->
	send(<< (header(16#022c))/binary, A:16/little-unsigned-integer, B:16/little-unsigned-integer >>).

%% @todo Not sure. Sent when going to or from room.
send_0230() ->
	GID = get(gid),
	send(<< 16#02300300:32, 0:32, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:64 >>).

%% @todo Figure out what the other things are.
send_0233(Users) ->
	NbUsers = length(Users),
	case NbUsers of
		0 ->
			ignore;
		_ ->
			GID = get(gid),
			Header = << 16#02330300:32, 0:32, 16#00001200:32, GID:32/little-unsigned-integer, 0:64, 16#00011300:32,
				GID:32/little-unsigned-integer, 0:64, NbUsers:32/little-unsigned-integer >>,
			Contents = build_0233_contents(Users),
			send(<< Header/binary, Contents/binary >>)
	end.

%% @todo God this function is ugly. Use tail recursion!
%% @todo Do it properly without relying on the temporary file.
build_0233_contents([]) ->
	<< >>;
build_0233_contents(Users) ->
	[User|Rest] = Users,
	LID = 16#010000 + User#egs_user_model.lid, % @todo The LID must be 16 bits and 0233 seems to (almost always) require that 01 right there...
	CharBin = psu_characters:character_user_to_binary(User#egs_user_model{lid=LID}),
	IsGM = 0,
	GameVersion = 0,
	Chunk = << CharBin/binary, IsGM:8, 0:8, GameVersion:8, 0:8 >>,
	Next = build_0233_contents(Rest),
	<< Chunk/binary, Next/binary >>.

%% @doc Center the camera on the player, if possible.
%% @todo Probably.
send_0236() ->
	send(header(16#0236)).

%% @doc Send a chat command. Handled differently at v2.0000 and all versions starting somewhere above that.
send_0304(FromTypeID, FromGID, FromName, Modifiers, Message) ->
	case get(version) of
		0 -> send(<< 16#03040300:32, 0:288, FromTypeID:32/unsigned-integer, FromGID:32/little-unsigned-integer, Modifiers:128/bits, Message/bits >>);
		_ -> send(<< 16#03040300:32, 0:288, FromTypeID:32/unsigned-integer, FromGID:32/little-unsigned-integer, Modifiers:128/bits, FromName:512/bits, Message/bits >>)
	end.

%% @todo Force send a new player location. Used for warps.
%% @todo The value before IntDir seems to be the player's current animation. 01 stand up, 08 ?, 17 normal sit
send_0503(#pos{x=PrevX, y=PrevY, z=PrevZ, dir=_}) ->
	{ok, User} = egs_user_model:read(get(gid)),
	#egs_user_model{id=GID, pos=#pos{x=X, y=Y, z=Z, dir=Dir}, area=#psu_area{questid=QuestID, zoneid=ZoneID, mapid=MapID}, entryid=EntryID} = User,
	IntDir = trunc(Dir * 182.0416),
	send(<< 16#05030300:32, 0:64, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, GID:32/little-unsigned-integer, 0:32,
		16#1000:16, IntDir:16/little-unsigned-integer, PrevX:32/little-float, PrevY:32/little-float, PrevZ:32/little-float, X:32/little-float, Y:32/little-float, Z:32/little-float,
		QuestID:32/little-unsigned-integer, ZoneID:32/little-unsigned-integer, MapID:32/little-unsigned-integer, EntryID:32/little-unsigned-integer, 1:32/little-unsigned-integer >>).

%% @todo NPC inventory. Guessing it's only for NPC characters...
send_0a04(NPCGID) ->
	GID = get(gid),
	{ok, Bin} = file:read_file("p/packet0a04.bin"),
	send(<< 16#0a040300:32, 0:32, 16#00001d00:32, NPCGID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, Bin/binary >>).

%% @todo Inventory related. No idea what it does.
send_0a05() ->
	send(header(16#0a05)).

%% @todo Inventory related. Figure out everything in this packet and handle it correctly.
%% @todo It sends 60 values so it's probably some kind of options for all 60 items in the inventory?
send_0a06() ->
	{ok, << _:32, A:96/bits, _:32, B:96/bits, _:32, C:1440/bits, _:32, D/bits >>} = file:read_file("p/packet0a06.bin"),
	GID = get(gid),
	send(<< A/binary, GID:32/little-unsigned-integer, B/binary, GID:32/little-unsigned-integer, C/binary, GID:32/little-unsigned-integer, D/binary >>).

%% @todo Inventory. Figure out everything in this packet and handle it correctly.
send_0a0a() ->
	{ok, << _:32, A:224/bits, _:32, B/bits >>} = file:read_file("p/packet0a0a.bin"),
	GID = get(gid),
	send(<< A/binary, GID:32/little-unsigned-integer, B/binary >>).

%% @doc Item description.
send_0a11(ItemID, ItemDesc) ->
	Size = 1 + length(ItemDesc),
	UCS2Desc = << << X:8, 0:8 >> || X <- ItemDesc >>,
	send(<< (header(16#0a11))/binary, ItemID:32/unsigned-integer, Size:32/little-unsigned-integer, UCS2Desc/binary, 0:16 >>).

%% @doc Init quest.
send_0c00(QuestID) ->
	send(<< (header(16#0c00))/binary, QuestID:32/little-unsigned-integer,
		16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32,
		16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32,
		16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32,
		16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32 >>).

%% @todo Figure out last 4 bytes!
send_0c02() ->
	send(<< (header(16#0c02))/binary, 0:32 >>).

%% @doc Send the huge pack of quest files available in the counter.
send_0c06(Filename) ->
	{ok, << File/bits >>} = file:read_file(Filename),
	send(<< 16#0c060300:32, 0:288, 1:32/little-unsigned-integer, File/binary >>).

%% @doc Reply whether the player is allowed to use the transport option.
%%      Use true for allowing it, and false otherwise.
send_0c08(Response) ->
	Value = if Response =:= true -> 0; true -> 1 end,
	send(<< (header(16#0c08))/binary, Value:32 >>).

%% @doc Send the trial start notification.
send_0c09() ->
	send(<< (header(16#0c09))/binary, 0:64 >>).

%% @doc Send the counter's mission options (0 = invisible, 2 = disabled, 3 = available).
send_0c10(Options) ->
	GID = get(gid),
	send(<< 16#0c100300:32, 0:32, 16#00011300:32, GID:32/little-unsigned-integer, 0:64,
		16#00011300:32, GID:32/little-unsigned-integer, 0:64, Options/binary >>).

%% @doc Send the data for the selected character.
%% @todo The large chunk of 0s can have some values set... but what are they used for?
%% @todo The values after the Char variable are the flags. Probably use bits to define what flag is and isn't set. Handle correctly.
send_0d01(User) ->
	CharBin = psu_characters:character_tuple_to_binary(User#egs_user_model.character),
	OptionsBin = psu_characters:options_tuple_to_binary((User#egs_user_model.character)#characters.options),
	send(<< (header(16#0d01))/binary, CharBin/binary,
		16#ffbbef1c:32, 16#f8ff0700:32, 16#fc810916:32, 16#7802134c:32,
		16#b0c0040f:32, 16#7cf0e583:32, 16#b7bce0c6:32, 16#7ff8f963:32,
		16#3fd7ffff:32, 16#fff7ffff:32, 16#f3ff63e0:32, 16#1fe00000:32,
		0:7744, OptionsBin/binary >>).

%% @doc Send the character list for selection.
%% @todo There's a few odd values blanked, also the last known location apparently.
send_0d03(Data0, Data1, Data2, Data3) ->
	[{status, Status0}, {char, Char0}|_] = Data0,
	[{status, Status1}, {char, Char1}|_] = Data1,
	[{status, Status2}, {char, Char2}|_] = Data2,
	[{status, Status3}, {char, Char3}|_] = Data3,
	GID = get(gid),
	send(<< 16#0d030300:32/unsigned-integer, 0:32, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:104,
		Status0:8/unsigned-integer, 0:48, Char0/binary, 0:520,
		Status1:8/unsigned-integer, 0:48, Char1/binary, 0:520,
		Status2:8/unsigned-integer, 0:48, Char2/binary, 0:520,
		Status3:8/unsigned-integer, 0:48, Char3/binary, 0:512 >>).

%% @doc Send the character flags list. This is the whole list of available values, not the character's.
%%      Sent without fragmentation on official for unknown reasons. Do the same here.
send_0d05() ->
	{ok, Flags} = file:read_file("p/flags.bin"),
	GID = get(gid),
	Packet = << 16#0d050300:32, 0:32, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, Flags/binary >>,
	Size = 4 + byte_size(Packet),
	ssl:send(get(socket), << Size:32/little-unsigned-integer, Packet/binary >>).

%% @todo Add a character (NPC or real) to the party members on the right of the screen.
%% @todo NPCid is 65535 for normal characters.
%% @todo Apparently the 4 location ids are set to 0 when inviting an NPC in the lobby - NPCs have their location set to 0 when in lobby; also odd value before PartyPos related to missions
%% @todo Not sure about LID. But seems like it.
send_1004(Type, User, PartyPos) ->
	[TypeID, LID, SomeFlag] = case Type of
		npc_mission -> [16#00001d00, PartyPos, 2];
		npc_invite -> [0, 16#ffffffff, 3];
		_ -> 1 %% seems to be for players
	end,

	#egs_user_model{id=GID, character=Character, area={psu_area, QuestID, ZoneID, MapID}, entryid=EntryID} = User,
	#characters{npcid=NPCid, name=Name, mainlevel=MainLevel} = Character,
	Level = MainLevel#level.number,
	send(<< (header(16#1004))/binary, TypeID:32,
		GID:32/little-unsigned-integer, 0:64, Name/binary,
		Level:16/little-unsigned-integer, 16#ffff:16,
		SomeFlag, 1, PartyPos:8, 1,
		NPCid:16/little-unsigned-integer, 0:16,

		%% Odd unknown values. PA related? No idea. Values on invite, 0 in-mission.
		16#00001f08:32, 0:32, 16#07000000:32,
		16#04e41f08:32, 0:32, 16#01000000:32,
		16#64e41f08:32, 0:32, 16#02000000:32,
		16#64e41f08:32, 0:32, 16#03000000:32,
		16#64e41f08:32, 0:32, 16#12000000:32,
		16#24e41f08:32,

		QuestID:32/little-unsigned-integer, ZoneID:32/little-unsigned-integer, MapID:32/little-unsigned-integer, EntryID:32/little-unsigned-integer,
		LID:32,
		0:64,
		16#01000000:32, 16#01000000:32, %% @todo first is current hp, second is max hp
		0:608 >>).

%% @todo Figure out what the packet is.
send_1005(Name) ->
	{ok, File} = file:read_file("p/packet1005.bin"),
	<< _:352, Before:160/bits, _:608, After/bits >> = File,
	GID = get(gid),
	send(<< (header(16#1005))/binary, Before/binary, GID:32/little-unsigned-integer, 0:64, Name/binary, After/binary >>).

%% @doc Party-related command probably controlling the party state.
%%      Value 11 aborts the mission.
%% @todo Figure out what the packet is.
send_1006(N) ->
	send(<< (header(16#1006))/binary, N:32/little-unsigned-integer >>).

%% @doc Send the player's current location.
send_100e(QuestID, ZoneID, MapID, Location, CounterID) ->
	UCS2Location = << << X:8, 0:8 >> || X <- Location >>,
	Packet = << (header(16#100e))/binary, 1:32/little-unsigned-integer, MapID:16/little-unsigned-integer,
		ZoneID:16/little-unsigned-integer, QuestID:32/little-unsigned-integer, UCS2Location/binary >>,
	PaddingSize = (128 - byte_size(Packet) - 8) * 8,
	case CounterID of
		16#ffffffff ->
			Footer = << CounterID:32/little-unsigned-integer, 0:32 >>;
		_ ->
			Footer = << CounterID:32/little-unsigned-integer, 1:32/little-unsigned-integer >>
	end,
	send(<< Packet/binary, 0:PaddingSize, Footer/binary >>).

%% @todo No idea. Also the 2 PartyPos in the built packet more often than not match, but sometimes don't?
send_100f(NPCid, PartyPos) ->
	send(<< (header(16#100f))/binary, NPCid:16/little-unsigned-integer, 1, PartyPos:8, PartyPos:32/little-unsigned-integer >>).

%% @doc Send the mission's quest file when starting a new mission.
%% @todo Handle correctly. 0:32 is actually a missing value. Value before that is unknown too.
send_1015(QuestID) ->
	[{type, _}, {file, QuestFile}|_] = proplists:get_value(QuestID, ?QUESTS),
	{ok, File} = file:read_file(QuestFile),
	Size = byte_size(File),
	send(<< (header(16#1015))/binary, QuestID:32/little-unsigned-integer, 16#01010000:32, 0:32, Size:32/little-unsigned-integer, File/binary >>).

%% @todo No idea.
send_1016(PartyPos) ->
	send(<< (header(16#1016))/binary, PartyPos:32/little-unsigned-integer >>).

%% @todo No idea.
send_101a(NPCid, PartyPos) ->
	send(<< (header(16#101a))/binary, NPCid:16/little-unsigned-integer, PartyPos:16/little-unsigned-integer, 16#ffffffff:32 >>).

%% @todo Totally unknown.
send_1020() ->
	send(header(16#1020)).

%% @doc Update HP in the party members information on the left.
%% @todo Figure out more of it.
send_1022(HP) ->
	GID = get(gid),
	send(<< 16#10220300:32, 0:160, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, HP:32/little-unsigned-integer, 0:32 >>).

%% @todo Boss related command.
send_110e(Data) ->
	send(<< (header(16#110e))/binary, Data/binary, 0:32, 5:16/little-unsigned-integer, 12:16/little-unsigned-integer, 0:32, 260:32/little-unsigned-integer >>).

%% @todo Boss related command.
send_1113(Data) ->
	send(<< (header(16#1113))/binary, Data/binary >>).

%% @todo Figure out what this packet does. Sane values for counter and missions for now.
send_1202() ->
	send(<< (header(16#1202))/binary, 0:32, 16#10000000:32, 0:64, 16#14000000:32, 0:32 >>).

%% @todo Figure out what this packet does. Seems it's the same values all the time.
send_1204() ->
	send(<< (header(16#1204))/binary, 0:32, 16#20000000:32, 0:256 >>).

%% @doc Object events response?
%% @todo Not sure what Value does exactly. It's either 0 or 1.
send_1205(EventID, BlockID, Value) ->
	send(<< (header(16#1205))/binary, EventID, BlockID, 0:16, Value, 0:24 >>).

%% @todo Figure out what this packet does. Sane values for counter and missions for now.
send_1206() ->
	send(<< (header(16#1206))/binary, 0:32, 16#80020000:32, 0:5120 >>).

%% @todo Figure out what this packet does. Sane values for counter and missions for now.
send_1207() ->
	Chunk = << 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 16#ffffffff:32, 0:224, 16#0000ffff:32, 16#ff000000:32, 16#64000a00:32 >>,
	send(<< (header(16#1207))/binary, Chunk/binary, Chunk/binary, Chunk/binary, Chunk/binary, Chunk/binary, Chunk/binary >>).

%% @todo Object interaction? Figure out. C probably the interaction type.
send_1211(A, B, C, D) ->
	send(<< (header(16#1211))/binary, A:32/little-unsigned-integer, B:32/little-unsigned-integer, C:32/little-unsigned-integer, D:32/little-unsigned-integer >>).

%% @doc Make the client load the quest previously sent.
send_1212() ->
	send(<< (header(16#1212))/binary, 0:19200 >>).

%% @todo Not sure. Related to keys.
send_1213(A, B) ->
	send(<< (header(16#1213))/binary, A:32/little-unsigned-integer, B:32/little-unsigned-integer >>).

%% @todo Related to boss gates.
send_1215(A, B) ->
	send(<< (header(16#1215))/binary, A:32/little-unsigned-integer, 0:16, B:16/little-unsigned-integer >>).

%% @todo Not sure yet. Value is probably a TargetID. Used in Airboard Rally. Replying with the same value starts the race.
send_1216(Value) ->
	GID = get(gid),
	send(<< 16#12160300:32, 0:32, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, 16#00011300:32, GID:32/little-unsigned-integer, 0:64, Value:32/little-unsigned-integer >>).

%% @todo Figure out this room packet.
send_1309() ->
	{ok, << _Size:32, Packet/bits >>} = file:read_file("p/packet1309.bin"),
	send(Packet).

%% @todo Figure out this room packet.
send_1332() ->
	{ok, << _Size:32, Packet/bits >>} = file:read_file("p/packet1332.bin"),
	send(Packet).

%% @doc Send the player's partner card.
%% @todo Find out the remaining values.
send_1500(User) ->
	#characters{slot=Slot, name=Name, race=Race, gender=Gender, class=Class} = User#egs_user_model.character,
	RaceBin = psu_characters:race_atom_to_binary(Race),
	GenderBin = psu_characters:gender_atom_to_binary(Gender),
	ClassBin = psu_characters:class_atom_to_binary(Class),
	send(<< (header(16#1500))/binary, Name/binary, RaceBin:8, GenderBin:8, ClassBin:8, 0:3112, 16#010401:24, Slot:8, 0:64 >>).

%% @todo Send an empty partner card list.
send_1501() ->
	send(<< (header(16#1501))/binary, 0:32 >>).

%% @todo Send an empty blacklist.
send_1512() ->
	send(<< (header(16#1512))/binary, 0:46080 >>).

%% @todo NPC related packet, sent when there's an NPC in the area.
send_1601() ->
	{ok, Bin} = file:read_file("p/packet1601.bin"),
	send(<< (header(16#1601))/binary, Bin/binary >>).

%% @doc Send the player's NPC and PM information.
%% @todo Do we really want to give all NPCs to everyone? Probably.
%% @todo The value 4 is the card priority. Find what 3 is. When sending, the first 0 is an unknown value.
send_1602() ->
	NbNPC = lists:sum([1 || {_NPCid, Data} <- ?NPC, Data#psu_npc.has_card =:= true]),
	Bin = iolist_to_binary([<< NPCid:8, 0, 4, 0, 3, 0:24 >> || {NPCid, Data} <- ?NPC, Data#psu_npc.has_card =:= true]),
	MiddlePaddingSize = 8 * (344 - byte_size(Bin)),
	PMName = "My PM",
	UCS2PMName = << << X:8, 0:8 >> || X <- PMName >>,
	EndPaddingSize = 8 * (64 - byte_size(UCS2PMName)),
	send(<< (header(16#1602))/binary, 0:32, Bin/binary, 0:MiddlePaddingSize, NbNPC, 0:24, UCS2PMName/binary, 0:EndPaddingSize >>).

%% @doc Party information.
%% @todo Handle existing parties.
send_1706(CharName) ->
	send(<< (header(16#1706))/binary, 16#00000300:32, 16#d5c0faff:32, 0:64, CharName/binary,
		16#78000000:32, 16#01010000:32, 0:1536, 16#0100c800:32, 16#0601010a:32, 16#ffffffff:32, 0:32 >>).

%% @doc Party settings. Item distribution is random for now.
%% @todo Handle correctly.
send_170a() ->
	send(<< (header(16#170a))/binary, 16#01010c08:32 >>).

%% @todo Find what the heck this packet is.
send_170c() ->
	{ok, File} = file:read_file("p/packet170c.bin"),
	send(<< (header(16#170c))/binary, File/binary >>).

%% @doc Send the background to use for the counter.
%% @todo Background has more info past the first byte.
send_1711(Background) ->
	send(<< (header(16#1711))/binary, Background:32/little-unsigned-integer >>).

%% @doc Unknown dialog-related handler.
%% @todo Everything!
send_1a02(A, B, C, D, E) ->
	send(<< (header(16#1a02))/binary, A:32/little-unsigned-integer, B:16/little-unsigned-integer,
		C:16/little-unsigned-integer, D:16/little-unsigned-integer, E:16/little-unsigned-integer >>).

%% @doc Lumilass handler. Possibly more.
%% @todo Figure out how Lumilass work exactly. The 4 bytes before the file may vary.
send_1a03() ->
	{ok, File} = file:read_file("p/lumilassA.bin"),
	send(<< (header(16#1a03))/binary, 0:32, File/binary >>).

%% @doc PP cube handler.
%% @todo The 4 bytes before the file may vary. Everything past that is the same. Figure things out.
send_1a04() ->
	{ok, File} = file:read_file("p/ppcube.bin"),
	send(<< (header(16#1a04))/binary, 0:32, File/binary >>).

%% @doc Types menu handler.
%% @todo Handle correctly.
send_1a07() ->
	send(<< (header(16#1a07))/binary, 16#085b5d0a:32, 16#3a200000:32, 0:32,
		16#01010101:32, 16#01010101:32, 16#01010101:32, 16#01010101:32 >>).

%% @doc Log message to the console.
log(Message) ->
	io:format("game (~p): ~s~n", [get(gid), Message]).

log(Message, Format) ->
	FormattedMessage = io_lib:format(Message, Format),
	log(FormattedMessage).
