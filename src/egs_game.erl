%	EGS: Erlang Game Server
%	Copyright (C) 2010  Loic Hoguin
%
%	This file is part of EGS.
%
%	EGS is free software: you can redistribute it and/or modify
%	it under the terms of the GNU General Public License as published by
%	the Free Software Foundation, either version 3 of the License, or
%	(at your option) any later version.
%
%	EGS is distributed in the hope that it will be useful,
%	but WITHOUT ANY WARRANTY; without even the implied warranty of
%	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%	GNU General Public License for more details.
%
%	You should have received a copy of the GNU General Public License
%	along with EGS.  If not, see <http://www.gnu.org/licenses/>.

-module(egs_game).
-export([start/0]). % external
-export([listen/0, accept/1, process/2, char_select/3, lobby_load/4, loop/3, loop/4]). % internal

-include("include/records.hrl").
-include("include/network.hrl").
-include("include/maps.hrl").

%% @doc Start the game server.

start() ->
	Pid = spawn_link(?MODULE, listen, []),
	Pid.

%% @doc Listen for connections.

listen() ->
	{ok, LSocket} = ssl:listen(?GAME_PORT, ?GAME_LISTEN_OPTIONS),
	?MODULE:accept(LSocket).

%% @doc Accept connections.

accept(LSocket) ->
	case ssl:transport_accept(LSocket, 5000) of
		{ok, CSocket} ->
			ssl:ssl_accept(CSocket),
			log(0, "hello (new connection)"),
			egs_proto:send_hello(CSocket),
			PID = spawn_link(?MODULE, process, [CSocket, 0]),
			ssl:controlling_process(CSocket, PID);
		{error, timeout} ->
			reload
	end,
	?MODULE:accept(LSocket).

%% @doc Process the new connections.
%%      Send an hello packet, authenticate the user and send him to character select.

process(CSocket, Version) ->
	case egs_proto:packet_recv(CSocket, 5000) of
		{ok, Packet} ->
			<< _:32, Command:16/unsigned-integer, _/bits >> = Packet,
			process_handle(Command, CSocket, Version, Packet);
		{error, timeout} ->
			reload,
			?MODULE:process(CSocket, Version);
		{error, closed} ->
			log(0, "recv error, closing")
	end.

%% @doc Game server auth request handler.

