#	EGS: Erlang Game Server
#	Copyright (C) 2010  Loic Hoguin
#
#	This file is part of EGS.
#
#	EGS is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	gasetools is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with gasetools.  If not, see <http://www.gnu.org/licenses/>.

all: server

server: clean
	@erl -make

clean:
	rm -f ebin/*.beam
	rm -f erl_crash.dump

fclean: clean
	rm -rf Mnesia.console*

run:
	@echo "EGS is free software available under the GNU GPL version 3"
	@echo "Copyright (C) 2010  Loic Hoguin"
	@echo 
	erl -ssl protocol_version '{sslv3}' -sname console -pa ebin -eval 'egs:start()'
