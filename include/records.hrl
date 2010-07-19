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

%% @doc Temporary table for generating a new GID at each connection.

-record(ids, {type, id}).

%% @doc Character position data structure.

-record(pos, {x, y, z, dir}).

%% @doc Character area location data structure.

-record(psu_area, {questid, zoneid, mapid}).

%% @doc Table containing the users currently logged in.
%% @todo Probably can use a "param" or "extra" field to store the game-specific information (for things that don't need to be queried).

-record(egs_user_model, {
	id, pid, socket, state, time, character, instanceid, areatype, area, entryid, pos,
	%% psu specific fields
	lid, prev_area, prev_entryid,
	%% temporary fields
	folder
}).

%% @doc Character main or class level data structure.

-record(level, {number, exp}).

%% @doc Character stats data structure.

-record(stats, {atp, ata, tp, dfp, evp, mst, sta}).

%% @doc Character appearance data structure, flesh version.

-record(flesh_appearance, {voicetype, voicepitch, jacket, pants, shoes, ears, face, hairstyle, jacketcolor, pantscolor, shoescolor,
	lineshieldcolor, badge, eyebrows, eyelashes, eyesgroup, eyes, bodysuit, eyescolory, eyescolorx, lipsintensity, lipscolory, lipscolorx,
	skincolor, hairstylecolory, hairstylecolorx, proportion, proportionboxx, proportionboxy, faceboxx, faceboxy}).

%% @doc Character appearance data structure, metal version.

-record(metal_appearance, {voicetype, voicepitch, torso, legs, arms, ears, face, headtype, maincolor, lineshieldcolor,
	eyebrows, eyelashes, eyesgroup, eyes, eyescolory, eyescolorx, bodycolor, subcolor, hairstylecolory, hairstylecolorx,
	proportion, proportionboxx, proportionboxy, faceboxx, faceboxy}).

%% @doc Character options data structure.

-record(options, {textdisplayspeed, sound, musicvolume, soundeffectvolume, vibration, radarmapdisplay,
	cutindisplay, mainmenucursorposition, camera3y, camera3x, camera1y, camera1x, controller, weaponswap,
	lockon, brightness, functionkeysetting, buttondetaildisplay}).

%% @doc Accounts data structure.
%% @todo Make a disk table for storing accounts.

-record(accounts, {gid, username, password}). % also: characters, commonbox

%% @doc Characters data structure.
%% @todo Make a disk table for storing characters permanently. Also keep the current character in #users.

-record(characters, {
	gid,
	type=white,
	slot,
	name,
	race,
	gender,
	class,
	mainlevel={level, 1, 0},
	classlevels,
	currenthp=100,
	maxhp=100,
	stats={stats, 1000, 2000, 3000, 4000, 5000, 6000, 7000},
	se=[],
	money=1000,
	blastbar=0,
	luck=3,
	playtime=0,
	appearance,
	onlinestatus=0,
	options={options, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0}
}). % also: shortcuts partnercards blacklist npcs flags items...

%% @doc Table containing all mission objects.

-record(objects, {id, instanceid, objectid, type, targetid, blockid, triggereventid, args}). % id = [instanceid, objectid]

%% @doc Hit response data.

-record(hit_response, {type, user, exp, damage, targethp, targetse, events}).