process_handle(16#020d, CSocket, Version, Packet) ->
	[{gid, GID}, {auth, Auth}] = egs_proto:parse_game_auth(Packet),
	case egs_db:users_select(GID) of
		error ->
			log(GID, "can't find user, closing"),
			ssl:close(CSocket);
		User ->
			case User#users.auth of
				Auth ->
					log(GID, "good auth, proceed"),
					LID = egs_db:next(lobby),
					egs_db:users_insert(#users{gid=GID, pid=self(), socket=CSocket, auth= << 0:32 >>, folder=User#users.folder, lid=LID}),
					egs_proto:send_flags(CSocket, GID),
					?MODULE:char_select(CSocket, GID, Version);
				_ ->
					log(GID, "bad auth, closing"),
					egs_db:users_delete(GID),
					ssl:close(CSocket)
			end
	end;

%% @doc Platform information handler. Obtain the game version.

process_handle(16#080e, CSocket, _, Packet) ->
	[{version, RealVersion}] = egs_proto:parse_platform_info(Packet),
	?MODULE:process(CSocket, RealVersion);

%% @doc Unknown command handler. Do nothing.

process_handle(Command, CSocket, Version, _) ->
	log(0, io_lib:format("(process) dismissed packet ~4.16.0b", [Command])),
	?MODULE:process(CSocket, Version).

%% @doc Character selection screen loop.
%%      The default entry point currently is first floor, near the uni cube.

char_select(CSocket, GID, Version) ->
	case egs_proto:packet_recv(CSocket, 5000) of
		{ok, Packet} ->
			<< _:32, Command:16/unsigned-integer, _/bits >> = Packet,
			char_select_handle(Command, CSocket, GID, Version, Packet);
		{error, timeout} ->
			egs_proto:send_keepalive(CSocket, GID),
			reload,
			?MODULE:char_select(CSocket, GID, Version);
		{error, closed} ->
			log(GID, "recv error, closing"),
			egs_db:users_delete(GID)
	end.

%% @doc Character selection handler.

char_select_handle(16#020b, CSocket, GID, Version, Packet) ->
	log(GID, "character selection"),
	[{number, Number}] = egs_proto:parse_character_select(Packet),
	char_select_load(CSocket, GID, Version, Number);

%% @doc Character creation handler.

char_select_handle(16#0d02, CSocket, GID, Version, Packet) ->
	log(GID, "character creation"),
	User = egs_db:users_select(GID),
	[{number, Number}, {char, Char}] = egs_proto:parse_character_create(Packet),
	_ = file:make_dir(io_lib:format("save/~s", [User#users.folder])),
	file:write_file(io_lib:format("save/~s/~b-character", [User#users.folder, Number]), Char),
	file:write_file(io_lib:format("save/~s/~b-character.options", [User#users.folder, Number]), << 0:192 >>),
	char_select_load(CSocket, GID, Version, Number);

%% @doc Character selection screen request.

char_select_handle(16#0d06, CSocket, GID, Version, _) ->
	log(GID, "send character selection screen"),
	User = egs_db:users_select(GID),
	egs_proto:send_character_list(CSocket, GID,
		char_load(User#users.folder, 0),
		char_load(User#users.folder, 1),
		char_load(User#users.folder, 2),
		char_load(User#users.folder, 3)),
	?MODULE:char_select(CSocket, GID, Version);

%% @doc Unknown command handler. Do nothing.

char_select_handle(Command, CSocket, GID, Version, _) ->
	log(GID, io_lib:format("(char_select) dismissed packet ~4.16.0b", [Command])),
	?MODULE:char_select(CSocket, GID, Version).

%% @doc Load the given character's data.

char_load(Folder, Number) ->
	Filename = io_lib:format("save/~s/~b-character", [Folder, Number]),
	case file:read_file(Filename) of
		{ok, Char} ->
			{ok, Options} = file:read_file(io_lib:format("~s.options", [Filename])),
			[{status, 1}, {char, Char}, {options, Options}];
		{error, _} ->
			[{status, 0}, {char, << 0:2208 >>}]
	end.

%% @doc Load the selected character and start the main game's loop.

char_select_load(CSocket, GID, Version, Number) ->
	User = egs_db:users_select(GID),
	[{status, _}, {char, << Name:512/bits, _/bits >>}|_] = char_load(User#users.folder, Number),
	NewRow = User#users{charnumber=Number, charname=Name},
	egs_db:users_insert(NewRow),
	?MODULE:lobby_load(CSocket, GID, 16#0100, 16#0100),
	ssl:setopts(CSocket, [{active, true}]),
	?MODULE:loop(CSocket, GID, Version).

%% @doc Load the given map as a standard lobby.

lobby_load(CSocket, GID, Map, Entry) ->
	User = egs_db:users_select(GID),
	[{status, 1}, {char, Char}, {options, Options}] = char_load(User#users.folder, User#users.charnumber),
	[{quest, Quest}, {zone, Zone}] = proplists:get_value(Map, ?MAPS, [{quest, "p/quest.gc1.nbl"}, {zone, "p/zone.gc1.nbl"}]),
	try
		% broadcast spawn to other people
		lists:foreach(fun(Other) -> Other#users.pid ! {psu_player_spawn, User} end, egs_db:users_select_others(GID)),
		% load lobby and character
		egs_proto:send_character_selected(CSocket, GID, Char, Options),
		% 0246 0a0a 1006
		send_packet_1005(CSocket, GID, Char),
		% 1006 0210
		egs_proto:send_universe_info(CSocket, GID),
		egs_proto:send_player_card(CSocket, GID, Char),
		% 1501 1512 0303
		egs_proto:send_npc_info(CSocket, GID),
		% 0c00
		egs_proto:send_quest(CSocket, Quest),
		% 0a05 0111 010d
		send_packet_200(CSocket, GID),
		egs_proto:send_zone(CSocket, Zone),
		egs_proto:send_map(CSocket, Map, Entry),
		% 100e 020c
		egs_proto:send_load_quest(CSocket, GID),
		send_packet_201(CSocket, GID, Map, Entry, User, Char),
		% 0a06
		Users = egs_db:users_select_others(GID),
		send_packet_233(CSocket, GID, Users),
		egs_proto:send_loading_end(CSocket, GID),
		egs_proto:send_camera_center(CSocket, GID)
	catch
		_ ->
			ssl:close(CSocket),
			log(GID, "send error, closing")
	end.

%% @doc Alias for the game main's loop when the buffer is empty.

loop(CSocket, GID, Version) ->
	loop(CSocket, GID, Version, << >>).

%% @doc Game's main loop.
%% @todo Have some kind of clock process for keepalive packets.
%% @todo Handle 0102 and 0503 broadcasts correctly.

loop(CSocket, GID, Version, SoFar) ->
	receive
		{psu_broadcast_0102, Data} ->
			<< _:96, SrcGID:32/little-unsigned-integer, _:256, After/bits >> = Data,
			% TODO: assign the LID correctly when sending the character info for the player's character, not when broadcasting
			case egs_db:users_select(SrcGID) of
				error ->
					ignore;
				User ->
					LID = User#users.lid,
					Send = << 16#01020101:32, 0:32, 16#00011300:32, SrcGID:32/little-unsigned-integer, 0:64,
						16#00011300:32, GID:32/little-unsigned-integer, 0:64, SrcGID:32/little-unsigned-integer,
						LID:32/little-unsigned-integer, After/binary >>,
					egs_proto:packet_send(CSocket, Send)
			end,
			?MODULE:loop(CSocket, GID, Version, SoFar);
		{psu_broadcast_010f, Data} ->
			<< _:96, SrcGID:32/little-unsigned-integer, _:256, After/bits >> = Data,
			% TODO: assign the LID correctly when sending the character info for the player's character, not when broadcasting
			case egs_db:users_select(SrcGID) of
				error ->
					ignore;
				User ->
					LID = User#users.lid,
					Send = << 16#010f0100:32, 0:32, 16#00011300:32, SrcGID:32/little-unsigned-integer, 0:64,
						16#00011300:32, GID:32/little-unsigned-integer, 0:64, SrcGID:32/little-unsigned-integer,
						LID:32/little-unsigned-integer, After/binary >>,
					egs_proto:packet_send(CSocket, Send)
			end,
			?MODULE:loop(CSocket, GID, Version, SoFar);
		{psu_broadcast_0503, Data} ->
			<< _:96, SrcGID:32/little-unsigned-integer, _:256, After/bits >> = Data,
			% TODO: assign the LID correctly when sending the character info for the player's character, not when broadcasting
			case egs_db:users_select(SrcGID) of
				error ->
					ignore;
				User ->
					LID = User#users.lid,
					Send = << 16#05030101:32, 0:32, 16#00011300:32, SrcGID:32/little-unsigned-integer, 0:64,
						16#00011300:32, GID:32/little-unsigned-integer, 0:64, SrcGID:32/little-unsigned-integer,
						LID:32/little-unsigned-integer, After/binary >>,
					egs_proto:packet_send(CSocket, Send)
			end,
			?MODULE:loop(CSocket, GID, Version, SoFar);
		{psu_chat, ChatGID, ChatName, ChatModifiers, ChatMessage} ->
			egs_proto:send_chat(CSocket, Version, ChatGID, ChatName, ChatModifiers, ChatMessage),
			?MODULE:loop(CSocket, GID, Version, SoFar);
		{psu_player_spawn, SpawnPlayer} ->
			send_spawn(CSocket, GID, SpawnPlayer),
			?MODULE:loop(CSocket, GID, Version, SoFar);
		{ssl, _, Data} ->
			{Packets, Rest} = egs_proto:packet_split(<< SoFar/bits, Data/bits >>),
			[dispatch(CSocket, GID, Version, P) || P <- Packets],
			?MODULE:loop(CSocket, GID, Version, Rest);
		{ssl_closed, _} ->
			log(GID, "ssl closed~n"),
			egs_db:users_delete(GID),
			ssl:close(CSocket);
		{ssl_error, _, _} ->
			io:format("ssl error~n"),
			egs_db:users_delete(GID),
			ssl:close(CSocket);
		_ ->
			?MODULE:loop(CSocket, GID, Version, SoFar)
	after 1000 ->
		egs_proto:send_keepalive(CSocket, GID),
		reload,
		?MODULE:loop(CSocket, GID, Version, SoFar)
	end.

%% @doc Dispatch the command to the right handler.

dispatch(CSocket, GID, Version, Packet) ->
	<< _:32, Command:16/unsigned-integer, _/bits >> = Packet,
	handle(Command, CSocket, GID, Version, Packet).

%% @doc Keepalive handler. Do nothing.

handle(16#021c, _, _, _, _) ->
	ignore;

%% @doc Uni cube handler.

handle(16#021d, CSocket, GID, _, _) ->
	log(GID, "uni cube"),
	egs_proto:send_universe_cube(CSocket);

%% @doc Uni selection handler.
%%      When selecting 'Your room', load first floor for now.
%%      When selecting 'Reload', load first floor.
%% @todo Load 'Your room' correctly.

handle(16#021f, CSocket, GID, _, Packet) ->
	case egs_proto:parse_uni_select(Packet) of
		[{uni, 0}] ->
			log(GID, "uni selection cancelled");
		[{uni, 16#ffffffff}] ->
			log(GID, "uni selection (my room)"),
			% 0230 0220
			% myroom_load(CSocket, GID, Version, 16#a701, 16#0100);
			lobby_load(CSocket, GID, 16#6700, 16#0100);
		_ ->
			log(GID, "uni selection (reload)"),
			% 0230 0220
			lobby_load(CSocket, GID, 16#0100, 16#0100)
	end;

%% @doc Shortcut changes handler. Do nothing.
%% @todo Save it.

handle(16#0302, _, GID, _, _) ->
	log(GID, "dismissed shortcut changes");

%% @doc Chat handler. Broadcast the chat message to all other players.
%%      We must take extra precautions to handle different versions of the game correctly.
%% @todo Only broadcast to people in the same map.

handle(16#0304, _, GID, Version, Packet) ->
	log(GID, "broadcast chat"),
	[{gid, _}, {name, ChatName}, {modifiers, ChatModifiers}, {message, ChatMessage}] = egs_proto:parse_chat(Version, Packet),
	case ChatName of
		missing ->
			case egs_db:users_select(GID) of
				error ->
					ActualName = ChatName;
				User ->
					ActualName = User#users.charname
			end;
		_ ->
			ActualName = ChatName
	end,
	lists:foreach(fun(User) -> User#users.pid ! {psu_chat, GID, ActualName, ChatModifiers, ChatMessage} end, egs_db:users_select_all());

%% @doc Movements handler. Broadcast to all other players.

handle(16#0102, _, GID, _, Packet) ->
	<< _:32, Data/bits >> = Packet,
	lists:foreach(fun(User) -> User#users.pid ! {psu_broadcast_0102, Data} end, egs_db:users_select_others(GID));

%% @doc Lobby actions handler. Broadcast to all other players.

handle(16#010f, _, GID, _, Packet) ->
	<< _:32, Data/bits >> = Packet,
	lists:foreach(fun(User) -> User#users.pid ! {psu_broadcast_010f, Data} end, egs_db:users_select_others(GID));

%% @doc Position change handler. Broadcast to all other players.

handle(16#0503, _, GID, _, Packet) ->
	<< _:32, Data/bits >> = Packet,
	<< _:416, Coords:96/bits, _:160, Map:32/little-unsigned-integer, Entry:32/little-unsigned-integer, _/bits >> = Data,
	User = egs_db:users_select(GID),
	NewUser = User#users{coords=Coords, map=Map, entry=Entry},
	egs_db:users_insert(NewUser),
	lists:foreach(fun(X) -> X#users.pid ! {psu_broadcast_0503, Data} end, egs_db:users_select_others(GID));

%% @todo Unknown handler. Do nothing for now.

handle(16#050f, _, _, _, _) ->
	ignore;

%% @doc Stand still handler. Do nothing.

handle(16#0514, _, _, _, _) ->
	ignore;

%% @doc Lobby change handler.

handle(16#0807, CSocket, GID, _, Packet) ->
	[{map, Map}, {entry, Entry}] = egs_proto:parse_lobby_change(Packet),
	log(GID, io_lib:format("lobby change (~4.16.0b,~4.16.0b)", [Map, Entry])),
	lobby_load(CSocket, GID, Map, Entry);

%% @doc Options changes handler.

handle(16#0d07, _, GID, _, Packet) ->
	log(GID, "options changes"),
	[{options, Options}] = egs_proto:parse_options_change(Packet),
	User = egs_db:users_select(GID),
	file:write_file(io_lib:format("save/~s/~b-character.options", [User#users.folder, User#users.charnumber]), Options);

%% @doc Sit on chair? handler. Do nothing for now.

handle(16#0f0a, _, GID, _, _) ->
	log(GID, "sit on chair");

%% @doc Unknown command handler. Do nothing.

handle(Command, _, GID, _, _) ->
	log(GID, io_lib:format("(game) dismissed packet ~4.16.0b", [Command])).

%% @todo Figure out what the packet is.

send_packet_200(CSocket, GID) ->
	{ok, File} = file:read_file("p/packet0200.bin"),
	<< _:288, After/bits >> = File,
	Packet = << 16#0200:16, 0:208, GID:32/little-unsigned-integer, After/binary >>,
	egs_proto:packet_send(CSocket, Packet).

%% @todo Figure out what the other things are.

send_packet_201(CSocket, GID, Map, Entry, User, Char) ->
	CharGID = User#users.gid,
	CharLID = User#users.lid,
	{ok, File} = file:read_file("p/packet0201.bin"),
	<< _:96, A:32/bits, _:96, B:32/bits, _:256, D:96/bits, _:2592, After/bits >> = File,
	Packet = << 16#0201:16, 0:48, A/binary, CharGID:32/little-unsigned-integer, 0:64, B/binary, GID:32/little-unsigned-integer,
		0:64, CharLID:32/little-unsigned-integer, CharGID:32/little-unsigned-integer, 0:96, D/binary, Map:16/unsigned-integer,
		0:16, Entry:16/unsigned-integer, 0:16, 0:320, Char/binary, After/binary >>,
	egs_proto:packet_send(CSocket, Packet).

%% @todo Figure out what the other things are.

send_packet_233(CSocket, GID, Users) ->
	NbUsers = length(Users),
	case NbUsers of
		0 ->
			ignore;
		_ ->
			Header = << 16#02330300:32, 0:32, 16#00001200:32, GID:32/little-unsigned-integer, 0:64, 16#00011300:32,
				GID:32/little-unsigned-integer, 0:64, NbUsers:32/little-unsigned-integer >>,
			Contents = build_packet_233_contents(Users),
			Packet = << Header/binary, Contents/binary >>,
			egs_proto:packet_send(CSocket, Packet)
	end.

build_packet_233_contents([]) ->
	<< >>;
build_packet_233_contents(Users) ->
	[User|Rest] = Users,
	{ok, File} = file:read_file("p/player.bin"),
	<< A:32/bits, _:32, B:64/bits, _:32, C:96/bits, _:64, D:32/bits, _:96, E:128/bits, _:2272, F/bits >> = File,
	{ok, CharFile} = file:read_file(io_lib:format("save/~s/~b-character", [User#users.folder, User#users.charnumber])),
	CharGID = User#users.gid,
	LID = User#users.lid,
	case User#users.coords of % TODO: temporary? undefined handling
		undefined ->
			Coords = << 0:96 >>,
			Map = 1,
			Entry = 0;
		_ ->
			Coords = User#users.coords,
			Map = User#users.map,
			Entry = User#users.entry
	end,
	Chunk = << A/binary, CharGID:32/little-unsigned-integer, B/binary, LID:16/little-unsigned-integer, 16#0100:16, C/binary,
		Map:16/little-unsigned-integer, 0:16, Entry:16/little-unsigned-integer, 0:16, D:32/bits, Coords:96/bits, E/binary,
		Map:16/little-unsigned-integer, 0:16, Entry:16/little-unsigned-integer, 0:16, CharFile/binary, F/binary >>,
	Next = build_packet_233_contents(Rest),
	<< Chunk/binary, Next/binary >>.

%% @todo Figure out what the packet is.

send_packet_1005(CSocket, GID, Char) ->
	{ok, File} = file:read_file("p/packet1005.bin"),
	<< _:352, Before:160/bits, _:608, After/bits >> = File,
	<< Name:512/bits, _/bits >> = Char,
	Packet = << 16#1005:16, 0:208, GID:32/little-unsigned-integer, 0:64, Before/binary, GID:32/little-unsigned-integer, 0:64, Name/binary, After/binary >>,
	egs_proto:packet_send(CSocket, Packet).

%% @todo Figure out what the other things are and do it right.
%% @todo Temporarily send 233 until the correct process is figured out.
%%       Should be something along the lines of 203 201 204.

send_spawn(CSocket, GID, _) ->
	send_packet_233(CSocket, GID, egs_db:users_select_others(GID)).

%% @doc Log message to the console.

log(GID, Message) ->
	io:format("game (~.10b): ~s~n", [GID, Message]).
