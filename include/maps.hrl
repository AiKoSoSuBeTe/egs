%% @author Lo�c Hoguin <essen@dev-extend.eu>
%% @copyright 2010 Lo�c Hoguin.
%% @doc Quests, zones, maps and counters definitions.
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

%% EGS maps settings.

-define(QUESTS, [
	% Unsafe Passage

	{1000000, [{type, mission}, {file, "data/missions/unsafe-passage.1.c.quest.nbl"},  {start, [0, 1120, 0]}, {sets, 4}]},
	{1000001, [{type, mission}, {file, "data/missions/unsafe-passage.1.b.quest.nbl"},  {start, [0, 1120, 0]}, {sets, 4}]},
	{1000002, [{type, mission}, {file, "data/missions/unsafe-passage.1.a.quest.nbl"},  {start, [0, 1120, 0]}, {sets, 4}]},
	{1000003, [{type, mission}, {file, "data/missions/unsafe-passage.1.s.quest.nbl"},  {start, [0, 1120, 0]}, {sets, 4}]},
	{1000004, [{type, mission}, {file, "data/missions/unsafe-passage.1.s2.quest.nbl"}, {start, [0, 1120, 0]}, {sets, 4}]},

	{1000010, [{type, mission}, {file, "data/missions/unsafe-passage.2.c.quest.nbl"},  {start, [0, 1121, 0]}, {sets, 4}]},
	{1000011, [{type, mission}, {file, "data/missions/unsafe-passage.2.b.quest.nbl"},  {start, [0, 1121, 0]}, {sets, 4}]},
	{1000012, [{type, mission}, {file, "data/missions/unsafe-passage.2.a.quest.nbl"},  {start, [0, 1121, 0]}, {sets, 4}]},
	{1000013, [{type, mission}, {file, "data/missions/unsafe-passage.2.s.quest.nbl"},  {start, [0, 1121, 0]}, {sets, 4}]},
	{1000014, [{type, mission}, {file, "data/missions/unsafe-passage.2.s2.quest.nbl"}, {start, [0, 1121, 0]}, {sets, 4}]},

	{1000020, [{type, mission}, {file, "data/missions/unsafe-passage.3.c.quest.nbl"},  {start, [0, 1200, 0]}, {sets, 4}]},
	{1000021, [{type, mission}, {file, "data/missions/unsafe-passage.3.b.quest.nbl"},  {start, [0, 1200, 0]}, {sets, 4}]},
	{1000022, [{type, mission}, {file, "data/missions/unsafe-passage.3.a.quest.nbl"},  {start, [0, 1200, 0]}, {sets, 4}]},
	{1000023, [{type, mission}, {file, "data/missions/unsafe-passage.3.s.quest.nbl"},  {start, [0, 1200, 0]}, {sets, 4}]},
	{1000024, [{type, mission}, {file, "data/missions/unsafe-passage.3.s2.quest.nbl"}, {start, [0, 1200, 0]}, {sets, 4}]},

	% Fight for Food

	{1000100, [{type, mission}, {file, "data/missions/fight-for-food.1.c.quest.nbl"},  {start, [0, 1200, 0]}, {sets, 4}]},
	{1000101, [{type, mission}, {file, "data/missions/fight-for-food.1.b.quest.nbl"},  {start, [0, 1200, 0]}, {sets, 4}]},
	%~ {1000102, [{type, mission}, {file, "data/missions/fight-for-food.1.a.quest.nbl"},  {start, [0, 1200, 0]}, {sets, 4}]},
	%~ {1000103, [{type, mission}, {file, "data/missions/fight-for-food.1.s.quest.nbl"},  {start, [0, 1200, 0]}, {sets, 4}]},
	{1000104, [{type, mission}, {file, "data/missions/fight-for-food.1.s2.quest.nbl"}, {start, [0, 1200, 0]}, {sets, 4}]},

	{1000110, [{type, mission}, {file, "data/missions/fight-for-food.2.c.quest.nbl"},  {start, [0, 1301, 0]}, {sets, 4}]},
	%~ {1000111, [{type, mission}, {file, "data/missions/fight-for-food.2.b.quest.nbl"},  {start, [0, 1301, 0]}, {sets, 4}]},
	%~ {1000112, [{type, mission}, {file, "data/missions/fight-for-food.2.a.quest.nbl"},  {start, [0, 1301, 0]}, {sets, 4}]},
	%~ {1000113, [{type, mission}, {file, "data/missions/fight-for-food.2.s.quest.nbl"},  {start, [0, 1301, 0]}, {sets, 4}]},
	{1000114, [{type, mission}, {file, "data/missions/fight-for-food.2.s2.quest.nbl"}, {start, [0, 1301, 0]}, {sets, 4}]},

	{1000120, [{type, mission}, {file, "data/missions/fight-for-food.3.c.quest.nbl"},  {start, [0, 1301, 0]}, {sets, 4}]},
	%~ {1000121, [{type, mission}, {file, "data/missions/fight-for-food.3.b.quest.nbl"},  {start, [0, 1301, 0]}, {sets, 4}]},
	{1000122, [{type, mission}, {file, "data/missions/fight-for-food.3.a.quest.nbl"},  {start, [0, 1301, 0]}, {sets, 4}]},
	%~ {1000123, [{type, mission}, {file, "data/missions/fight-for-food.3.s.quest.nbl"},  {start, [0, 1301, 0]}, {sets, 4}]},
	{1000124, [{type, mission}, {file, "data/missions/fight-for-food.3.s2.quest.nbl"}, {start, [0, 1301, 0]}, {sets, 4}]},

	% Dark Satellite

	{1001000, [{type, mission}, {file, "data/missions/dark-satellite.1.c.quest.nbl"},  {start, [0, 101, 0]}, {sets, 4}]},
	{1001001, [{type, mission}, {file, "data/missions/dark-satellite.1.b.quest.nbl"},  {start, [0, 101, 0]}, {sets, 4}]},
	{1001002, [{type, mission}, {file, "data/missions/dark-satellite.1.a.quest.nbl"},  {start, [0, 101, 0]}, {sets, 4}]},
	%~ {1001003, [{type, mission}, {file, "data/missions/dark-satellite.1.s.quest.nbl"},  {start, [0, 101, 0]}, {sets, 4}]},
	{1001004, [{type, mission}, {file, "data/missions/dark-satellite.1.s2.quest.nbl"}, {start, [0, 101, 0]}, {sets, 4}]},
	{1001005, [{type, mission}, {file, "data/missions/dark-satellite.1.s3.quest.nbl"}, {start, [0, 101, 0]}, {sets, 4}]},

	{1001010, [{type, mission}, {file, "data/missions/dark-satellite.2.c.quest.nbl"},  {start, [0, 102, 0]}, {sets, 4}]},
	{1001011, [{type, mission}, {file, "data/missions/dark-satellite.2.b.quest.nbl"},  {start, [0, 102, 0]}, {sets, 4}]},
	{1001012, [{type, mission}, {file, "data/missions/dark-satellite.2.a.quest.nbl"},  {start, [0, 102, 0]}, {sets, 4}]},
	{1001013, [{type, mission}, {file, "data/missions/dark-satellite.2.s.quest.nbl"},  {start, [0, 102, 0]}, {sets, 4}]},
	%~ {1001014, [{type, mission}, {file, "data/missions/dark-satellite.2.s2.quest.nbl"}, {start, [0, 102, 0]}, {sets, 4}]},
	%~ {1001015, [{type, mission}, {file, "data/missions/dark-satellite.2.s3.quest.nbl"}, {start, [0, 102, 0]}, {sets, 4}]},

	{1001020, [{type, mission}, {file, "data/missions/dark-satellite.3.c.quest.nbl"},  {start, [0, 103, 0]}, {sets, 4}]},
	%~ {1001021, [{type, mission}, {file, "data/missions/dark-satellite.3.b.quest.nbl"},  {start, [0, 103, 0]}, {sets, 4}]},
	{1001022, [{type, mission}, {file, "data/missions/dark-satellite.3.a.quest.nbl"},  {start, [0, 103, 0]}, {sets, 4}]},
	%~ {1001023, [{type, mission}, {file, "data/missions/dark-satellite.3.s.quest.nbl"},  {start, [0, 103, 0]}, {sets, 4}]},
	{1001024, [{type, mission}, {file, "data/missions/dark-satellite.3.s2.quest.nbl"}, {start, [0, 103, 0]}, {sets, 4}]},
	{1001025, [{type, mission}, {file, "data/missions/dark-satellite.3.s3.quest.nbl"}, {start, [0, 103, 0]}, {sets, 4}]},

	% Seed Awakening

	%~ {1001100, [{type, mission}, {file, "data/missions/seed-awakening.1.c.quest.nbl"},  {start, [0, 130, 0]}, {sets, 4}]},
	{1001101, [{type, mission}, {file, "data/missions/seed-awakening.1.b.quest.nbl"},  {start, [0, 130, 0]}, {sets, 4}]},
	{1001102, [{type, mission}, {file, "data/missions/seed-awakening.1.a.quest.nbl"},  {start, [0, 130, 0]}, {sets, 4}]},
	{1001103, [{type, mission}, {file, "data/missions/seed-awakening.1.s.quest.nbl"},  {start, [0, 130, 0]}, {sets, 4}]},
	{1001104, [{type, mission}, {file, "data/missions/seed-awakening.1.s2.quest.nbl"}, {start, [0, 130, 0]}, {sets, 4}]},
	{1001105, [{type, mission}, {file, "data/missions/seed-awakening.1.s3.quest.nbl"}, {start, [0, 130, 0]}, {sets, 4}]},

	{1001110, [{type, mission}, {file, "data/missions/seed-awakening.2.c.quest.nbl"},  {start, [0, 112, 0]}, {sets, 4}]},
	{1001111, [{type, mission}, {file, "data/missions/seed-awakening.2.b.quest.nbl"},  {start, [0, 112, 0]}, {sets, 4}]},
	{1001112, [{type, mission}, {file, "data/missions/seed-awakening.2.a.quest.nbl"},  {start, [0, 112, 0]}, {sets, 4}]},
	%~ {1001113, [{type, mission}, {file, "data/missions/seed-awakening.2.s.quest.nbl"},  {start, [0, 112, 0]}, {sets, 4}]},
	{1001114, [{type, mission}, {file, "data/missions/seed-awakening.2.s2.quest.nbl"}, {start, [0, 112, 0]}, {sets, 4}]},
	{1001115, [{type, mission}, {file, "data/missions/seed-awakening.2.s3.quest.nbl"}, {start, [0, 112, 0]}, {sets, 4}]},

	{1001120, [{type, mission}, {file, "data/missions/seed-awakening.3.c.quest.nbl"},  {start, [0, 113, 0]}, {sets, 4}]},
	%~ {1001121, [{type, mission}, {file, "data/missions/seed-awakening.3.b.quest.nbl"},  {start, [0, 113, 0]}, {sets, 4}]},
	%~ {1001122, [{type, mission}, {file, "data/missions/seed-awakening.3.a.quest.nbl"},  {start, [0, 113, 0]}, {sets, 4}]},
	%~ {1001123, [{type, mission}, {file, "data/missions/seed-awakening.3.s.quest.nbl"},  {start, [0, 113, 0]}, {sets, 4}]},
	{1001124, [{type, mission}, {file, "data/missions/seed-awakening.3.s2.quest.nbl"}, {start, [0, 113, 0]}, {sets, 4}]},
	{1001125, [{type, mission}, {file, "data/missions/seed-awakening.3.s3.quest.nbl"}, {start, [0, 113, 0]}, {sets, 4}]},

	% True Darkness

	%~ {1001200, [{type, mission}, {file, "data/missions/true-darkness.1.c.quest.nbl"},  {start, [0, 130, 0]}, {sets, 4}]},
	%~ {1001201, [{type, mission}, {file, "data/missions/true-darkness.1.b.quest.nbl"},  {start, [0, 130, 0]}, {sets, 4}]},
	%~ {1001202, [{type, mission}, {file, "data/missions/true-darkness.1.a.quest.nbl"},  {start, [0, 130, 0]}, {sets, 4}]},
	%~ {1001203, [{type, mission}, {file, "data/missions/true-darkness.1.s.quest.nbl"},  {start, [0, 130, 0]}, {sets, 4}]},
	%~ {1001204, [{type, mission}, {file, "data/missions/true-darkness.1.s2.quest.nbl"}, {start, [0, 130, 0]}, {sets, 4}]},

	{1001210, [{type, mission}, {file, "data/missions/true-darkness.2.c.quest.nbl"},  {start, [0, 131, 0]}, {sets, 4}]},
	%~ {1001211, [{type, mission}, {file, "data/missions/true-darkness.2.b.quest.nbl"},  {start, [0, 131, 0]}, {sets, 4}]},
	{1001212, [{type, mission}, {file, "data/missions/true-darkness.2.a.quest.nbl"},  {start, [0, 131, 0]}, {sets, 4}]},
	{1001213, [{type, mission}, {file, "data/missions/true-darkness.2.s.quest.nbl"},  {start, [0, 131, 0]}, {sets, 4}]},
	%~ {1001214, [{type, mission}, {file, "data/missions/true-darkness.2.s2.quest.nbl"}, {start, [0, 131, 0]}, {sets, 4}]},

	{1001220, [{type, mission}, {file, "data/missions/true-darkness.3.c.quest.nbl"},  {start, [0, 802, 0]}, {sets, 4}]},
	{1001221, [{type, mission}, {file, "data/missions/true-darkness.3.b.quest.nbl"},  {start, [0, 802, 0]}, {sets, 4}]},
	{1001222, [{type, mission}, {file, "data/missions/true-darkness.3.a.quest.nbl"},  {start, [0, 802, 0]}, {sets, 4}]},
	%~ {1001223, [{type, mission}, {file, "data/missions/true-darkness.3.s.quest.nbl"},  {start, [0, 802, 0]}, {sets, 4}]},
	{1001224, [{type, mission}, {file, "data/missions/true-darkness.3.s2.quest.nbl"}, {start, [0, 802, 0]}, {sets, 4}]},

	% The Black Nest

	{1003000, [{type, mission}, {file, "data/missions/black-nest.1.c.quest.nbl"},  {start, [0, 6301, 0]}, {sets, 4}]},
	{1003001, [{type, mission}, {file, "data/missions/black-nest.1.b.quest.nbl"},  {start, [0, 6301, 0]}, {sets, 4}]},
	{1003002, [{type, mission}, {file, "data/missions/black-nest.1.a.quest.nbl"},  {start, [0, 6301, 0]}, {sets, 4}]},
	{1003003, [{type, mission}, {file, "data/missions/black-nest.1.s.quest.nbl"},  {start, [0, 6301, 0]}, {sets, 4}]},
	{1003004, [{type, mission}, {file, "data/missions/black-nest.1.s2.quest.nbl"}, {start, [0, 6301, 0]}, {sets, 4}]},

	{1003010, [{type, mission}, {file, "data/missions/black-nest.2.c.quest.nbl"},  {start, [0, 6303, 0]}, {sets, 4}]},
	%~ {1003011, [{type, mission}, {file, "data/missions/black-nest.2.b.quest.nbl"},  {start, [0, 6303, 0]}, {sets, 4}]},
	%~ {1003012, [{type, mission}, {file, "data/missions/black-nest.2.a.quest.nbl"},  {start, [0, 6303, 0]}, {sets, 4}]},
	%~ {1003013, [{type, mission}, {file, "data/missions/black-nest.2.s.quest.nbl"},  {start, [0, 6303, 0]}, {sets, 4}]},
	{1003014, [{type, mission}, {file, "data/missions/black-nest.2.s2.quest.nbl"}, {start, [0, 6303, 0]}, {sets, 4}]},

	{1003020, [{type, mission}, {file, "data/missions/black-nest.3.c.quest.nbl"},  {start, [0, 6803, 0]}, {sets, 4}]},
	{1003021, [{type, mission}, {file, "data/missions/black-nest.3.b.quest.nbl"},  {start, [0, 6803, 0]}, {sets, 4}]},
	%~ {1003022, [{type, mission}, {file, "data/missions/black-nest.3.a.quest.nbl"},  {start, [0, 6803, 0]}, {sets, 4}]},
	{1003023, [{type, mission}, {file, "data/missions/black-nest.3.s.quest.nbl"},  {start, [0, 6803, 0]}, {sets, 4}]},
	%~ {1003024, [{type, mission}, {file, "data/missions/black-nest.3.s2.quest.nbl"}, {start, [0, 6803, 0]}, {sets, 4}]},

	% The Dark God

	{1003100, [{type, mission}, {file, "data/missions/dark-god.1.c.quest.nbl"},  {start, [0, 6302, 0]}, {sets, 4}]},
	%~ {1003101, [{type, mission}, {file, "data/missions/dark-god.1.b.quest.nbl"},  {start, [0, 6302, 0]}, {sets, 4}]},
	{1003102, [{type, mission}, {file, "data/missions/dark-god.1.a.quest.nbl"},  {start, [0, 6302, 0]}, {sets, 4}]},
	{1003103, [{type, mission}, {file, "data/missions/dark-god.1.s.quest.nbl"},  {start, [0, 6302, 0]}, {sets, 4}]},
	{1003104, [{type, mission}, {file, "data/missions/dark-god.1.s2.quest.nbl"}, {start, [0, 6302, 0]}, {sets, 4}]},

	{1003110, [{type, mission}, {file, "data/missions/dark-god.2.c.quest.nbl"},  {start, [0, 6304, 0]}, {sets, 4}]},
	{1003111, [{type, mission}, {file, "data/missions/dark-god.2.b.quest.nbl"},  {start, [0, 6304, 0]}, {sets, 4}]},
	{1003112, [{type, mission}, {file, "data/missions/dark-god.2.a.quest.nbl"},  {start, [0, 6304, 0]}, {sets, 4}]},
	{1003113, [{type, mission}, {file, "data/missions/dark-god.2.s.quest.nbl"},  {start, [0, 6304, 0]}, {sets, 4}]},
	{1003114, [{type, mission}, {file, "data/missions/dark-god.2.s2.quest.nbl"}, {start, [0, 6304, 0]}, {sets, 4}]},

	{1003120, [{type, mission}, {file, "data/missions/dark-god.3.c.quest.nbl"},  {start, [0, 6302, 0]}, {sets, 4}]},
	{1003121, [{type, mission}, {file, "data/missions/dark-god.3.b.quest.nbl"},  {start, [0, 6302, 0]}, {sets, 4}]},
	{1003122, [{type, mission}, {file, "data/missions/dark-god.3.a.quest.nbl"},  {start, [0, 6302, 0]}, {sets, 4}]},
	{1003123, [{type, mission}, {file, "data/missions/dark-god.3.s.quest.nbl"},  {start, [0, 6302, 0]}, {sets, 4}]},
	{1003124, [{type, mission}, {file, "data/missions/dark-god.3.s2.quest.nbl"}, {start, [0, 6302, 0]}, {sets, 4}]},

	% Phantom Ruins (Linear Line counter)

	%~ {1060300, [{type, mission}, {file, "data/missions/phantom-ruins.c.quest.nbl"},  {start, [0, 8002, 0]}, {sets, 3}]},
	{1060301, [{type, mission}, {file, "data/missions/phantom-ruins.b.quest.nbl"},  {start, [0, 8002, 0]}, {sets, 3}]},
	%~ {1060302, [{type, mission}, {file, "data/missions/phantom-ruins.a.quest.nbl"},  {start, [0, 8002, 0]}, {sets, 3}]},
	{1060303, [{type, mission}, {file, "data/missions/phantom-ruins.s.quest.nbl"},  {start, [0, 8002, 0]}, {sets, 3}]},

	% Photon Eraser Return

	%~ {1070080, [{type, mission}, {file, "data/missions/photon-eraser-return.quest.nbl"}, {start, [0, 300, 0]}, {sets, 1}]},

	% Dark Crystal Seeker

	{1070742, [{type, mission}, {file, "data/missions/dark-crystal-seeker.quest.nbl"}, {start, [0, 1002, 0]}, {sets, 1}]},

	% MAG'

	{1072100, [{type, mission}, {file, "data/missions/mag-prime.c.quest.nbl"},  {start, [1, 5000, 0]}, {sets, 2}]},
	{1072101, [{type, mission}, {file, "data/missions/mag-prime.b.quest.nbl"},  {start, [1, 5000, 0]}, {sets, 2}]},
	{1072102, [{type, mission}, {file, "data/missions/mag-prime.a.quest.nbl"},  {start, [1, 5000, 0]}, {sets, 2}]},
	{1072103, [{type, mission}, {file, "data/missions/mag-prime.s.quest.nbl"},  {start, [1, 5000, 0]}, {sets, 2}]},
	{1072104, [{type, mission}, {file, "data/missions/mag-prime.s2.quest.nbl"}, {start, [1, 5000, 0]}, {sets, 2}]},

	% Gifts from Beyond

	{1072300, [{type, mission}, {file, "data/missions/gifts-from-beyond-plus.quest.nbl"}, {start, [0, 300, 0]}, {sets, 1}]},

	% Airboard Rally

	{1090700, [{type, mission}, {file, "data/missions/airboard-rally.quest.nbl"}, {start, [0, 800, 0]}, {sets, 1}]},

	% Planetary lobbies

	{1100000, [{type, lobby}, {file, nofile}]},
	{1101000, [{type, lobby}, {file, nofile}]},
	{1102000, [{type, lobby}, {file, "data/lobby/neudaiz.quest.nbl"}]},
	{1103000, [{type, lobby}, {file, "data/lobby/moatoob.quest.nbl"}]},

	{1104000, [{type, spaceport}, {file, "data/lobby/spaceport.quest.nbl"}]},

	% Tutorial

	{1106000, [{type, lobby}, {file, "data/tutorial/lobby.quest.nbl"}]},

	% SEED-Form Purge

	{1113000, [{type, mission}, {file, "data/tutorial/seed-form-purge.hyuga.quest.nbl"}, {start, [0, 1121, 0]}, {sets, 1}]},
	{1113001, [{type, mission}, {file, "data/tutorial/seed-form-purge.maya.quest.nbl"}, {start, [0, 1121, 0]}, {sets, 1}]},
	{1113002, [{type, mission}, {file, "data/tutorial/seed-form-purge.lou.quest.nbl"}, {start, [0, 1121, 0]}, {sets, 1}]},
	{1113003, [{type, mission}, {file, "data/tutorial/seed-form-purge.leo.quest.nbl"}, {start, [0, 1121, 0]}, {sets, 1}]},

	% My room

	{1120000, [{type, myroom}, {file, "data/rooms/test.quest.nbl"}]},

	% Story Episode 2

	{1131010, [{type, mission}, {file, "data/missions/ep2ch1.c.quest.nbl"}, {start, [0, 0, 0]}, {sets, 1}]},

	%% Boss Tests.
	{90120, [{type, mission}, {file, "data/missions/boss/lv1/alteraz/quest_ae.nbl"}, {start, [0, 100, 0]}, {sets, 1}]},
	{90130, [{type, mission}, {file, "data/missions/boss/lv1/rolei/quest_ae.nbl"}, {start, [0, 100, 0]}, {sets, 1}]},
	{90140, [{type, mission}, {file, "data/missions/boss/lv1/motherbrain/quest_ae.nbl"}, {start, [0, 100, 0]}, {sets, 1}]},
	{90150, [{type, mission}, {file, "data/missions/boss/lv1/falz1/quest_ae.nbl"}, {start, [0, 100, 0]}, {sets, 1}]},
	{90160, [{type, mission}, {file, "data/missions/boss/lv1/falz2/quest_ae.nbl"}, {start, [0, 100, 0]}, {sets, 1}]},

	%% v1 Free Missions.
	{110000, [{type, mission}, {file, "data/missions/v1/evacuation/quest_ae.nbl"}, {start, [0, 1130, 0]}, {sets, 1}]},
	{110010, [{type, mission}, {file, "data/missions/v1/annihilation/quest_ae.nbl"}, {start, [0, 1300, 0]}, {sets, 1}]},
	{110100, [{type, mission}, {file, "data/missions/v1/dark-satellite/quest_ae.nbl"}, {start, [0, 111, 0]}, {sets, 1}]},
	{111000, [{type, mission}, {file, "data/missions/v1/creature-discomfort/quest_ae.nbl"}, {start, [0, 101, 0]}, {sets, 1}]},
	{111010, [{type, mission}, {file, "data/missions/v1/burning-plains/quest_ae.nbl"}, {start, [0, 1120, 0]}, {sets, 1}]},
	{111020, [{type, mission}, {file, "data/missions/v1/mad-beasts/quest_ae.nbl"}, {start, [0, 1130, 0]}, {sets, 1}]},
	{111030, [{type, mission}, {file, "data/missions/v1/ruler-of-the-plains/quest_ae.nbl"}, {start, [0, 110, 0]}, {sets, 1}]},
	{111100, [{type, mission}, {file, "data/missions/v1/what-is-in-the-ruins/quest_ae.nbl"}, {start, [0, 1102, 0]}, {sets, 1}]},
	{111110, [{type, mission}, {file, "data/missions/v1/two-headed-sentinel/quest_ae.nbl"}, {start, [0, 1211, 0]}, {sets, 1}]},
	{111200, [{type, mission}, {file, "data/missions/v1/cargo-train-rescue/quest_ae.nbl"}, {start, [0, 105, 3]}, {sets, 1}]},
	{111300, [{type, mission}, {file, "data/missions/v1/endrum-underground/quest_ae.nbl"}, {start, [0, 110, 0]}, {sets, 1}]},
	{112000, [{type, mission}, {file, "data/missions/v1/mizuraki-devastation/quest_ae.nbl"}, {start, [0, 101, 0]}, {sets, 1}]},
	{112010, [{type, mission}, {file, "data/missions/v1/frozen-woods/quest_ae.nbl"}, {start, [0, 1111, 0]}, {sets, 1}]},
	{112020, [{type, mission}, {file, "data/missions/v1/demons-above/quest_ae.nbl"}, {start, [0, 3115, 0]}, {sets, 1}]},
	{112100, [{type, mission}, {file, "data/missions/v1/defend-islands/quest_ae.nbl"}, {start, [0, 3120, 0]}, {sets, 1}]},
	{112120, [{type, mission}, {file, "data/missions/v1/woodland-flames/quest_ae.nbl"}, {start, [0, 1220, 0]}, {sets, 1}]},
	{112200, [{type, mission}, {file, "data/missions/v1/grove-of-fanatics/quest_ae.nbl"}, {start, [0, 104, 0]}, {sets, 1}]},
	{112210, [{type, mission}, {file, "data/missions/v1/temple-of-ice/quest_ae.nbl"}, {start, [0, 1201, 0]}, {sets, 1}]},
	{113000, [{type, mission}, {file, "data/missions/v1/pandemonium/quest_ae.nbl"}, {start, [0, 3110, 0]}, {sets, 1}]},
	{113100, [{type, mission}, {file, "data/missions/v1/tunnel-infestation/quest_ae.nbl"}, {start, [0, 210, 0]}, {sets, 1}]},
	{113200, [{type, mission}, {file, "data/missions/v1/goliath-in-the-desert/quest_ae.nbl"}, {start, [0, 3120, 0]}, {sets, 1}]},
	{113230, [{type, mission}, {file, "data/missions/v1/absolute-zero/quest_ae.nbl"}, {start, [0, 1221, 0]}, {sets, 1}]},
	{113240, [{type, mission}, {file, "data/missions/v1/terror-in-the-desert/quest_ae.nbl"}, {start, [0, 4240, 0]}, {sets, 1}]}
]).

