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

-module(egs_store_app).
-behaviour(application).
-export([start/2, stop/1]). %% API.

-type application_start_type()
	:: normal | {takeover, node()} | {failover, node()}.

%% API.

-spec start(application_start_type(), any()) -> {ok, pid()}.
start(_Type, _StartArgs) ->
	egs_store_sup:start_link().

-spec stop(any()) -> ok.
stop(_State) ->
	ok.
