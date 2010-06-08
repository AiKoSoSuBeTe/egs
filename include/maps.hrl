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

%% EGS maps settings.

-define(QUESTS, [
	% Unsafe Passage

	{1000000, [{type, mission}, {file, "data/missions/unsafe-passage.1.c.quest.nbl"},  {start, [0, 1120, 0]}]},
	{1000001, [{type, mission}, {file, "data/missions/unsafe-passage.1.b.quest.nbl"},  {start, [0, 1120, 0]}]},
	{1000002, [{type, mission}, {file, "data/missions/unsafe-passage.1.a.quest.nbl"},  {start, [0, 1120, 0]}]},
	{1000003, [{type, mission}, {file, "data/missions/unsafe-passage.1.s.quest.nbl"},  {start, [0, 1120, 0]}]},
	{1000004, [{type, mission}, {file, "data/missions/unsafe-passage.1.s2.quest.nbl"}, {start, [0, 1120, 0]}]},

	{1000010, [{type, mission}, {file, "data/missions/unsafe-passage.2.c.quest.nbl"},  {start, [0, 1121, 0]}]},
	{1000011, [{type, mission}, {file, "data/missions/unsafe-passage.2.b.quest.nbl"},  {start, [0, 1121, 0]}]},
	{1000012, [{type, mission}, {file, "data/missions/unsafe-passage.2.a.quest.nbl"},  {start, [0, 1121, 0]}]},
	{1000013, [{type, mission}, {file, "data/missions/unsafe-passage.2.s.quest.nbl"},  {start, [0, 1121, 0]}]},
	{1000014, [{type, mission}, {file, "data/missions/unsafe-passage.2.s2.quest.nbl"}, {start, [0, 1121, 0]}]},

	{1000020, [{type, mission}, {file, "data/missions/unsafe-passage.3.c.quest.nbl"},  {start, [0, 1200, 0]}]},
	{1000021, [{type, mission}, {file, "data/missions/unsafe-passage.3.b.quest.nbl"},  {start, [0, 1200, 0]}]},
	{1000022, [{type, mission}, {file, "data/missions/unsafe-passage.3.a.quest.nbl"},  {start, [0, 1200, 0]}]},
	{1000023, [{type, mission}, {file, "data/missions/unsafe-passage.3.s.quest.nbl"},  {start, [0, 1200, 0]}]},
	{1000024, [{type, mission}, {file, "data/missions/unsafe-passage.3.s2.quest.nbl"}, {start, [0, 1200, 0]}]},

	% Phantom Fissure

	{1060300, [{type, mission}, {file, "data/missions/phantom-fissure.c.quest.nbl"},  {start, [0, 8002, 0]}]},
	{1060301, [{type, mission}, {file, "data/missions/phantom-fissure.b.quest.nbl"},  {start, [0, 8002, 0]}]},
	{1060302, [{type, mission}, {file, "data/missions/phantom-fissure.a.quest.nbl"},  {start, [0, 8002, 0]}]},
	{1060303, [{type, mission}, {file, "data/missions/phantom-fissure.s.quest.nbl"},  {start, [0, 8002, 0]}]},

	% Planetary lobbies

	{1100000, [{type, lobby}, {file, "data/lobby/colony.quest.nbl"}]},
	{1101000, [{type, lobby}, {file, "data/lobby/parum.quest.nbl"}]},
	{1102000, [{type, lobby}, {file, "data/lobby/neudaiz.quest.nbl"}]},
	{1103000, [{type, lobby}, {file, "data/lobby/moatoob.quest.nbl"}]},

	{1104000, [{type, spaceport}, {file, "data/lobby/spaceport.quest.nbl"}]}
]).

