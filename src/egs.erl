%% @author Lo�c Hoguin <essen@dev-extend.eu>
%% @copyright 2010 Lo�c Hoguin.
%% @doc EGS startup code.
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

-module(egs).
-compile(export_all).

-include("include/records.hrl").

-define(MODULES, [egs, egs_app, egs_sup, egs_cron, egs_db, egs_game, egs_login, egs_patch, egs_proto, psu_appearance, psu_characters, psu_missions, psu_parser]).

%% @spec ensure_started(App) -> ok
%% @doc Make sure the given App is started.
ensure_started(App) ->
	case application:start(App) of
		ok -> ok;
		{error, {already_started, App}} -> ok
	end.

%% @spec start() -> ok
%% @doc Start the EGS server.
start() ->
	ensure_started(crypto),
	ensure_started(ssl),
	ssl:seed(crypto:rand_bytes(256)),
	ensure_started(mnesia),
	application:start(egs).

%% @spec stop() -> ok
%% @doc Stop the EGS server.
stop() ->
	Res = application:stop(egs),
	application:stop(mnesia),
	application:stop(ssl),
	application:stop(crypto),
	Res.

%% @doc Reload all the modules.
%% @todo Do it the OTP way.
reload() ->
	[code:soft_purge(Module) || Module <- ?MODULES],
	[code:load_file(Module) || Module <- ?MODULES].

%% @doc Send a global message.
%% @todo Move that in a psu module.
global(Type, Message) ->
	lists:foreach(fun(User) -> egs_proto:send_global(User#users.socket, Type, Message) end, egs_db:users_select_all()).

%% @doc Warp all players to a new map.
%% @todo Move that in a psu module.
warp(QuestID, ZoneID, MapID, EntryID) ->
	lists:foreach(fun(User) -> User#users.pid ! {psu_warp, QuestID, ZoneID, MapID, EntryID} end, egs_db:users_select_all()).

%% @doc Warp one player to a new map.
%% @todo Move that in a psu module.
warp(GID, QuestID, ZoneID, MapID, EntryID) ->
	User = egs_db:users_select(GID),
	User#users.pid ! {psu_warp, QuestID, ZoneID, MapID, EntryID}.
