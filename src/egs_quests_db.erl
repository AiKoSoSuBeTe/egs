%% @author Lo�c Hoguin <essen@dev-extend.eu>
%% @copyright 2010 Lo�c Hoguin.
%% @doc EGS quests database and cache manager.
%%
%%	This file is part of EGS.
%%
%%	EGS is free software: you can redistribute it and/or modify
%%	it under the terms of the GNU Affero General Public License as
%%	published by the Free Software Foundation, either version 3 of the
%%	License, or (at your option) any later version.
%%
%%	EGS is distributed in the hope that it will be useful,
%%	but WITHOUT ANY WARRANTY; without even the implied warranty of
%%	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%	GNU Affero General Public License for more details.
%%
%%	You should have received a copy of the GNU Affero General Public License
%%	along with EGS.  If not, see <http://www.gnu.org/licenses/>.

-module(egs_quests_db).
-behavior(gen_server).
-export([start_link/0, stop/0, quest/1, zone/2, reload/0]). %% API.
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]). %% gen_server.

-record(state, {quests_bin=[], zones_bin=[]}).

%% Use the module name for the server's name.
-define(SERVER, ?MODULE).

%% API.

%% @spec start_link() -> {ok,Pid::pid()}
start_link() ->
	gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%% @spec stop() -> stopped
stop() ->
	gen_server:call(?SERVER, stop).

%% @spec quest(QuestID) -> binary()
quest(QuestID) ->
	gen_server:call(?SERVER, {quest, QuestID}).

%% @spec zone(QuestID, ZoneID) -> binary()
zone(QuestID, ZoneID) ->
	gen_server:call(?SERVER, {zone, QuestID, ZoneID}).

%% @spec reload() -> ok
reload() ->
	gen_server:cast(?SERVER, reload).

%% gen_server.

init([]) ->
	{ok, #state{}}.

handle_call({quest, QuestID}, _From, State=#state{quests_bin=Cache}) ->
	{Quest, Cache2} = get_quest(QuestID, Cache),
	{reply, Quest, State#state{quests_bin=Cache2}};

handle_call({zone, QuestID, ZoneID}, _From, State=#state{zones_bin=Cache}) ->
	{Zone, Cache2} = get_zone(QuestID, ZoneID, Cache),
	{reply, Zone, State#state{zones_bin=Cache2}};

handle_call(stop, _From, State) ->
	{stop, normal, stopped, State};

handle_call(_Request, _From, State) ->
	{reply, ignored, State}.

handle_cast(reload, _State) ->
	{noreply, #state{}};

handle_cast(_Msg, State) ->
	{noreply, State}.

handle_info(_Info, State) ->
	{noreply, State}.

terminate(_Reason, _State) ->
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

%% Internal.

%% @doc Return a quest information either from the cache or from the configuration file,
%% in which case it gets added to the cache for subsequent attempts.
get_quest(QuestID, Cache) ->
	case proplists:get_value(QuestID, Cache) of
		undefined ->
			Dir = io_lib:format("priv/quests/~b/", [QuestID]),
			ConfFilename = Dir ++ "quest.conf",
			{QuestXnrData, QuestXnrPtrs} = egs_files:load_quest_xnr(ConfFilename),
			UnitTitleBinFiles = load_unit_title_bin_files(Dir, ConfFilename),
			Files = [{data, "quest.xnr", QuestXnrData, QuestXnrPtrs}],
			Files2 = Files ++ case UnitTitleBinFiles of
				ignore -> [];
				_Any ->
					TablePos = egs_files:nbl_padded_size(byte_size(QuestXnrData)),
					TextSize = lists:sum([egs_files:nbl_padded_size(byte_size(D)) || {data, _F, D, _P} <- UnitTitleBinFiles]),
					TablePos2 = TablePos + TextSize,
					{UnitTitleTableRelData, UnitTitleTableRelPtrs} = egs_files:load_unit_title_table_rel(ConfFilename, TablePos2),
					UnitTitleBinFiles ++ [{data, "unit_title_table.rel", UnitTitleTableRelData, UnitTitleTableRelPtrs}]
			end,
			QuestNbl = egs_files:nbl_pack([{files, Files2}]),
			Cache2 = [{QuestID, QuestNbl}|Cache],
			{QuestNbl, Cache2};
		QuestNbl ->
			{QuestNbl, Cache}
	end.

%% @doc Return a zone information either from the cache or from the configuration files.
%% @todo FilePos, text.bin, other sets, enemies.
get_zone(QuestID, ZoneID, Cache) ->
	case proplists:get_value({QuestID, ZoneID}, Cache) of
		undefined ->
			Dir = io_lib:format("priv/quests/~b/", [QuestID]),
			ZoneDir = Dir ++ io_lib:format("zone-~b/", [ZoneID]),
			{ok, QuestSettings} = file:consult(Dir ++ "quest.conf"),
			Zones = proplists:get_value(zones, QuestSettings),
			Zone = proplists:get_value(ZoneID, Zones),
			AreaID = proplists:get_value(areaid, Zone),
			Maps = proplists:get_value(maps, Zone),
			FilePos = 0, %% @todo
			{Set0, SetPtrs} = egs_files:load_set_rel(ZoneDir ++ io_lib:format("set_r~b.conf", [0]), AreaID, Maps, FilePos),
			ScriptBin = egs_files:load_script_bin(ZoneDir ++ "script.es"),
			ScriptBinSize = byte_size(ScriptBin),
			ScriptBin2 = egs_prs:compress(ScriptBin),
			ScriptBinSize2 = byte_size(ScriptBin2),
			ScriptBin3 = << ScriptBinSize:32/little, ScriptBinSize2:32/little, 0:32, 1:32/little, 0:96, ScriptBin2/binary >>,
			TextBin = egs_files:load_text_bin(ZoneDir ++ "text.bin.en_US.txt"),
			ZoneNbl = egs_files:nbl_pack([{files, [
				{data, "set_r0.rel", Set0, SetPtrs},
				{data, "script.bin", ScriptBin3, []},
				{data, "text.bin", TextBin, []}
			]}]),
			Cache2 = [{{QuestID, ZoneID}, ZoneNbl}|Cache],
			{ZoneNbl, Cache2};
		ZoneNbl ->
			{ZoneNbl, Cache}
	end.

load_unit_title_bin_files(Dir, ConfFilename) ->
	{ok, Settings} = file:consult(ConfFilename),
	case proplists:get_value(notitles, Settings) of
		true -> ignore;
		_Any ->
			Zones = proplists:get_value(zones, Settings),
			[load_unit_title_bin(Dir, Zone) || Zone <- Zones]
	end.

load_unit_title_bin(Dir, {ZoneID, _ZoneParams}) ->
	Filename = io_lib:format("unit_title_~2.10.0b.bin", [ZoneID]),
	TxtFilename = io_lib:format("~s~s.en_US.txt", [Dir, Filename]),
	{data, Filename, egs_files:load_text_bin(TxtFilename), []}.
