%% @author Lo�c Hoguin <essen@dev-extend.eu>
%% @copyright 2010 Lo�c Hoguin.
%% @doc Project-wide Erlang records.
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

%% @doc Per-process state used by the various EGS modules.
-record(state, {socket, gid, slot, lid=16#ffff, areanb=0}).

%% @doc Accounts. So far only used for storing temporary information.
%% @todo Hash the password.
%% @todo Add email, password_salt, is_ingame, register_time, last_login_time, etc.
-record(accounts, {gid, username, password, auth_state}).

%% @doc NPC configuration data.
%% @todo Add inventory, AI parameters.
-record(npc, {name, race, gender, class, level_diff, appearance}).

%% @doc Character appearance data structure, flesh version.
-record(flesh_appearance, {
	voicetype, voicepitch=127,
	jacket, pants, shoes, ears, face, hairstyle,
	jacketcolor=0, pantscolor=0, shoescolor=0, lineshieldcolor=0, badge=0,
	eyebrows=0, eyelashes=0, eyesgroup=0, eyes=0,
	bodysuit=0,
	eyescolory=32767, eyescolorx=0,
	lipsintensity=32767, lipscolory=32767, lipscolorx=0,
	skincolor=65535,
	hairstylecolory=32767, hairstylecolorx=0,
	proportion=65535, proportionboxx=65535, proportionboxy=65535,
	faceboxx=65535, faceboxy=65535
}).

%% @doc Character appearance data structure, metal version.
-record(metal_appearance, {
	voicetype, voicepitch=127,
	torso, legs, arms, ears, face, headtype,
	maincolor=0, lineshieldcolor=0,
	eyebrows=0, eyelashes=0, eyesgroup=0, eyes=0,
	eyescolory=32767, eyescolorx=0,
	bodycolor=65535, subcolor=196607,
	hairstylecolory=32767, hairstylecolorx=0,
	proportion=65535, proportionboxx=65535, proportionboxy=65535,
	faceboxx=65535, faceboxy=65535
}).

%% Past this point needs to be reviewed.

%% @doc Table containing counters current values.
-record(counters, {name, id}).

%% @doc Character position data structure.

-record(pos, {x, y, z, dir}).

%% @doc Character area location data structure.

-record(psu_area, {questid, zoneid, mapid}).

%% @doc Table containing the users currently logged in.
%% @todo Probably can use a "param" or "extra" field to store the game-specific information (for things that don't need to be queried).

-record(egs_user_model, {
	%% General information.
	id, lid, pid, time, character,
	%% Location/state related information.
	uni, instancepid, partypid, areatype, area, entryid, pos=#pos{x=0.0, y=0.0, z=0.0, dir=0.0}, shopid,
	prev_area=#psu_area{questid=0, zoneid=0, mapid=0}, prev_entryid=0, %% universeid
	%% To be moved or deleted later on.
	setid=0 %% @todo Current area's set number. Move that to psu_instance probably.
}).

%% @doc Character main or class level data structure.

-record(level, {number, exp}).

%% @doc Character stats data structure.

-record(stats, {atp, ata, tp, dfp, evp, mst, sta}).

%% @doc Character options data structure.

-record(options, {textdisplayspeed, sound, musicvolume, soundeffectvolume, vibration, radarmapdisplay,
	cutindisplay, mainmenucursorposition, camera3y, camera3x, camera1y, camera1x, controller, weaponswap,
	lockon, brightness, functionkeysetting, buttondetaildisplay}).

%% @doc Characters data structure.
%% @todo Make a disk table for storing characters permanently. Also keep the current character in #users.

-record(characters, {
	gid,
	type=white,
	slot,
	npcid=16#ffff,
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
	money=1000000,
	blastbar=0,
	luck=3,
	playtime=0,
	appearance,
	onlinestatus=0,
	options={options, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0},
	inventory=[]
}). % also: shortcuts partnercards blacklist npcs flags...

%% @doc Table containing all mission objects.

-record(psu_object, {id, instancepid, type, args}).

%% @doc Hit response data.

-record(hit_response, {type, user, exp, damage, targethp, targetse, events}).

%% @doc Items.

-record(psu_element, {type, percent}).
-record(psu_pa, {type, level}).

-record(psu_item, {name, rarity, buy_price, sell_price, data}).
-record(psu_clothing_item, {appearance, type, manufacturer, overlap, gender, colors}).
-record(psu_consumable_item, {max_quantity, pt_diff, status_effect, action, target, use_condition, item_effect}).
-record(psu_parts_item, {appearance, type, manufacturer, overlap, gender}).
-record(psu_special_item, {}).
-record(psu_striking_weapon_item, {pp, atp, ata, atp_req, shop_element, hand, max_upgrades, attack_label,
	attack_sound, hitbox_a, hitbox_b, hitbox_c, hitbox_d, nb_targets, effect, model}).
-record(psu_trap_item, {max_quantity, effect, type}).

-record(psu_clothing_item_variables, {color}).
-record(psu_consumable_item_variables, {quantity}).
-record(psu_parts_item_variables, {}).
-record(psu_special_item_variables, {}).
-record(psu_striking_weapon_item_variables, {is_active=0, slot=0, current_pp, max_pp, element, pa=#psu_pa{type=0, level=0}}).
-record(psu_trap_item_variables, {quantity}).