-define(ZONES, [
	% Unsafe Passage

	{[1000000, 0], [{file, "data/missions/unsafe-passage.1.c.zone.nbl"}, {sets, 4}]},
	{[1000001, 0], [{file, "data/missions/unsafe-passage.1.b.zone.nbl"}, {sets, 4}]},
	{[1000002, 0], [{file, "data/missions/unsafe-passage.1.a.zone.nbl"}, {sets, 4}]},
	{[1000003, 0], [{file, "data/missions/unsafe-passage.1.s.zone.nbl"}, {sets, 4}]},
	{[1000004, 0], [{file, "data/missions/unsafe-passage.1.s2.zone.nbl"}, {sets, 4}]},

	{[1000010, 0], [{file, "data/missions/unsafe-passage.2.c.zone.nbl"}, {sets, 4}]},
	{[1000011, 0], [{file, "data/missions/unsafe-passage.2.b.zone.nbl"}, {sets, 4}]},
	{[1000012, 0], [{file, "data/missions/unsafe-passage.2.a.zone.nbl"}, {sets, 4}]},
	{[1000013, 0], [{file, "data/missions/unsafe-passage.2.s.zone.nbl"}, {sets, 4}]},
	{[1000014, 0], [{file, "data/missions/unsafe-passage.2.s2.zone.nbl"}, {sets, 4}]},

	{[1000020, 0], [{file, "data/missions/unsafe-passage.3.c.zone.nbl"}, {sets, 4}]},
	{[1000021, 0], [{file, "data/missions/unsafe-passage.3.b.zone.nbl"}, {sets, 4}]},
	{[1000022, 0], [{file, "data/missions/unsafe-passage.3.a.zone.nbl"}, {sets, 4}]},
	{[1000023, 0], [{file, "data/missions/unsafe-passage.3.s.zone.nbl"}, {sets, 4}]},
	{[1000024, 0], [{file, "data/missions/unsafe-passage.3.s2.zone.nbl"}, {sets, 4}]},

	% Fight for Food

	{[1000100, 0], [{file, "data/missions/fight-for-food.1.c.zone.nbl"}, {sets, 4}]},
	{[1000101, 0], [{file, "data/missions/fight-for-food.1.b.zone.nbl"}, {sets, 4}]},
	%~ {[1000102, 0], [{file, "data/missions/fight-for-food.1.a.zone.nbl"}, {sets, 4}]},
	%~ {[1000103, 0], [{file, "data/missions/fight-for-food.1.s.zone.nbl"}, {sets, 4}]},
	{[1000104, 0], [{file, "data/missions/fight-for-food.1.s2.zone.nbl"}, {sets, 4}]},

	{[1000110, 0], [{file, "data/missions/fight-for-food.2.c.zone.nbl"}, {sets, 4}]},
	%~ {[1000111, 0], [{file, "data/missions/fight-for-food.2.b.zone.nbl"}, {sets, 4}]},
	%~ {[1000112, 0], [{file, "data/missions/fight-for-food.2.a.zone.nbl"}, {sets, 4}]},
	%~ {[1000113, 0], [{file, "data/missions/fight-for-food.2.s.zone.nbl"}, {sets, 4}]},
	{[1000114, 0], [{file, "data/missions/fight-for-food.2.s2.zone.nbl"}, {sets, 4}]},

	{[1000120, 0], [{file, "data/missions/fight-for-food.3.c.zone.nbl"}, {sets, 4}]},
	%~ {[1000121, 0], [{file, "data/missions/fight-for-food.3.b.zone.nbl"}, {sets, 4}]},
	{[1000122, 0], [{file, "data/missions/fight-for-food.3.a.zone.nbl"}, {sets, 4}]},
	%~ {[1000123, 0], [{file, "data/missions/fight-for-food.3.s.zone.nbl"}, {sets, 4}]},
	{[1000124, 0], [{file, "data/missions/fight-for-food.3.s2.zone.nbl"}, {sets, 4}]},

	% Dark Satellite

	{[1001000, 0], [{file, "data/missions/dark-satellite.1.c.zone.nbl"}, {sets, 4}]},
	{[1001001, 0], [{file, "data/missions/dark-satellite.1.b.zone.nbl"}, {sets, 4}]},
	{[1001002, 0], [{file, "data/missions/dark-satellite.1.a.zone.nbl"}, {sets, 4}]},
	%~ {[1001003, 0], [{file, "data/missions/dark-satellite.1.s.zone.nbl"}, {sets, 4}]},
	{[1001004, 0], [{file, "data/missions/dark-satellite.1.s2.zone.nbl"}, {sets, 4}]},
	{[1001005, 0], [{file, "data/missions/dark-satellite.1.s3.zone.nbl"}, {sets, 4}]},

	{[1001010, 0], [{file, "data/missions/dark-satellite.2.c.zone.nbl"}, {sets, 4}]},
	{[1001011, 0], [{file, "data/missions/dark-satellite.2.b.zone.nbl"}, {sets, 4}]},
	{[1001012, 0], [{file, "data/missions/dark-satellite.2.a.zone.nbl"}, {sets, 4}]},
	{[1001013, 0], [{file, "data/missions/dark-satellite.2.s.zone.nbl"}, {sets, 4}]},
	%~ {[1001014, 0], [{file, "data/missions/dark-satellite.2.s2.zone.nbl"}, {sets, 4}]},
	%~ {[1001015, 0], [{file, "data/missions/dark-satellite.2.s3.zone.nbl"}, {sets, 4}]},

	{[1001020, 0], [{file, "data/missions/dark-satellite.3.c.zone.nbl"}, {sets, 4}]},
	%~ {[1001021, 0], [{file, "data/missions/dark-satellite.3.b.zone.nbl"}, {sets, 4}]},
	{[1001022, 0], [{file, "data/missions/dark-satellite.3.a.zone.nbl"}, {sets, 4}]},
	%~ {[1001023, 0], [{file, "data/missions/dark-satellite.3.s.zone.nbl"}, {sets, 4}]},
	{[1001024, 0], [{file, "data/missions/dark-satellite.3.s2.zone.nbl"}, {sets, 4}]},
	{[1001025, 0], [{file, "data/missions/dark-satellite.3.s3.zone.nbl"}, {sets, 4}]},

	% Seed Awakening

	%~ {[1001100, 0], [{file, "data/missions/seed-awakening.1.c.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001100, 1], [{file, "data/missions/seed-awakening.1.c.zone-1.nbl"}, {sets, 1}]},
	{[1001101, 0], [{file, "data/missions/seed-awakening.1.b.zone-0.nbl"}, {sets, 4}]},
	{[1001101, 1], [{file, "data/missions/seed-awakening.1.b.zone-1.nbl"}, {sets, 1}]},
	{[1001102, 0], [{file, "data/missions/seed-awakening.1.a.zone-0.nbl"}, {sets, 4}]},
	{[1001102, 1], [{file, "data/missions/seed-awakening.1.a.zone-1.nbl"}, {sets, 1}]},
	{[1001103, 0], [{file, "data/missions/seed-awakening.1.s.zone-0.nbl"}, {sets, 4}]},
	{[1001103, 1], [{file, "data/missions/seed-awakening.1.s.zone-1.nbl"}, {sets, 1}]},
	{[1001103, 2], [{file, "data/missions/seed-awakening.1.s.zone-2.nbl"}, {sets, 1}]},
	{[1001104, 0], [{file, "data/missions/seed-awakening.1.s2.zone-0.nbl"}, {sets, 4}]},
	{[1001104, 1], [{file, "data/missions/seed-awakening.1.s2.zone-1.nbl"}, {sets, 1}]},
	{[1001104, 2], [{file, "data/missions/seed-awakening.1.s2.zone-2.nbl"}, {sets, 1}]},
	{[1001105, 0], [{file, "data/missions/seed-awakening.1.s3.zone-0.nbl"}, {sets, 4}]},
	{[1001105, 1], [{file, "data/missions/seed-awakening.1.s3.zone-1.nbl"}, {sets, 1}]},
	{[1001105, 2], [{file, "data/missions/seed-awakening.1.s3.zone-2.nbl"}, {sets, 1}]},

	{[1001110, 0], [{file, "data/missions/seed-awakening.2.c.zone-0.nbl"}, {sets, 4}]},
	{[1001110, 1], [{file, "data/missions/seed-awakening.2.c.zone-1.nbl"}, {sets, 1}]},
	{[1001111, 0], [{file, "data/missions/seed-awakening.2.b.zone-0.nbl"}, {sets, 4}]},
	{[1001111, 1], [{file, "data/missions/seed-awakening.2.b.zone-1.nbl"}, {sets, 1}]},
	{[1001112, 0], [{file, "data/missions/seed-awakening.2.a.zone-0.nbl"}, {sets, 4}]},
	{[1001112, 1], [{file, "data/missions/seed-awakening.2.a.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001113, 0], [{file, "data/missions/seed-awakening.2.s.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001113, 1], [{file, "data/missions/seed-awakening.2.s.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001113, 2], [{file, "data/missions/seed-awakening.2.s.zone-2.nbl"}, {sets, 1}]},
	{[1001114, 0], [{file, "data/missions/seed-awakening.2.s2.zone-0.nbl"}, {sets, 4}]},
	{[1001114, 1], [{file, "data/missions/seed-awakening.2.s2.zone-1.nbl"}, {sets, 1}]},
	{[1001114, 2], [{file, "data/missions/seed-awakening.2.s2.zone-2.nbl"}, {sets, 1}]},
	{[1001115, 0], [{file, "data/missions/seed-awakening.2.s3.zone-0.nbl"}, {sets, 4}]},
	{[1001115, 1], [{file, "data/missions/seed-awakening.2.s3.zone-1.nbl"}, {sets, 1}]},
	{[1001115, 2], [{file, "data/missions/seed-awakening.2.s3.zone-2.nbl"}, {sets, 1}]},

	{[1001120, 0], [{file, "data/missions/seed-awakening.3.c.zone-0.nbl"}, {sets, 4}]},
	{[1001120, 1], [{file, "data/missions/seed-awakening.3.c.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001121, 0], [{file, "data/missions/seed-awakening.3.b.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001121, 1], [{file, "data/missions/seed-awakening.3.b.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001122, 0], [{file, "data/missions/seed-awakening.3.a.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001122, 1], [{file, "data/missions/seed-awakening.3.a.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001123, 0], [{file, "data/missions/seed-awakening.3.s.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001123, 1], [{file, "data/missions/seed-awakening.3.s.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001123, 2], [{file, "data/missions/seed-awakening.3.s.zone-2.nbl"}, {sets, 1}]},
	{[1001124, 0], [{file, "data/missions/seed-awakening.3.s2.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001124, 1], [{file, "data/missions/seed-awakening.3.s2.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001124, 2], [{file, "data/missions/seed-awakening.3.s2.zone-2.nbl"}, {sets, 1}]},
	{[1001125, 0], [{file, "data/missions/seed-awakening.3.s3.zone-0.nbl"}, {sets, 4}]},
	{[1001125, 1], [{file, "data/missions/seed-awakening.3.s3.zone-1.nbl"}, {sets, 1}]},
	{[1001125, 2], [{file, "data/missions/seed-awakening.3.s3.zone-2.nbl"}, {sets, 1}]},

	% True Darkness

	%~ {[1001200, 0], [{file, "data/missions/true-darkness.1.c.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001200, 1], [{file, "data/missions/true-darkness.1.c.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001201, 0], [{file, "data/missions/true-darkness.1.b.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001201, 1], [{file, "data/missions/true-darkness.1.b.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001202, 0], [{file, "data/missions/true-darkness.1.a.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001202, 1], [{file, "data/missions/true-darkness.1.a.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001203, 0], [{file, "data/missions/true-darkness.1.s.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001203, 1], [{file, "data/missions/true-darkness.1.s.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001204, 0], [{file, "data/missions/true-darkness.1.s2.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001204, 1], [{file, "data/missions/true-darkness.1.s2.zone-1.nbl"}, {sets, 1}]},

	{[1001210, 0], [{file, "data/missions/true-darkness.2.c.zone-0.nbl"}, {sets, 4}]},
	{[1001210, 1], [{file, "data/missions/true-darkness.2.c.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001211, 0], [{file, "data/missions/true-darkness.2.b.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001211, 1], [{file, "data/missions/true-darkness.2.b.zone-1.nbl"}, {sets, 1}]},
	{[1001212, 0], [{file, "data/missions/true-darkness.2.a.zone-0.nbl"}, {sets, 4}]},
	{[1001212, 1], [{file, "data/missions/true-darkness.2.a.zone-1.nbl"}, {sets, 1}]},
	{[1001213, 0], [{file, "data/missions/true-darkness.2.s.zone-0.nbl"}, {sets, 4}]},
	{[1001213, 1], [{file, "data/missions/true-darkness.2.s.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001214, 0], [{file, "data/missions/true-darkness.2.s2.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001214, 1], [{file, "data/missions/true-darkness.2.s2.zone-1.nbl"}, {sets, 1}]},

	{[1001220, 0], [{file, "data/missions/true-darkness.3.c.zone-0.nbl"}, {sets, 4}]},
	{[1001220, 1], [{file, "data/missions/true-darkness.3.c.zone-1.nbl"}, {sets, 1}]},
	{[1001221, 0], [{file, "data/missions/true-darkness.3.b.zone-0.nbl"}, {sets, 4}]},
	{[1001221, 1], [{file, "data/missions/true-darkness.3.b.zone-1.nbl"}, {sets, 1}]},
	{[1001222, 0], [{file, "data/missions/true-darkness.3.a.zone-0.nbl"}, {sets, 4}]},
	{[1001222, 1], [{file, "data/missions/true-darkness.3.a.zone-1.nbl"}, {sets, 1}]},
	%~ {[1001223, 0], [{file, "data/missions/true-darkness.3.s.zone-0.nbl"}, {sets, 4}]},
	%~ {[1001223, 1], [{file, "data/missions/true-darkness.3.s.zone-1.nbl"}, {sets, 1}]},
	{[1001224, 0], [{file, "data/missions/true-darkness.3.s2.zone-0.nbl"}, {sets, 4}]},
	{[1001224, 1], [{file, "data/missions/true-darkness.3.s2.zone-1.nbl"}, {sets, 1}]},

	% The Black Nest

	{[1003000, 0], [{file, "data/missions/black-nest.1.c.zone.nbl"}, {sets, 4}]},
	{[1003001, 0], [{file, "data/missions/black-nest.1.b.zone.nbl"}, {sets, 4}]},
	{[1003002, 0], [{file, "data/missions/black-nest.1.a.zone.nbl"}, {sets, 4}]},
	{[1003003, 0], [{file, "data/missions/black-nest.1.s.zone.nbl"}, {sets, 4}]},
	{[1003004, 0], [{file, "data/missions/black-nest.1.s2.zone.nbl"}, {sets, 4}]},

	{[1003010, 0], [{file, "data/missions/black-nest.2.c.zone.nbl"}, {sets, 4}]},
	%~ {[1003011, 0], [{file, "data/missions/black-nest.2.b.zone.nbl"}, {sets, 4}]},
	%~ {[1003012, 0], [{file, "data/missions/black-nest.2.a.zone.nbl"}, {sets, 4}]},
	%~ {[1003013, 0], [{file, "data/missions/black-nest.2.s.zone.nbl"}, {sets, 4}]},
	{[1003014, 0], [{file, "data/missions/black-nest.2.s2.zone.nbl"}, {sets, 4}]},

	{[1003020, 0], [{file, "data/missions/black-nest.3.c.zone.nbl"}, {sets, 4}]},
	{[1003021, 0], [{file, "data/missions/black-nest.3.b.zone.nbl"}, {sets, 4}]},
	%~ {[1003022, 0], [{file, "data/missions/black-nest.3.a.zone.nbl"}, {sets, 4}]},
	{[1003023, 0], [{file, "data/missions/black-nest.3.s.zone.nbl"}, {sets, 4}]},
	%~ {[1003024, 0], [{file, "data/missions/black-nest.3.s2.zone.nbl"}, {sets, 4}]},

	% The Dark God

	{[1003100, 0], [{file, "data/missions/dark-god.1.c.zone-0.nbl"}, {sets, 4}]},
	{[1003100, 1], [{file, "data/missions/dark-god.1.c.zone-1.nbl"}, {sets, 1}]},
	%~ {[1003101, 0], [{file, "data/missions/dark-god.1.b.zone-0.nbl"}, {sets, 4}]},
	%~ {[1003101, 1], [{file, "data/missions/dark-god.1.b.zone-1.nbl"}, {sets, 1}]},
	{[1003102, 0], [{file, "data/missions/dark-god.1.a.zone-0.nbl"}, {sets, 4}]},
	%~ {[1003102, 1], [{file, "data/missions/dark-god.1.a.zone-1.nbl"}, {sets, 1}]},
	{[1003103, 0], [{file, "data/missions/dark-god.1.s.zone-0.nbl"}, {sets, 4}]},
	{[1003103, 1], [{file, "data/missions/dark-god.1.s.zone-1.nbl"}, {sets, 1}]},
	{[1003104, 0], [{file, "data/missions/dark-god.1.s2.zone-0.nbl"}, {sets, 4}]},
	{[1003104, 1], [{file, "data/missions/dark-god.1.s2.zone-1.nbl"}, {sets, 1}]},
	{[1003104, 2], [{file, "data/missions/dark-god.1.s2.zone-2.nbl"}, {sets, 1}]},

	{[1003110, 0], [{file, "data/missions/dark-god.2.c.zone-0.nbl"}, {sets, 4}]},
	{[1003110, 1], [{file, "data/missions/dark-god.2.c.zone-1.nbl"}, {sets, 1}]},
	{[1003111, 0], [{file, "data/missions/dark-god.2.b.zone-0.nbl"}, {sets, 4}]},
	{[1003111, 1], [{file, "data/missions/dark-god.2.b.zone-1.nbl"}, {sets, 1}]},
	{[1003112, 0], [{file, "data/missions/dark-god.2.a.zone-0.nbl"}, {sets, 4}]},
	{[1003112, 1], [{file, "data/missions/dark-god.2.a.zone-1.nbl"}, {sets, 1}]},
	{[1003113, 0], [{file, "data/missions/dark-god.2.s.zone-0.nbl"}, {sets, 4}]},
	%~ {[1003113, 1], [{file, "data/missions/dark-god.2.s.zone-1.nbl"}, {sets, 1}]},
	{[1003114, 0], [{file, "data/missions/dark-god.2.s2.zone-0.nbl"}, {sets, 4}]},
	{[1003114, 1], [{file, "data/missions/dark-god.2.s2.zone-1.nbl"}, {sets, 1}]},
	{[1003114, 2], [{file, "data/missions/dark-god.2.s2.zone-2.nbl"}, {sets, 1}]},

	{[1003120, 0], [{file, "data/missions/dark-god.3.c.zone-0.nbl"}, {sets, 4}]},
	{[1003120, 1], [{file, "data/missions/dark-god.3.c.zone-1.nbl"}, {sets, 1}]},
	{[1003121, 0], [{file, "data/missions/dark-god.3.b.zone-0.nbl"}, {sets, 4}]},
	{[1003121, 1], [{file, "data/missions/dark-god.3.b.zone-1.nbl"}, {sets, 1}]},
	{[1003122, 0], [{file, "data/missions/dark-god.3.a.zone-0.nbl"}, {sets, 4}]},
	{[1003122, 1], [{file, "data/missions/dark-god.3.a.zone-1.nbl"}, {sets, 1}]},
	{[1003123, 0], [{file, "data/missions/dark-god.3.s.zone-0.nbl"}, {sets, 4}]},
	{[1003123, 1], [{file, "data/missions/dark-god.3.s.zone-1.nbl"}, {sets, 1}]},
	{[1003124, 0], [{file, "data/missions/dark-god.3.s2.zone-0.nbl"}, {sets, 4}]},
	{[1003124, 1], [{file, "data/missions/dark-god.3.s2.zone-1.nbl"}, {sets, 1}]},
	{[1003124, 2], [{file, "data/missions/dark-god.3.s2.zone-2.nbl"}, {sets, 1}]},

	% Phantom Ruins (Linear Line counter)

	%~ {[1060300, 0], [{file, "data/missions/phantom-ruins.c-0.zone.nbl"}, {sets, 3}]},
	%~ {[1060300, 1], [{file, "data/missions/phantom-ruins.c-1.zone.nbl"}, {sets, 1}]},
	{[1060301, 0], [{file, "data/missions/phantom-ruins.b-0.zone.nbl"}, {sets, 3}]},
	{[1060301, 1], [{file, "data/missions/phantom-ruins.b-1.zone.nbl"}, {sets, 1}]},
	%~ {[1060302, 0], [{file, "data/missions/phantom-ruins.a-0.zone.nbl"}, {sets, 3}]},
	%~ {[1060302, 1], [{file, "data/missions/phantom-ruins.a-1.zone.nbl"}, {sets, 1}]},
	{[1060303, 0], [{file, "data/missions/phantom-ruins.s-0.zone.nbl"}, {sets, 3}]},
	{[1060303, 1], [{file, "data/missions/phantom-ruins.s-1.zone.nbl"}, {sets, 1}]},

	% Photon Eraser Return

	%~ {[1070080, 0], [{file, "data/missions/photon-eraser-return.zone.nbl"}, {sets, 1}]},

	% Dark Crystal Seeker

	{[1070742, 0], [{file, "data/missions/dark-crystal-seeker.zone.nbl"}, {sets, 1}]},

	% MAG'

	{[1072100, 1], [{file, "data/missions/mag-prime.c.zone-1.nbl"}, {sets, 1}]},
	{[1072100, 2], [{file, "data/missions/mag-prime.c.zone-2.nbl"}, {sets, 2}]},
	{[1072100, 3], [{file, "data/missions/mag-prime.c.zone-3.nbl"}, {sets, 1}]},
	{[1072101, 1], [{file, "data/missions/mag-prime.b.zone-1.nbl"}, {sets, 1}]},
	{[1072101, 2], [{file, "data/missions/mag-prime.b.zone-2.nbl"}, {sets, 2}]},
	%~ {[1072101, 3], [{file, "data/missions/mag-prime.b.zone-3.nbl"}, {sets, 1}]},
	{[1072102, 1], [{file, "data/missions/mag-prime.a.zone-1.nbl"}, {sets, 1}]},
	{[1072102, 2], [{file, "data/missions/mag-prime.a.zone-2.nbl"}, {sets, 2}]},
	{[1072102, 3], [{file, "data/missions/mag-prime.a.zone-3.nbl"}, {sets, 1}]},
	{[1072103, 1], [{file, "data/missions/mag-prime.s.zone-1.nbl"}, {sets, 1}]},
	{[1072103, 2], [{file, "data/missions/mag-prime.s.zone-2.nbl"}, {sets, 2}]},
	{[1072103, 3], [{file, "data/missions/mag-prime.s.zone-3.nbl"}, {sets, 1}]},
	{[1072104, 1], [{file, "data/missions/mag-prime.s2.zone-1.nbl"}, {sets, 1}]},
	{[1072104, 2], [{file, "data/missions/mag-prime.s2.zone-2.nbl"}, {sets, 2}]},
	{[1072104, 3], [{file, "data/missions/mag-prime.s2.zone-3.nbl"}, {sets, 1}]},

	% Gifts from Beyond

	{[1072300, 0], [{file, "data/missions/gifts-from-beyond-plus.zone.nbl"}, {sets, 1}]},

	% Airboard Rally

	{[1090700, 0], [{file, "data/missions/airboard-rally.zone.nbl"}, {sets, 1}]},

	% Colony

	{[1100000, 0], [{file, "data/lobby/colony.zone-0.nbl"}]},
	{[1100000, 1], [{file, "data/lobby/colony.zone-1.nbl"}]},
	{[1100000, 2], [{file, "data/lobby/colony.zone-2.nbl"}]},
	{[1100000, 3], [{file, "data/lobby/colony.zone-3.nbl"}]},
	{[1100000, 4], [{file, "data/lobby/colony.zone-4.nbl"}]},
	{[1100000, 7], [{file, "data/lobby/colony.zone-7.nbl"}]},
	{[1100000,11], [{file, "data/lobby/colony.zone-11.nbl"}]},
	{[1100000,12], [{file, "data/lobby/colony.zone-12.nbl"}]},
	{[1100000,13], [{file, "data/lobby/colony.zone-13.nbl"}]},

	% Parum

	{[1101000, 0], [{file, "data/lobby/parum.zone-0.nbl"}]},
	{[1101000, 1], [{file, "data/lobby/parum.zone-1.nbl"}]},
	{[1101000, 2], [{file, "data/lobby/parum.zone-2.nbl"}]},
	{[1101000, 3], [{file, "data/lobby/parum.zone-3.nbl"}]},
	{[1101000, 4], [{file, "data/lobby/parum.zone-4.nbl"}]},
	{[1101000, 5], [{file, "data/lobby/parum.zone-5.nbl"}]},
	{[1101000, 7], [{file, "data/lobby/parum.zone-7.nbl"}]},
	{[1101000,11], [{file, "data/lobby/parum.zone-11.nbl"}]},
	{[1101000,12], [{file, "data/lobby/parum.zone-12.nbl"}]},
	{[1101000,13], [{file, "data/lobby/parum.zone-13.nbl"}]},

	% Neudaiz

	{[1102000, 0], [{file, "data/lobby/neudaiz.zone-0.nbl"}]},
	{[1102000, 1], [{file, "data/lobby/neudaiz.zone-1.nbl"}]},
	{[1102000, 2], [{file, "data/lobby/neudaiz.zone-2.nbl"}]},
	{[1102000, 3], [{file, "data/lobby/neudaiz.zone-3.nbl"}]},
	{[1102000, 4], [{file, "data/lobby/neudaiz.zone-4.nbl"}]},
	{[1102000, 7], [{file, "data/lobby/neudaiz.zone-7.nbl"}]},
	{[1102000,11], [{file, "data/lobby/neudaiz.zone-11.nbl"}]},
	{[1102000,12], [{file, "data/lobby/neudaiz.zone-12.nbl"}]},
	{[1102000,13], [{file, "data/lobby/neudaiz.zone-13.nbl"}]},

	% Moatoob

	{[1103000, 0], [{file, "data/lobby/moatoob.zone-0.nbl"}]},
	{[1103000, 1], [{file, "data/lobby/moatoob.zone-1.nbl"}]},
	{[1103000, 3], [{file, "data/lobby/moatoob.zone-3.nbl"}]},
	{[1103000, 4], [{file, "data/lobby/moatoob.zone-4.nbl"}]},
	{[1103000, 5], [{file, "data/lobby/moatoob.zone-5.nbl"}]},
	{[1103000, 6], [{file, "data/lobby/moatoob.zone-6.nbl"}]},
	{[1103000, 7], [{file, "data/lobby/moatoob.zone-7.nbl"}]},
	{[1103000,11], [{file, "data/lobby/moatoob.zone-11.nbl"}]},
	{[1103000,12], [{file, "data/lobby/moatoob.zone-12.nbl"}]},
	{[1103000,13], [{file, "data/lobby/moatoob.zone-13.nbl"}]},

	% Spaceport

	{[1104000, 0], [{file, "data/lobby/spaceport.zone.nbl"}]},

	% Tutorial (colony)

	{[1106000, 0], [{file, "data/tutorial/lobby.zone-0.nbl"}]},
	{[1106000, 1], [{file, "data/tutorial/lobby.zone-1.nbl"}]},

	% SEED-Form Purge

	{[1113000, 0], [{file, "data/tutorial/seed-form-purge.hyuga.zone.nbl"}, {sets, 1}]},
	{[1113001, 0], [{file, "data/tutorial/seed-form-purge.maya.zone.nbl"}, {sets, 1}]},
	{[1113002, 0], [{file, "data/tutorial/seed-form-purge.lou.zone.nbl"}, {sets, 1}]},
	{[1113003, 0], [{file, "data/tutorial/seed-form-purge.leo.zone.nbl"}, {sets, 1}]},

	% My room

	{[1120000, 0], [{file, "data/rooms/test.zone.nbl"}]},

	% Tutorial (my room)

	{[1120000,10], [{file, "data/tutorial/myroom.zone.nbl"}]},

	% Story Episode 2

	{[1131010,0], [{file, "data/missions/ep2ch1.c.zone-0.nbl"}]},
	{[1131010,1], [{file, "data/missions/ep2ch1.c.zone-1.nbl"}]},
	{[1131010,2], [{file, "data/missions/ep2ch1.c.zone-2.nbl"}]},
	{[1131010,3], [{file, "data/missions/ep2ch1.c.zone-3.nbl"}]},

	%% Boss Tests.
	{[90120, 0], [{file, "data/missions/boss/lv1/alteraz/zone00_ae.nbl"}, {sets, 1}]},
	{[90120, 1], [{file, "data/missions/boss/lv1/alteraz/zone01_ae.nbl"}, {sets, 1}]},
	{[90130, 0], [{file, "data/missions/boss/lv1/rolei/zone00_ae.nbl"}, {sets, 1}]},
	{[90130, 1], [{file, "data/missions/boss/lv1/rolei/zone01_ae.nbl"}, {sets, 1}]},
	{[90140, 0], [{file, "data/missions/boss/lv1/motherbrain/zone00_ae.nbl"}, {sets, 1}]},
	{[90140, 1], [{file, "data/missions/boss/lv1/motherbrain/zone01_ae.nbl"}, {sets, 1}]},
	{[90150, 0], [{file, "data/missions/boss/lv1/falz1/zone00_ae.nbl"}, {sets, 1}]},
	{[90150, 1], [{file, "data/missions/boss/lv1/falz1/zone01_ae.nbl"}, {sets, 1}]},
	{[90160, 0], [{file, "data/missions/boss/lv1/falz2/zone00_ae.nbl"}, {sets, 1}]},
	{[90160, 1], [{file, "data/missions/boss/lv1/falz2/zone01_ae.nbl"}, {sets, 1}]},

	%% v1 Free Missions.
	{[110000, 0], [{file, "data/missions/v1/evacuation/zone00_ae.nbl"}, {sets, 1}]},
	{[110010, 0], [{file, "data/missions/v1/annihilation/zone00_ae.nbl"}, {sets, 1}]},
	{[110100, 0], [{file, "data/missions/v1/dark-satellite/zone00_ae.nbl"}, {sets, 1}]},
	{[110100, 1], [{file, "data/missions/v1/dark-satellite/zone01_ae.nbl"}, {sets, 1}]},
	{[110100, 2], [{file, "data/missions/v1/dark-satellite/zone02_ae.nbl"}, {sets, 1}]},
	{[111000, 0], [{file, "data/missions/v1/creature-discomfort/zone00_ae.nbl"}, {sets, 1}]},
	{[111010, 0], [{file, "data/missions/v1/burning-plains/zone00_ae.nbl"}, {sets, 1}]},
	{[111020, 0], [{file, "data/missions/v1/mad-beasts/zone00_ae.nbl"}, {sets, 1}]},
	{[111030, 0], [{file, "data/missions/v1/ruler-of-the-plains/zone00_ae.nbl"}, {sets, 1}]},
	{[111030, 1], [{file, "data/missions/v1/ruler-of-the-plains/zone01_ae.nbl"}, {sets, 1}]},
	{[111100, 0], [{file, "data/missions/v1/what-is-in-the-ruins/zone00_ae.nbl"}, {sets, 1}]},
	{[111100, 1], [{file, "data/missions/v1/what-is-in-the-ruins/zone01_ae.nbl"}, {sets, 1}]},
	{[111110, 0], [{file, "data/missions/v1/two-headed-sentinel/zone00_ae.nbl"}, {sets, 1}]},
	{[111110, 1], [{file, "data/missions/v1/two-headed-sentinel/zone01_ae.nbl"}, {sets, 1}]},
	{[111200, 0], [{file, "data/missions/v1/cargo-train-rescue/zone00_ae.nbl"}, {sets, 1}]},
	{[111300, 0], [{file, "data/missions/v1/endrum-underground/zone00_ae.nbl"}, {sets, 1}]},
	{[111300, 1], [{file, "data/missions/v1/endrum-underground/zone01_ae.nbl"}, {sets, 1}]},
	{[112000, 0], [{file, "data/missions/v1/mizuraki-devastation/zone00_ae.nbl"}, {sets, 1}]},
	{[112010, 0], [{file, "data/missions/v1/frozen-woods/zone00_ae.nbl"}, {sets, 1}]},
	{[112020, 0], [{file, "data/missions/v1/demons-above/zone00_ae.nbl"}, {sets, 1}]},
	{[112020, 1], [{file, "data/missions/v1/demons-above/zone01_ae.nbl"}, {sets, 1}]},
	{[112100, 0], [{file, "data/missions/v1/defend-islands/zone00_ae.nbl"}, {sets, 1}]},
	{[112120, 0], [{file, "data/missions/v1/woodland-flames/zone00_ae.nbl"}, {sets, 1}]},
	{[112200, 0], [{file, "data/missions/v1/grove-of-fanatics/zone00_ae.nbl"}, {sets, 1}]},
	{[112200, 1], [{file, "data/missions/v1/grove-of-fanatics/zone01_ae.nbl"}, {sets, 1}]},
	{[112210, 0], [{file, "data/missions/v1/temple-of-ice/zone00_ae.nbl"}, {sets, 1}]},
	{[113000, 0], [{file, "data/missions/v1/pandemonium/zone00_ae.nbl"}, {sets, 1}]},
	{[113100, 0], [{file, "data/missions/v1/tunnel-infestation/zone00_ae.nbl"}, {sets, 1}]},
	{[113200, 0], [{file, "data/missions/v1/goliath-in-the-desert/zone00_ae.nbl"}, {sets, 1}]},
	{[113200, 1], [{file, "data/missions/v1/goliath-in-the-desert/zone01_ae.nbl"}, {sets, 1}]},
	{[113230, 0], [{file, "data/missions/v1/absolute-zero/zone00_ae.nbl"}, {sets, 1}]},
	{[113240, 0], [{file, "data/missions/v1/terror-in-the-desert/zone00_ae.nbl"}, {sets, 1}]},
	{[113240, 1], [{file, "data/missions/v1/terror-in-the-desert/zone01_ae.nbl"}, {sets, 1}]}
]).

-define(MAPS, [
	% Colony

	{[1100000,   1], [{name, "Colony 1st Floor"}]},
	{[1100000,   2], [{name, "Colony 2nd Floor"}]},
	{[1100000,   3], [{name, "Colony 3rd Floor"}]},
	{[1100000,   4], [{name, "Colony 4th Floor"}]},
	{[1100000,   5], [{name, "Colony GUARDIANS"}]},
	{[1100000, 100], [{name, "Colony 2nd, Grind Shop"}]},
	{[1100000, 100], [{name, "Colony 2nd, Synth Shop"}]},
	{[1100000, 100], [{name, "Colony 2nd, Decos Shop"}]},
	{[1100000, 101], [{name, "Colony 2nd, Items Shop"}]},
	{[1100000, 101], [{name, "Colony 2nd, Weapons Shop"}]},
	{[1100000, 101], [{name, "Colony 2nd, Armors Shop"}]},
	{[1100000, 102], [{name, "Colony 3rd, Lumilass"}]},
	{[1100000, 102], [{name, "Colony 3rd, Clothes Shop"}]},
	{[1100000, 102], [{name, "Colony 3rd, Parts Shop"}]},
	{[1100000, 103], [{name, "Colony Club"}]},
	{[1100000, 110], [{name, "Colony R&D"}]},
	{[1100000,9000], [{name, "Colony Aurorey"}]},
	{[1100000,9001], [{name, "Colony Transfer Terminal"}]},
	{[1100000,9010], [{name, "Colony Dallgun"}]},
	{[1100000,9102], [{name, "Colony HIVE"}]},
	{[1100000,9200], [{name, "Colony Rykros"}]},
	{[1100000,9202], [{name, "Colony Falz Memoria"}]},

	% Parum

	{[1101000,   1], [{name, "Parum City Central"}]},
	{[1101000,   2], [{name, "Parum City West"}]},
	{[1101000,   3], [{name, "Parum City East"}]},
	{[1101000,   4], [{name, "Parum GUARDIANS"}]},
	{[1101000, 100], [{name, "Parum Synth Shop"}]},
	{[1101000, 100], [{name, "Parum Clothes Shop"}]},
	{[1101000, 100], [{name, "Parum Parts Shop"}]},
	{[1101000, 200], [{name, "Parum GRM"}]},
	{[1101000,9000], [{name, "Parum Raffon"}]},
	{[1101000,9010], [{name, "Parum Lakeshore"}]},
	{[1101000,9030], [{name, "Parum Waterfall"}]},
	{[1101000,9100], [{name, "Parum Denes"}]},
	{[1101000,9101], [{name, "Parum Underground"}]},
	{[1101000,9200], [{name, "Parum Beach"}]},
	{[1101000,9201], [{name, "Parum Rozenom"}]},
	{[1101000,9203], [{name, "Parum Subway"}]},
	{[1101000,9209], [{name, "Parum AMF"}]},

	% Neudaiz

	{[1102000,   1], [{name, "Neudaiz City"}]},
	{[1102000,   3], [{name, "Neudaiz GUARDIANS"}]},
	{[1102000, 100], [{name, "Neudaiz Synth Shop"}]},
	{[1102000, 100], [{name, "Neudaiz Clothes Shop"}]},
	{[1102000, 100], [{name, "Neudaiz Parts Shop"}]},
	{[1102000, 200], [{name, "Neudaiz Yohmei"}]},
	{[1102000,9000], [{name, "Neudaiz Islands"}]},
	{[1102000,9010], [{name, "Neudaiz Relics"}]},
	{[1102000,9100], [{name, "Neudaiz Mizuraki"}]},
	{[1102000,9120], [{name, "Neudaiz Hot Springs"}]},
	{[1102000,9300], [{name, "Neudaiz Temple"}]},
	{[1102000,9301], [{name, "Neudaiz Pavilion"}]},
	{[1102000,9302], [{name, "Neudaiz Habirao"}]},
	{[1102000,9305], [{name, "Neudaiz Saguraki"}]},

	% Moatoob

	{[1103000,   1], [{name, "Moatoob City"}]},
	{[1103000,   2], [{name, "Moatoob GUARDIANS"}]},
	{[1103000, 100], [{name, "Moatoob Parts Shop"}]},
	{[1103000, 100], [{name, "Moatoob Clothes Shop"}]},
	{[1103000, 100], [{name, "Moatoob Synth Shop"}]},
	{[1103000, 101], [{name, "Moatoob Pub"}]},
	{[1103000, 200], [{name, "Moatoob Tenora"}]},
	{[1103000,9010], [{name, "Moatoob Desert"}]},
	{[1103000,9030], [{name, "Moatoob Oasis"}]},
	{[1103000,9040], [{name, "Moatoob Glacier"}]},
	{[1103000,9101], [{name, "Moatoob Basin"}]},
	{[1103000,9202], [{name, "Moatoob Underground Lake"}]},
	{[1103000,9300], [{name, "Moatoob Casino"}]},
	{[1103000,9302], [{name, "Moatoob Il Cabo"}]},
	{[1103000,9304], [{name, "Moatoob Granigs"}]},

	% Spaceports

	{[1104000,900], [{name, "Spaceport"}]}
]).