-define(ZONES, [
	% Unsafe Passage

	{[1000000, 0], [{file, "data/missions/unsafe-passage.1.c.zone.nbl"}]},
	{[1000001, 0], [{file, "data/missions/unsafe-passage.1.b.zone.nbl"}]},
	{[1000002, 0], [{file, "data/missions/unsafe-passage.1.a.zone.nbl"}]},
	{[1000003, 0], [{file, "data/missions/unsafe-passage.1.s.zone.nbl"}]},
	{[1000004, 0], [{file, "data/missions/unsafe-passage.1.s2.zone.nbl"}]},

	{[1000010, 0], [{file, "data/missions/unsafe-passage.2.c.zone.nbl"}]},
	{[1000011, 0], [{file, "data/missions/unsafe-passage.2.b.zone.nbl"}]},
	{[1000012, 0], [{file, "data/missions/unsafe-passage.2.a.zone.nbl"}]},
	{[1000013, 0], [{file, "data/missions/unsafe-passage.2.s.zone.nbl"}]},
	{[1000014, 0], [{file, "data/missions/unsafe-passage.2.s2.zone.nbl"}]},

	{[1000020, 0], [{file, "data/missions/unsafe-passage.3.c.zone.nbl"}]},
	{[1000021, 0], [{file, "data/missions/unsafe-passage.3.b.zone.nbl"}]},
	{[1000022, 0], [{file, "data/missions/unsafe-passage.3.a.zone.nbl"}]},
	{[1000023, 0], [{file, "data/missions/unsafe-passage.3.s.zone.nbl"}]},
	{[1000024, 0], [{file, "data/missions/unsafe-passage.3.s2.zone.nbl"}]},

	% Phantom Fissure

	{[1060300, 0], [{file, "data/missions/phantom-fissure.c-0.zone.nbl"}]},
	{[1060300, 1], [{file, "data/missions/phantom-fissure.c-1.zone.nbl"}]},
	{[1060301, 0], [{file, "data/missions/phantom-fissure.b-0.zone.nbl"}]},
	{[1060301, 1], [{file, "data/missions/phantom-fissure.b-1.zone.nbl"}]},
	{[1060302, 0], [{file, "data/missions/phantom-fissure.a-0.zone.nbl"}]},
	{[1060302, 1], [{file, "data/missions/phantom-fissure.a-1.zone.nbl"}]},
	{[1060303, 0], [{file, "data/missions/phantom-fissure.s-0.zone.nbl"}]},
	{[1060303, 1], [{file, "data/missions/phantom-fissure.s-1.zone.nbl"}]},

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

	{[1104000, 0], [{file, "data/lobby/spaceport.zone.nbl"}]}
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

%% EGS counters settings.
%% Various appearance configuration counters don't have any quest-related data. They use the CounterID 65535.
%% Background values include: 01 parum, 02 moatoob, 03 neudaiz, 04 guardians hq, 05 parum guardians, 06 moatoob guardians, 07 neudaiz guardians, 08 pitch black, ff destroyed colony

-define(COUNTERS, [
	% Linear Line: Phantom Ruins, Unsafe Passage, Unsafe Passage (AOTI, missing)

	{  0, [{quests, "data/counters/colony.ll.pack"}, {bg, 255}, {options, << 16#01a92800:32, 3, 3, 0,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, 3, 3, % Unsafe Passage C-S2 variant 1
		3, 3, 3, 3, 3, % Unsafe Passage C-S2 variant 2
		3, 3, 3, 3, 3, % Unsafe Passage C-S2 variant 3
	0:136 >>}]},

	% Space docks: Phantom Ruins, Dark Satellite, Familiar Trees (missing), Boss quest category (missing), Unit category (missing), Enemy category (missing)

	{  1, [{quests, "data/counters/colony.docks.pack"}, {bg, 255}, {options, << 16#01805400:32, 3, 3, 0, 0, 0, 0,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, 3, % Dark Satellite C-S variant 1
		3, 3, 3, 3, % Dark Satellite C-S variant 2
		3, 3, 3, 3, % Dark Satellite C-S variant 3
		3, 3, 3, % Dark Satellite S2 variant 1-3
		3, 3, 3, % Dark Satellite S3 variant 1-3
	0:440 >>}]},

	% Parum East: Illusionary Shaft, Mad Creatures, Fire purification (missing), Scarred Planet (missing), Scarred Planet

	{  2, [{quests, "data/counters/parum.east.pack"}, {bg, 1}, {options, << 16#01003c00:32, 3, 3, 0, 0, 3,
		3, 3, 3, 3, 0, % Illusionary Shaft C-S
		3, 3, 3, 3, % Mad Creatures C-S variant 1
		3, 3, 3, 3, % Mad Creatures C-S variant 2
		3, 3, 3, 3, % Mad Creatures C-S variant 3
		3, 3, 3, % Mad Creatures S2 variant 1-3
		0:144,
		3, 3, 3, 3, 3, % Scarred Planet C-S2 variant 1
		3, 3, 3, 3, 3, % Scarred Planet C-S2 variant 2
		3, 3, 3, 3, 3, % Scarred Planet C-S2 variant 3
	0:16 >>}]},

	% Parum Linear Line: Train Rescue, Fire purification (missing)

	{  3, [{quests, "data/counters/parum.ll.pack"}, {bg, 1}, {options, << 16#01781800:32, 3, 0, 0,
		3, 3, 3, 3, % Train Rescue C-S variant 1
		3, 3, 3, 3, % Train Rescue C-S variant 2
		3, 3, 3, 3, % Train Rescue C-S variant 3
		3, 3, 3, % Train Rescue S2 variant 1-3
	0:48 >>}]},

	% Neudaiz Flyerbase: Phantom Fissure, Mizuraki Defense, Forested Islands, (empty name, missing), Fire purification (missing)

	{  4, [{quests, "data/counters/neudaiz.flyer.pack"}, {bg, 3}, {options, << 16#01f04000:32, 3, 3, 3, 0, 0,
		3, 3, 3, 3, 0, % Phantom Fissure C-S
		3, 3, 3, 3, 3, 0, % Mizuraki Defense C-S2 variant 1
		3, 3, 3, 3, 3, 0, % Mizuraki Defense C-S2 variant 2
		3, 3, 3, 3, 3, 0, % Mizuraki Defense C-S2 variant 3
		3, 3, 3, 3, 3, % Forested Islands C-S2 variant 1
		3, 3, 3, 3, 3, % Forested Islands C-S2 variant 2
		3, 3, 3, 3, 3, % Forested Islands C-S2 variant 3
	0:168 >>}]},

	% Moatoob Flyerbase: Forest of Illusion, System Defense, Valley of Carnage, System Defense (missing), Fire purification (missing)

	{  5, [{quests, "data/counters/moatoob.flyer.pack"}, {bg, 2}, {options, << 16#01ab3c00:32, 3, 3, 3, 0, 0,
		3, 3, 3, 3, 0, % Forest of Illusion C-S
		3, 3, 3, 3, % System Defense C-S variant 1
		3, 3, 3, 3, % System Defense C-S variant 2
		3, 3, 3, 3, % System Defense C-S variant 3
		3, 3, 3, % System Defense S2 variant 1-3
		3, 3, 3, 3, % Valley of Carnage C-S variant 1
		3, 3, 3, 3, % Valley of Carnage C-S variant 2
		3, 3, 3, 3, % Valley of Carnage C-S variant 3
		3, 3, 3, % Valley of Carnage S2 variant 1-3
	0:160 >>}]},

	% Neudaiz COG: Phantom Fissure, Sacred Stream

	{  6, [{quests, "data/counters/neudaiz.cog.pack"}, {bg, 3}, {options, << 16#01001800:32, 3, 3,
		3, 3, 3, 3, % Phantom Fissure C-S
		3, 3, 3, 3, 3, % Sacred Stream C-S2 variant 1
		3, 3, 3, 3, 3, % Sacred Stream C-S2 variant 2
		3, 3, 3, 3, 3, % Sacred Stream C-S2 variant 3
	0:24 >>}]},

	% AMF Headquarters: AMF HQ Recovery

	{  7, [{quests, "data/counters/parum.amf.pack"}, {bg, 1}, {options, << 16#019e1000:32, 3,
		3, 3, 3, 3, 0, % AMF HQ Recovery C-S variant 1
		3, 3, 3, 3, 0, % AMF HQ Recovery C-S variant 2
		3, 3, 3, 3, 0 % AMF HQ Recovery C-S variant 3
	>>}]},

	% GRM: Side story C rank, Side story B rank, Side story A rank

	{  8, [{quests, "data/counters/parum.grm.pack"}, {bg, 5}, {options, << 16#01000c00:32, 3, 3, 3, 0, 3, 0, 3, 0, 3, 0:24 >>}]},

	% Transfer Terminal (entry 0)

	{ 10, [{quests, "data/counters/colony.terminal-0.pack"}, {bg, 255}, {options, << 16#01d10400:32, 0:32 >>}]},

	% Transfer Terminal (entry 1): Phantom Ruins, Fight for Food, Fight for Food (AOTI, missing)

	{ 11, [{quests, "data/counters/colony.terminal-1.pack"}, {bg, 255}, {options, << 16#01fc2800:32, 3, 3, 0,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, % Fight for Food C-A variant 1
		3, 3, 3, % Fight for Food C-A variant 2
		3, 3, 3, % Fight for Food C-A variant 3
		3, 3, 3, % Fight for Food S variant 1-3
		3, 3, 3, % Fight for Food S2 variant 1-3
	0:136 >>}]},

	% Aurorey

	{ 15, [{quests, "data/counters/colony.aurorey.pack"}, {bg, 255}, {options, << 16#01010400:32, 0:32 >>}]},

	% HIVE (entry 0)

	{ 20, [{quests, "data/counters/colony.hive-0.pack"}, {bg, 255}, {options, << 16#01050400:32, 0:32 >>}]},

	% HIVE (entry 1): Phantom Ruins, SEED Awakened

	{ 21, [{quests, "data/counters/colony.hive-1.pack"}, {bg, 255}, {options, << 16#017e1c00:32, 3, 3,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, 3, % SEED Awakened C-S variant 1
		3, 3, 3, 3, % SEED Awakened C-S variant 2
		3, 3, 3, 3, % SEED Awakened C-S variant 3
		3, 3, 3, % SEED Awakened S2 variant 1-3
		3, 3, 3, % SEED Awakened S3 variant 1-3
	0:24 >>}]},

	% Dallgun: Phantom Ruins, The Black Nest, True Darkness, (empty name, missing)

	{ 25, [{quests, "data/counters/colony.dallgun.pack"}, {bg, 255}, {options, << 16#01003c00:32, 3, 3, 3, 0,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, 3, 3, 0, % The Black Nest C-S2 variant 1
		3, 3, 3, 3, 3, 0, % The Black Nest C-S2 variant 2
		3, 3, 3, 3, 3, 0, % The Black Nest C-S2 variant 3
		3, 3, 3, 3, 3, % True Darkness C-S2 variant 1
		3, 3, 3, 3, 3, % True Darkness C-S2 variant 2
		3, 3, 3, 3, 3, % True Darkness C-S2 variant 3
	0:144 >>}]},

	% Raffon Fieldbase (entry 0)

	{ 30, [{quests, "data/counters/parum.raffon-0.pack"}, {bg, 1}, {options, << 16#01000400:32, 0:32 >>}]},

	% Raffon Fieldbase (entry 1): Illusionary Shaft, Plains Overlord, Sleeping Warriors, Fire purification (missing)

	{ 31, [{quests, "data/counters/parum.raffon-1.pack"}, {bg, 1}, {options, << 16#01c52c00:32, 3, 3, 3, 0,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 3, % Plains Overlord C-S2 variant 1
		3, 3, 3, 3, 3, % Plains Overlord C-S2 variant 2
		3, 3, 3, 3, 3, % Plains Overlord C-S2 variant 3
		3, 3, 3, 3, 3, % Sleeping Warriors C-S2 variant 1
		3, 3, 3, 3, 3, % Sleeping Warriors C-S2 variant 2
		3, 3, 3, 3, 3, % Sleeping Warriors C-S2 variant 3
	0:48 >>}]},

	% Parum Lakeshore (entry 0): Illusionary Shaft, Crimson Beast

	{ 35, [{quests, "data/counters/parum.lake-0.pack"}, {bg, 1}, {options, << 16#01d61800:32, 3, 3,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 3, % Crimson Beast C-S2 variant 1
		3, 3, 3, 3, 3, % Crimson Beast C-S2 variant 2
		3, 3, 3, 3, 3, % Crimson Beast C-S2 variant 3
	0:24 >>}]},

	% Parum Lakeshore (entry 1): The Mad Beasts

	{ 36, [{quests, "data/counters/parum.lake-1.pack"}, {bg, 1}, {options, << 16#01e91000:32, 3,
		3, 3, 3, % The Mad Beasts C-A variant 1
		3, 3, 3, % The Mad Beasts C-A variant 2
		3, 3, 3, % The Mad Beasts C-A variant 3
		3, 3, 3, % The Mad Beasts S variant 1-3
		3, 3, 3 % The Mad Beasts S2 variant 1-3
	>>}]},

	% Parum Underground (entry 0)

	{ 40, [{quests, "data/counters/parum.under-0.pack"}, {bg, 1}, {options, << 16#01050400:32, 0:32 >>}]},

	% Parum Underground (entry 1): Lab Recovery

	{ 41, [{quests, "data/counters/parum.under-1.pack"}, {bg, 1}, {options, << 16#01cf1000:32, 3,
		3, 3, 3, % Lab Recovery C-A variant 1
		3, 3, 3, % Lab Recovery C-A variant 2
		3, 3, 3, % Lab Recovery C-A variant 3
		3, 3, 3, % Lab Recovery S variant 1-3
		3, 3, 3 % Lab Recovery S2 variant 1-3
	>>}]},

	% Parum Underground (entry 2): Illusionary Shaft, Endrum Remnants, Fire purification (missing)

	{ 42, [{quests, "data/counters/parum.under-2.pack"}, {bg, 1}, {options, << 16#01381c00:32, 3, 3, 0,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, % Endrum Remnants C-A variant 1
		3, 3, 3, % Endrum Remnants C-A variant 2
		3, 3, 3, % Endrum Remnants C-A variant 3
		3, 3, 3, % Endrum Remnants S variant 1-3
		3, 3, 3, % Endrum Remnants S2 variant 1-3
	0:48 >>}]},

	% Parum Denes (entry 0)

	{ 45, [{quests, "data/counters/parum.denes-0.pack"}, {bg, 1}, {options, << 16#01000400:32, 0:32 >>}]},

	% Parum Denes (entry 1): Illusionary Shaft, The Dual Sentinel

	{ 46, [{quests, "data/counters/parum.denes-1.pack"}, {bg, 1}, {options, << 16#013e1800:32, 3, 3,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, % The Dual Sentinel C-S variant 1
		3, 3, 3, 3, % The Dual Sentinel C-S variant 2
		3, 3, 3, 3, % The Dual Sentinel C-S variant 3
		3, 3, 3, % The Dual Sentinel S2 variant 1-3
	0:24 >>}]},

	% Parum Waterfall: Illusionary Shaft, (empty name, Duel in the Ruins)

	{ 48, [{quests, "data/counters/parum.waterfall.pack"}, {bg, 1}, {options, << 16#01eb1800:32, 3, 3,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 3, % Duel in the Ruins C-S2 variant 1
		3, 3, 3, 3, 3, % Duel in the Ruins C-S2 variant 2
		3, 3, 3, 3, 3, % Duel in the Ruins C-S2 variant 3
	0:24 >>}]},

	% Neudaiz Islands (entry 0)

	{ 50, [{quests, "data/counters/neudaiz.islands-0.pack"}, {bg, 3}, {options, << 16#01000400:32, 0:32 >>}]},

	% Neudaiz Islands (entry 1): Rainbow Beast, (empty name, missing), Grove of Fanatics, (empty name, missing)

	{ 51, [{quests, "data/counters/neudaiz.islands-1.pack"}, {bg, 3}, {options, << 16#01424400:32, 3, 0, 3, 0,
		3, 3, 3, 3, 3, 3, % Rainbow Beast C-S3 variant 1
		3, 3, 3, 3, 3, 3, % Rainbow Beast C-S3 variant 2
		3, 3, 3, 3, 3, 3, % Rainbow Beast C-S3 variant 3
		0:120,
		3, 3, 3, 3, 3, % Grove of Fanatics C-S2 variant 1
		3, 3, 3, 3, 3, % Grove of Fanatics C-S2 variant 2
		3, 3, 3, 3, 3, % Grove of Fanatics C-S2 variant 3
	0:128 >>}]},

	% Neudaiz Islands (entry 2): Phantom Ruins, Hill of Spores

	{ 52, [{quests, "data/counters/neudaiz.islands-2.pack"}, {bg, 3}, {options, << 16#01001800:32, 3, 3,
		3, 3, 3, 3, % Phantom Ruins C-S
		3, 3, 3, 3, 3, % Hill of Spores C-S2 variant 1
		3, 3, 3, 3, 3, % Hill of Spores C-S2 variant 3
		3, 3, 3, 3, 3, % Hill of Spores C-S2 variant 3
	0:24 >>}]},

	% Neudaiz Relics (entry 0): Phantom Fissure, The Eastern Peril, Forest Infiltration

	{ 55, [{quests, "data/counters/neudaiz.relics-0.pack"}, {bg, 3}, {options, << 16#01c32c00:32, 3, 3, 3,
		3, 3, 3, 3, % Phantom Ruins C-S
		3, 3, 3, 3, 3, 3, % The Eastern Peril C-S3 variant 1
		3, 3, 3, 3, 3, 3, % The Eastern Peril C-S3 variant 2
		3, 3, 3, 3, 3, 3, % The Eastern Peril C-S3 variant 3
		3, 3, 3, 3, 3, 3, % Forest Infiltration C-S3 variant 1
		3, 3, 3, 3, 3, 3, % Forest Infiltration C-S3 variant 2
		3, 3, 3, 3, 3, 3, % Forest Infiltration C-S3 variant 3
	0 >>}]},

	% Neudaiz Relics (entry 1): The Holy Ground, Fire purification

	{ 56, [{quests, "data/counters/neudaiz.relics-1.pack"}, {bg, 3}, {options, << 16#01741400:32, 3, 0,
		3, 3, 3, % The Holy Ground C-A variant 1
		3, 3, 3, % The Holy Ground C-A variant 2
		3, 3, 3, % The Holy Ground C-A variant 3
		3, 3, 3, % The Holy Ground S variant 1-3
		3, 3, 3, % The Holy Ground S2 variant 1-3
	0:24 >>}]},

	% Neudaiz Mizuraki (entry 0)

	{ 70, [{quests, "data/counters/neudaiz.mizuraki-0.pack"}, {bg, 3}, {options, << 16#010c0400:32, 0:32 >>}]},

	% Neudaiz Mizuraki (entry 1): Demons Above

	{ 71, [{quests, "data/counters/neudaiz.mizuraki-1.pack"}, {bg, 3}, {options, << 16#01c21400:32, 3,
		3, 3, 3, % Demons Above C-A variant 1
		3, 3, 3, % Demons Above C-A variant 2
		3, 3, 3, % Demons Above C-A variant 3
		3, 3, 3, % Demons Above S variant 1-3
		3, 3, 3, % Demons Above S2 variant 1-3
	0:32 >>}]},

	% Neudaiz Mizuraki (entry 2): Phantom Fissure, Moonlight Beast, Moonlight Beast (AOTI, missing)

	{ 72, [{quests, "data/counters/neudaiz.mizuraki-2.pack"}, {bg, 3}, {options, << 16#01ab2c00:32, 3, 3, 0,
		3, 3, 3, 3, % Phantom Ruins C-S
		3, 3, 3, 3, % Moonlight Beast C-S variant 1
		3, 3, 3, 3, % Moonlight Beast C-S variant 2
		3, 3, 3, 3, % Moonlight Beast C-S variant 3
		3, 3, 3, % Moonlight Beast S2 variant 1-3
		3, 3, 3, % Moonlight Beast S3 variant 1-3
	0:152 >>}]},

	% Neudaiz Hot Springs: Phantom Fissure, Sakura Blast, Cost of Research

	{ 75, [{quests, "data/counters/neudaiz.hotsprings.pack"}, {bg, 3}, {options, << 16#01ee2800:32, 3, 3, 3,
		3, 3, 3, 3, % Phantom Ruins C-S
		3, 3, 3, 3, 3, 0, % Sakura Blast C-S2 variant 1
		3, 3, 3, 3, 3, 0, % Sakura Blast C-S2 variant 2
		3, 3, 3, 3, 3, 0, % Sakura Blast C-S2 variant 3
		3, 3, 3, 3, 3, % Cost of Research C-S2 variant 1
		3, 3, 3, 3, 3, % Cost of Research C-S2 variant 2
		3, 3, 3, 3, 3 % Cost of Research C-S2 variant 3
	>>}]},

	% Moatoob Desert (entry 0)

	{ 85, [{quests, "data/counters/moatoob.desert-0.pack"}, {bg, 2}, {options, << 16#01d30400:32, 0:32 >>}]},

	% Moatoob Desert (entry 1): Forest of Illusion, Desert Terror, Citadel of Sand, (empty name, missing)

	{ 86, [{quests, "data/counters/moatoob.desert-1.pack"}, {bg, 2}, {options, << 16#01553c00:32, 3, 3, 3, 0,
		3, 3, 3, 3, 0, % Forest of Illusion C-S
		3, 3, 3, % Desert Terror C-A variant 1
		3, 3, 3, % Desert Terror C-A variant 2
		3, 3, 3, % Desert Terror C-A variant 3
		3, 3, 3, % Desert Terror S variant 1-3
		3, 3, 3, % Desert Terror S2 variant 1-3
		3, 3, 3, % Desert Terror S3 variant 1-3
		3, 3, 3, 3, 3, % Citadel of Sand C-S2 variant 1
		3, 3, 3, 3, 3, % Citadel of Sand C-S2 variant 2
		3, 3, 3, 3, 3, % Citadel of Sand C-S2 variant 3
	0:144 >>}]},

	% Moatoob Basin (entry 0)

	{ 90, [{quests, "data/counters/moatoob.basin-0.pack"}, {bg, 2}, {options, << 16#01000400:32, 0:32 >>}]},

	% Moatoob Basin (entry 1): Forest of Illusion, Mine Defense

	{ 91, [{quests, "data/counters/moatoob.basin-1.pack"}, {bg, 2}, {options, << 16#01f01800:32, 3, 3,
		3, 3, 3, 3, 0, % Forest of Illusion C-S
		3, 3, 3, % Mine Defense C-A variant 1
		3, 3, 3, % Mine Defense C-A variant 2
		3, 3, 3, % Mine Defense C-A variant 3
		3, 3, 3, % Mine Defense S variant 1-3
		3, 3, 3, % Mine Defense S2 variant 1-3
	0:16 >>}]},

	% Moatoob Underground Lake (entry 0): Rogues' Shortcut

	{100, [{quests, "data/counters/moatoob.lake-0.pack"}, {bg, 2}, {options, << 16#01cf1400:32, 3,
		3, 3, 3, 3, 3, % Rogues' Shortcut C-S2 variant 1
		3, 3, 3, 3, 3, % Rogues' Shortcut C-S2 variant 2
		3, 3, 3, 3, 3, % Rogues' Shortcut C-S2 variant 3
		3, 3, 3, % Rogues' Shortcut S3 variant 1-3
	0 >>}]},

	% Moatoob Underground Lake (entry 1)

	{101, [{quests, "data/counters/moatoob.lake-1.pack"}, {bg, 2}, {options, << 16#01000400:32, 0:32 >>}]},

	% Moatoob Underground Lake (entry 2): Forest of Illusion, Tunnel Recapture, Desert Goliath, Lonely Laboratory, (empty name, missing)

	{102, [{quests, "data/counters/moatoob.lake-2.pack"}, {bg, 2}, {options, << 16#01004c00:32, 3, 3, 3, 3, 0,
		3, 3, 3, 3, 0, % Forest of Illusion C-S
		3, 3, 3, 3, % Tunnel Recapture C-S variant 1
		3, 3, 3, 3, % Tunnel Recapture C-S variant 2
		3, 3, 3, 3, % Tunnel Recapture C-S variant 3
		3, 3, 3, % Tunnel Recapture S2 variant 1-3
		3, 3, 3, 3, % Desert Goliath C-S variant 1
		3, 3, 3, 3, % Desert Goliath C-S variant 2
		3, 3, 3, 3, % Desert Goliath C-S variant 3
		3, 3, 3, % Desert Goliath S2 variant 1-3
		3, 3, 3, % Desert Goliath S3 variant 1-3
		3, 3, 3, 3, % Lonely Laboratory C-S variant 1
		0:48,
		3, 3, 3, 3, % Lonely Laboratory C-S variant 2
	0:152 >>}]},

	% Moatoob Oasis: Forest of Illusion, The Stolen Weapon

	{105, [{quests, "data/counters/moatoob.oasis.pack"}, {bg, 2}, {options, << 16#01ae1c00:32, 3, 3,
		3, 3, 3, 3, 0, % Forest of Illusion C-S
		3, 3, 3, 3, 3, % The Stolen Weapon C-S2 variant 1
		3, 3, 3, 3, 3, % The Stolen Weapon C-S2 variant 2
		3, 3, 3, 3, 3, % The Stolen Weapon C-S2 variant 3
		3, 3, 3, % The Stolen Weapon S3 variant 1-3
	0:24 >>}]},

	% Moatoob Glacier (entry 0)

	{108, [{quests, "data/counters/moatoob.glacier-0.pack"}, {bg, 2}, {options, << 16#01000400:32, 0:32 >>}]},

	% Moatoob Glacier (entry 1): Forest of Illusion, Caves of Ice

	{109, [{quests, "data/counters/moatoob.glacier-1.pack"}, {bg, 2}, {options, << 16#01001800:32, 3, 3,
		3, 3, 3, 3, 0, % Forest of Illusion C-S
		3, 3, 3, 3, 3, % Caves of Ice C-S2 variant 1
		3, 3, 3, 3, 3, % Caves of Ice C-S2 variant 2
		3, 3, 3, 3, 3, % Caves of Ice C-S2 variant 3
	0:16 >>}]},

	% Parum Cafe: The Collector

	{112, [{quests, "data/counters/parum.cafe.pack"}, {bg, 5}, {options, << 16#01000800:32, 3, 0:24, 3, 0:24 >>}]},

	% Moatoob Pub: Desert Arms Shop

	{114, [{quests, "data/counters/moatoob.pub.pack"}, {bg, 6}, {options, << 16#01000800:32, 3, 0:32, 3, 0:16 >>}]},

	% GUARDIANS HQ: Episode 2 C rank, B rank, A rank, Episode 3 C rank, B rank, A rank, Winter event 1 (missing), Winter event 2 (missing)
	% MAG event (missing), Side story C rank, Side story B rank, Side story A rank, Old event missions

	{115, [{quests, "data/counters/colony.guardians.pack"}, {bg, 4}, {options, << 16#01807800:32, 3, 3, 3, 3, 3, 3, 0, 0, 0, 3, 3, 3, 3,
		3, 3, 3, 3, 3, 3, 3, 3, 3, 3, % Episode 2 Difficulty C Chapters 1-10
		3, 3, 3, 3, 3, 3, 3, 3, 3, 3, % Episode 2 Difficulty B Chapters 1-10
		3, 3, 3, 3, 3, 3, 3, 3, 3, 3, % Episode 2 Difficulty A Chapters 1-10
		3, 3, 3, 3, 3, 3, 3, 3, % Episode 3 Difficulty C Chapters 1-8
		3, 3, 3, 3, 3, 3, 3, 3, % Episode 3 Difficulty B Chapters 1-8
		3, 3, 3, 3, 3, 3, 3, 3, % Episode 3 Difficulty A Chapters 1-8
		0:248,
		3, 3, 3, % Side-story C-A
		3, 3, 3, 3, 3, % MAG' C-S2
		3, % Gifts from Beyond+
		0:40,
		3, % Hit the Counter! (MAG)
		3, % Dark Crystal Seeker
		3, % Hit the Counter! (Shred the Darkness)
		3, % Photon Eraser Return
	0:32 >>}]},

	% Parum GUARDIANS: Partner Missions, Protectors a+ (missing), Protectors b+ (missing), Training Intro (missing), Party Missions, Versus, Item Exchange, (empty name, missing), (empty name, missing), (empty name, missing)

	{116, [{quests, "data/counters/parum.guardians.pack"}, {bg, 5}, {options, << 16#01005000:32, 3, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0,
		3, 3, 3, 3,
		0:304,
		3, % Standby (Party)
		3, 3, 3, 3, 3, % Eggs Thieves C-S2 variant 1
		3, 3, 3, 3, 3, % Eggs Thieves C-S2 variant 2
		3, 3, 3, 3, 3, % Eggs Thieves C-S2 variant 3
		3, % Standby (Versus)
		3, % Explosive Arena
		0, 3, % Bullet License
	0:56 >>}]},

	% Neudaiz GUARDIANS: Partner Missions, Party Missions, Item Exchange

	{117, [{quests, "data/counters/neudaiz.guardians.pack"}, {bg, 7}, {options, << 16#01e32000:32, 3, 3, 3,
		3, 3, 3, 3, % Temple of Traps
		0:32,
		3, % Standby (Party)
		3, 3, 3, 3, 3, % Her Secret Mission C-S2 variant 1
		3, 3, 3, 3, 3, % Her Secret Mission C-S2 variant 2
		3, 3, 3, 3, 3, % Her Secret Mission C-S2 variant 3
		0, 3, % TECHNIC License
	0:24 >>}]},

	% Moatoob GUARDIANS: Party Missions, Versus, Item Exchange

	{118, [{quests, "data/counters/moatoob.guardians.pack"}, {bg, 6}, {options, << 16#01001000:32, 3, 3, 3,
		3, % Standby (Party)
		3, 3, 3, 3, 3, % Bruce's Dungeon C-S2
		3, % Standby (Versus)
		3, % Airboard Rally
		0:16,
		3, % Skill License
		0, 3 % Thunderfeast Deals
	>>}]},

	% Colony R&D: Clothes'n'Parts male/female

	{177, [{quests, "data/counters/colony.rd.pack"}, {bg, 4}, {options, << 16#01000800:32, 3, 0:24, 3, 3, 0:16 >>}]},

	% Rykros (entry 0)

	{200, [{quests, "data/counters/colony.rykros-0.pack"}, {bg, 255}, {options, << 16#01000400:32, 0:32 >>}]},

	% Rykros (entry 1): Phantom Ruins, The Dark God

	{201, [{quests, "data/counters/colony.rykros-1.pack"}, {bg, 255}, {options, << 16#01d11c00:32, 3, 3,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, 3, 3, 0, % The Dark God C-S2 variant 1
		3, 3, 3, 3, 3, 0, % The Dark God C-S2 variant 2
		3, 3, 3, 3, 3, 0, % The Dark God C-S2 variant 3
	0:24 >>}]},

	% Falz Memoria

	{203, [{quests, "data/counters/colony.memoria.pack"}, {bg, 255}, {options, << 16#01013800:32, 0:448 >>}]},

	% Parum Rozenom (entry 0)

	{205, [{quests, "data/counters/parum.rozenom-0.pack"}, {bg, 1}, {options, << 16#01fa0400:32, 0:32 >>}]},

	% Parum Rozenom (entry 1): Illusionary Shaft, Lightning Beasts, Lightning Beasts (missing)

	{206, [{quests, "data/counters/parum.rozenom-1.pack"}, {bg, 1}, {options, << 16#01f82800:32, 3, 3, 0,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 3, % Lightning Beasts C-S2 variant 1
		3, 3, 3, 3, 3, % Lightning Beasts C-S2 variant 2
		3, 3, 3, 3, 3, % Lightning Beasts C-S2 variant 3
	0:144 >>}]},

	% Parum Beach (entry 0)

	{210, [{quests, "data/counters/parum.beach-0.pack"}, {bg, 1}, {options, << 16#014a0400:32, 0:32 >>}]},

	% Parum Beach (entry 1): Illusionary Shaft, SEED Express

	{211, [{quests, "data/counters/parum.beach-1.pack"}, {bg, 1}, {options, << 16#01ac1800:32, 3, 3,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 3, % SEED Express C-S2 variant 1
		3, 3, 3, 3, 3, % SEED Express C-S2 variant 2
		3, 3, 3, 3, 3, % SEED Express C-S2 variant 3
	0:24 >>}]},

	% Parum Subway (entry 0)

	{215, [{quests, "data/counters/parum.subway-0.pack"}, {bg, 1}, {options, << 16#015c0400:32, 0:32 >>}]},

	% Parum Subway (entry 1): Illusionary Shaft, Military Subway

	{216, [{quests, "data/counters/parum.subway-1.pack"}, {bg, 1}, {options, << 16#01001800:32, 3, 3,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 0, % Military Subway C-S variant 1
		3, 3, 3, 3, 0, % Military Subway C-S variant 2
		3, 3, 3, 3, 0, % Military Subway C-S variant 3
	0:24 >>}]},

	% Parum AMF Central (entry 0): Illusionary Shaft, Electric Brain

	{220, [{quests, "data/counters/parum.amfcentral-0.pack"}, {bg, 1}, {options, << 16#01001800:32, 3, 3,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 3, % Electric Brain C-S2 variant 1
		3, 3, 3, 3, 3, % Electric Brain C-S2 variant 2
		3, 3, 3, 3, 3, % Electric Brain C-S2 variant 3
	0:24 >>}]},

	% Parum AMF Central (entry 1)

	{221, [{quests, "data/counters/parum.amfcentral-1.pack"}, {bg, 1}, {options, << 16#01000400:32, 0:32 >>}]},

	% Neudaiz Saguraki (entry 0)

	{225, [{quests, "data/counters/neudaiz.saguraki-0.pack"}, {bg, 3}, {options, << 16#01ff0400:32, 0:32 >>}]},

	% Neudaiz Saguraki (entry 1)

	{226, [{quests, "data/counters/neudaiz.saguraki-1.pack"}, {bg, 3}, {options, << 16#01120400:32, 0:32 >>}]},

	% Neudaiz Saguraki (entry 2): Phantom Fissure, Flowery Pursuit

	{227, [{quests, "data/counters/neudaiz.saguraki-2.pack"}, {bg, 3}, {options, << 16#01741800:32, 3, 3,
		3, 3, 3, 3, % Phantom Fissure C-S
		3, 3, 3, 3, 3, 0, % Flowery Pursuit C-S2 variant 1
		3, 3, 3, 3, 3, 0, % Flowery Pursuit C-S2 variant 2
		3, 3, 3, 3, 3, 0 % Flowery Pursuit C-S2 variant 3
	>>}]},

	% Neudaiz Pavilion (entry 0)

	{230, [{quests, "data/counters/neudaiz.pavilion-0.pack"}, {bg, 3}, {options, << 16#01060400:32, 0:32 >>}]},

	% Neudaiz Pavilion (entry 1)

	{231, [{quests, "data/counters/neudaiz.pavilion-1.pack"}, {bg, 3}, {options, << 16#01000400:32, 0:32 >>}]},

	% Neudaiz Pavilion (entry 2): Phantom Fissure, White Beast

	{232, [{quests, "data/counters/neudaiz.pavilion-2.pack"}, {bg, 3}, {options, << 16#01021800:32, 3, 3,
		3, 3, 3, 3, % Phantom Fissure C-S
		3, 3, 3, 3, 3, % White Beast C-S2 variant 1
		3, 3, 3, 3, 3, % White Beast C-S2 variant 2
		3, 3, 3, 3, 3, % White Beast C-S2 variant 3
	0:24 >>}]},

	% Neudaiz Habirao (entry 0)

	{235, [{quests, "data/counters/neudaiz.habirao-0.pack"}, {bg, 3}, {options, << 16#01000400:32, 0:32 >>}]},

	% Neudaiz Habirao (entry 1): Phantom Fissure, The Dancing Birds

	{236, [{quests, "data/counters/neudaiz.habirao-1.pack"}, {bg, 3}, {options, << 16#01031800:32, 3, 3,
		3, 3, 3, 3, % Phantom Fissure C-S
		3, 3, 3, 3, 3, % The Dancing Birds C-S2 variant 1
		3, 3, 3, 3, 3, % The Dancing Birds C-S2 variant 2
		3, 3, 3, 3, 3, % The Dancing Birds C-S2 variant 3
	0:24 >>}]},

	% Neudaiz Temple

	{240, [{quests, "data/counters/neudaiz.temple.pack"}, {bg, 3}, {options, << 16#01ff0400:32, 0:32 >>}]},

	% Moatoob Granigs (entry 0)

	{245, [{quests, "data/counters/moatoob.granigs-0.pack"}, {bg, 2}, {options, << 16#01020400:32, 0:32 >>}]},

	% Moatoob Granigs (entry 1)

	{246, [{quests, "data/counters/moatoob.granigs-1.pack"}, {bg, 2}, {options, << 16#01000400:32, 0:32 >>}]},

	% Moatoob Granigs (entry 2): Forest of Illusion, Awoken Serpent

	{247, [{quests, "data/counters/moatoob.granigs-2.pack"}, {bg, 2}, {options, << 16#01001800:32, 3, 3,
		3, 3, 3, 3, 0, % Forest of Illusion C-S
		3, 3, 3, 3, 3, % Awoken Serpent C-S2 variant 1
		3, 3, 3, 3, 3, % Awoken Serpent C-S2 variant 2
		3, 3, 3, 3, 3, % Awoken Serpent C-S2 variant 3
	0:16 >>}]},

	% Moatoob Il Cabo (entry 0)

	{250, [{quests, "data/counters/moatoob.ilcabo-0.pack"}, {bg, 2}, {options, << 16#01000400:32, 0:32 >>}]},

	% Moatoob Il Cabo (entry 1): Forest of Illusion, (empty name, Bladed Legacy)

	{251, [{quests, "data/counters/moatoob.ilcabo-1.pack"}, {bg, 2}, {options, << 16#012f1800:32, 3, 3,
		3, 3, 3, 3, 0, % Forest of Illusion C-S
		3, 3, 3, 3, 3, % Bladed Legacy C-S2 variant 1
		3, 3, 3, 3, 3, % Bladed Legacy C-S2 variant 2
		3, 3, 3, 3, 3, % Bladed Legacy C-S2 variant 3
	0:16 >>}]},

	% Moatoob Casino

	{255, [{quests, "data/counters/moatoob.casino.pack"}, {bg, 2}, {options, << 16#01000400:32, 0:32 >>}]}
]).
