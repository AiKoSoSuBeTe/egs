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
	% Current test mission

	{1000013, [{type, mission},   {file, "data/missions/test.quest.nbl"}]},

	% Planetary lobbies

	{1100000, [{type, lobby},     {file, "data/lobby/colony.quest.nbl"}]},
	{1101000, [{type, lobby},     {file, "data/lobby/parum.quest.nbl"}]},
	{1102000, [{type, lobby},     {file, "data/lobby/neudaiz.quest.nbl"}]},
	{1103000, [{type, lobby},     {file, "data/lobby/moatoob.quest.nbl"}]},
	{1104000, [{type, spaceport}, {file, "data/lobby/spaceport.quest.nbl"}]}
]).

-define(ZONES, [
	% Current test mission

	{[1000013, 0], [{file, "data/missions/test.zone.nbl"}]},

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

	{  0, [{quests, "data/missions/colony.counter.ll.pack"}, {bg, 255}, {options, << 16#01a92800:32, 3, 3, 0,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, 3, 3, % Unsafe Passage C-S2 variant 1
		3, 3, 3, 3, 3, % Unsafe Passage C-S2 variant 2
		3, 3, 3, 3, 3, % Unsafe Passage C-S2 variant 3
	0:136 >>}]},

	% Space docks: Phantom Ruins, Dark Satellite, Familiar Trees (missing), Boss quest category (missing), Unit category (missing), Enemy category (missing)

	{  1, [{quests, "data/missions/colony.counter.docks.pack"}, {bg, 255}, {options, << 16#01805400:32, 3, 3, 0, 0, 0, 0,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, 3, % Dark Satellite C-S variant 1
		3, 3, 3, 3, % Dark Satellite C-S variant 2
		3, 3, 3, 3, % Dark Satellite C-S variant 3
		3, 3, 3, % Dark Satellite S2 variant 1-3
		3, 3, 3, % Dark Satellite S3 variant 1-3
	0:440 >>}]},

	% Parum East: Illusionary Shaft, Mad Creatures, Fire purification (missing), Scarred Planet (missing), Scarred Planet

	{  2, [{quests, "data/missions/parum.counter.east.pack"}, {bg, 1}, {options, << 16#01003c00:32, 3, 3, 0, 0, 3,
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

	{  3, [{quests, "data/missions/parum.counter.ll.pack"}, {bg, 1}, {options, << 16#01781800:32, 3, 0, 0,
		3, 3, 3, 3, % Train Rescue C-S variant 1
		3, 3, 3, 3, % Train Rescue C-S variant 2
		3, 3, 3, 3, % Train Rescue C-S variant 3
		3, 3, 3, % Train Rescue S2 variant 1-3
	0:48 >>}]},

	% AMF Headquarters: AMF HQ Recovery

	{  7, [{quests, "data/missions/parum.counter.amf.pack"}, {bg, 1}, {options, << 16#019e1000:32, 3,
		3, 3, 3, 3, 0, % AMF HQ Recovery C-S variant 1
		3, 3, 3, 3, 0, % AMF HQ Recovery C-S variant 2
		3, 3, 3, 3, 0 % AMF HQ Recovery C-S variant 3
	>>}]},

	% GRM: Side story C rank, Side story B rank, Side story A rank

	{  8, [{quests, "data/missions/parum.counter.grm.pack"}, {bg, 5}, {options, << 16#01000c00:32, 3, 3, 3, 0, 3, 0, 3, 0, 3, 0:24 >>}]},

	% Transfer Terminal (entry 0)

	{ 10, [{quests, "data/missions/colony.counter.terminal-0.pack"}, {bg, 255}, {options, << 16#01d10400:32, 0:32 >>}]},

	% Transfer Terminal (entry 1): Phantom Ruins, Fight for Food, Fight for Food (AOTI, missing)

	{ 11, [{quests, "data/missions/colony.counter.terminal-1.pack"}, {bg, 255}, {options, << 16#01fc2800:32, 3, 3, 0,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, % Fight for Food C-A variant 1
		3, 3, 3, % Fight for Food C-A variant 2
		3, 3, 3, % Fight for Food C-A variant 3
		3, 3, 3, % Fight for Food S variant 1-3
		3, 3, 3, % Fight for Food S2 variant 1-3
	0:136 >>}]},

	% Aurorey

	{ 15, [{quests, "data/missions/colony.counter.aurorey.pack"}, {bg, 255}, {options, << 16#01010400:32, 0:32 >>}]},

	% HIVE (entry 0)

	{ 20, [{quests, "data/missions/colony.counter.hive-0.pack"}, {bg, 255}, {options, << 16#01050400:32, 0:32 >>}]},

	% HIVE (entry 1): Phantom Ruins, SEED Awakened

	{ 21, [{quests, "data/missions/colony.counter.hive-1.pack"}, {bg, 255}, {options, << 16#017e1c00:32, 3, 3,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, 3, % SEED Awakened C-S variant 1
		3, 3, 3, 3, % SEED Awakened C-S variant 2
		3, 3, 3, 3, % SEED Awakened C-S variant 3
		3, 3, 3, % SEED Awakened S2 variant 1-3
		3, 3, 3, % SEED Awakened S3 variant 1-3
	0:24 >>}]},

	% Dallgun: Phantom Ruins, The Black Nest, True Darkness, (empty name, missing)

	{ 25, [{quests, "data/missions/colony.counter.dallgun.pack"}, {bg, 255}, {options, << 16#01003c00:32, 3, 3, 3, 0,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, 3, 3, 0, % The Black Nest C-S2 variant 1
		3, 3, 3, 3, 3, 0, % The Black Nest C-S2 variant 2
		3, 3, 3, 3, 3, 0, % The Black Nest C-S2 variant 3
		3, 3, 3, 3, 3, % True Darkness C-S2 variant 1
		3, 3, 3, 3, 3, % True Darkness C-S2 variant 2
		3, 3, 3, 3, 3, % True Darkness C-S2 variant 3
	0:144 >>}]},

	% Raffon Fieldbase (entry 0)

	{ 30, [{quests, "data/missions/parum.counter.raffon-0.pack"}, {bg, 1}, {options, << 16#01000400:32, 0:32 >>}]},

	% Raffon Fieldbase (entry 1): Illusionary Shaft, Plains Overlord, Sleeping Warriors, Fire purification (missing)

	{ 31, [{quests, "data/missions/parum.counter.raffon-1.pack"}, {bg, 1}, {options, << 16#01c52c00:32, 3, 3, 3, 0,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 3, % Plains Overlord C-S2 variant 1
		3, 3, 3, 3, 3, % Plains Overlord C-S2 variant 2
		3, 3, 3, 3, 3, % Plains Overlord C-S2 variant 3
		3, 3, 3, 3, 3, % Sleeping Warriors C-S2 variant 1
		3, 3, 3, 3, 3, % Sleeping Warriors C-S2 variant 2
		3, 3, 3, 3, 3, % Sleeping Warriors C-S2 variant 3
	0:48 >>}]},

	% Parum Lakeshore (entry 0): Illusionary Shaft, Crimson Beast

	{ 35, [{quests, "data/missions/parum.counter.lake-0.pack"}, {bg, 1}, {options, << 16#01d61800:32, 3, 3,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 3, % Crimson Beast C-S2 variant 1
		3, 3, 3, 3, 3, % Crimson Beast C-S2 variant 2
		3, 3, 3, 3, 3, % Crimson Beast C-S2 variant 3
	0:24 >>}]},

	% Parum Lakeshore (entry 1): The Mad Beasts

	{ 36, [{quests, "data/missions/parum.counter.lake-1.pack"}, {bg, 1}, {options, << 16#01e91000:32, 3,
		3, 3, 3, % The Mad Beasts C-A variant 1
		3, 3, 3, % The Mad Beasts C-A variant 2
		3, 3, 3, % The Mad Beasts C-A variant 3
		3, 3, 3, % The Mad Beasts S variant 1-3
		3, 3, 3 % The Mad Beasts S2 variant 1-3
	>>}]},

	% Parum Underground (entry 0)

	{ 40, [{quests, "data/missions/parum.counter.under-0.pack"}, {bg, 1}, {options, << 16#01050400:32, 0:32 >>}]},

	% Parum Underground (entry 1): Lab Recovery

	{ 41, [{quests, "data/missions/parum.counter.under-1.pack"}, {bg, 1}, {options, << 16#01cf1000:32, 3,
		3, 3, 3, % Lab Recovery C-A variant 1
		3, 3, 3, % Lab Recovery C-A variant 2
		3, 3, 3, % Lab Recovery C-A variant 3
		3, 3, 3, % Lab Recovery S variant 1-3
		3, 3, 3 % Lab Recovery S2 variant 1-3
	>>}]},

	% Parum Underground (entry 2): Illusionary Shaft, Endrum Remnants, Fire purification (missing)

	{ 42, [{quests, "data/missions/parum.counter.under-2.pack"}, {bg, 1}, {options, << 16#01381c00:32, 3, 3, 0,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, % Endrum Remnants C-A variant 1
		3, 3, 3, % Endrum Remnants C-A variant 2
		3, 3, 3, % Endrum Remnants C-A variant 3
		3, 3, 3, % Endrum Remnants S variant 1-3
		3, 3, 3, % Endrum Remnants S2 variant 1-3
	0:48 >>}]},

	% Parum Denes (entry 0)

	{ 45, [{quests, "data/missions/parum.counter.denes-0.pack"}, {bg, 1}, {options, << 16#01000400:32, 0:32 >>}]},

	% Parum Denes (entry 1): Illusionary Shaft, The Dual Sentinel

	{ 46, [{quests, "data/missions/parum.counter.denes-1.pack"}, {bg, 1}, {options, << 16#013e1800:32, 3, 3,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, % The Dual Sentinel C-S variant 1
		3, 3, 3, 3, % The Dual Sentinel C-S variant 2
		3, 3, 3, 3, % The Dual Sentinel C-S variant 3
		3, 3, 3, % The Dual Sentinel S2 variant 1-3
	0:24 >>}]},

	% Parum Waterfall: Illusionary Shaft, (empty name, Duel in the Ruins)

	{ 48, [{quests, "data/missions/parum.counter.waterfall.pack"}, {bg, 1}, {options, << 16#01eb1800:32, 3, 3,
		2, 2, 2, 2, % Illusionary Shaft C-S
		2, 2, 2, 2, 2, % Duel in the Ruins C-S2 variant 1
		2, 2, 2, 2, 2, % Duel in the Ruins C-S2 variant 2
		2, 2, 2, 2, 2, % Duel in the Ruins C-S2 variant 3
	0:24 >>}]},

	% Parum Cafe: The Collector

	{112, [{quests, "data/missions/parum.counter.cafe.pack"}, {bg, 5}, {options, << 16#01000800:32, 3, 0:24, 3, 0:24 >>}]},

	% GUARDIANS HQ: Episode 2 C rank, B rank, A rank, Episode 3 C rank, B rank, A rank, Winter event 1 (missing), Winter event 2 (missing)
	% MAG event (missing), Side story C rank, Side story B rank, Side story A rank, Old event missions

	{115, [{quests, "data/missions/colony.counter.guardians.pack"}, {bg, 4}, {options, << 16#01807800:32, 3, 3, 3, 3, 3, 3, 0, 0, 0, 3, 3, 3, 3,
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

	{116, [{quests, "data/missions/parum.counter.guardians.pack"}, {bg, 5}, {options, << 16#01005000:32, 3, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0,
		3, 3, 3, 3,
		0:32,
		2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
		3, % Standby (Party)
		3, 3, 3, 3, 3, % Eggs Thieves C-S2 variant 1
		3, 3, 3, 3, 3, % Eggs Thieves C-S2 variant 2
		3, 3, 3, 3, 3, % Eggs Thieves C-S2 variant 3
		3, % Standby (Versus)
		3, % Explosive Arena
		0, 3, % Bullet License
	0:56 >>}]},

	% Colony R&D: Clothes'n'Parts male/female

	{177, [{quests, "data/missions/colony.counter.rd.pack"}, {bg, 4}, {options, << 16#01000800:32, 3, 0:24, 3, 3, 0:16 >>}]},

	% Rykros (entry 0)

	{200, [{quests, "data/missions/colony.counter.rykros-0.pack"}, {bg, 255}, {options, << 16#01000400:32, 0:32 >>}]},

	% Rykros (entry 1): Phantom Ruins, The Dark God

	{201, [{quests, "data/missions/colony.counter.rykros-1.pack"}, {bg, 255}, {options, << 16#01d11c00:32, 3, 3,
		3, 3, 3, 3, 0, % Phantom Ruins C-S
		3, 3, 3, 3, 3, 0, % The Dark God C-S2 variant 1
		3, 3, 3, 3, 3, 0, % The Dark God C-S2 variant 2
		3, 3, 3, 3, 3, 0, % The Dark God C-S2 variant 3
	0:24 >>}]},

	% Falz Memoria

	{203, [{quests, "data/missions/colony.counter.memoria.pack"}, {bg, 255}, {options, << 16#01013800:32, 0:448 >>}]},

	% Parum Rozenom (entry 0)

	{205, [{quests, "data/missions/parum.counter.rozenom-0.pack"}, {bg, 1}, {options, << 16#01fa0400:32, 0:32 >>}]},

	% Parum Rozenom (entry 1): Illusionary Shaft, Lightning Beasts, Lightning Beasts (missing)

	{206, [{quests, "data/missions/parum.counter.rozenom-1.pack"}, {bg, 1}, {options, << 16#01f82800:32, 3, 3, 0,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 3, % Lightning Beasts C-S2 variant 1
		3, 3, 3, 3, 3, % Lightning Beasts C-S2 variant 2
		3, 3, 3, 3, 3, % Lightning Beasts C-S2 variant 3
	0:144 >>}]},

	% Parum Beach (entry 0)

	{210, [{quests, "data/missions/parum.counter.beach-0.pack"}, {bg, 1}, {options, << 16#014a0400:32, 0:32 >>}]},

	% Parum Beach (entry 1): Illusionary Shaft, SEED Express

	{211, [{quests, "data/missions/parum.counter.beach-1.pack"}, {bg, 1}, {options, << 16#01ac1800:32, 3, 3,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 3, % SEED Express C-S2 variant 1
		3, 3, 3, 3, 3, % SEED Express C-S2 variant 2
		3, 3, 3, 3, 3, % SEED Express C-S2 variant 3
	0:24 >>}]},

	% Parum Subway (entry 0)

	{215, [{quests, "data/missions/parum.counter.subway-0.pack"}, {bg, 1}, {options, << 16#015c0400:32, 0:32 >>}]},

	% Parum Subway (entry 1): Illusionary Shaft, Military Subway

	{216, [{quests, "data/missions/parum.counter.subway-1.pack"}, {bg, 1}, {options, << 16#01001800:32, 3, 3,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 0, % Military Subway C-S variant 1
		3, 3, 3, 3, 0, % Military Subway C-S variant 2
		3, 3, 3, 3, 0, % Military Subway C-S variant 3
	0:24 >>}]},

	% Parum AMF Central (entry 0): Illusionary Shaft, Electric Brain

	{220, [{quests, "data/missions/parum.counter.amfcentral-0.pack"}, {bg, 1}, {options, << 16#01001800:32, 3, 3,
		3, 3, 3, 3, % Illusionary Shaft C-S
		3, 3, 3, 3, 3, % Electric Brain C-S2 variant 1
		3, 3, 3, 3, 3, % Electric Brain C-S2 variant 2
		3, 3, 3, 3, 3, % Electric Brain C-S2 variant 3
	0:24 >>}]},

	% Parum AMF Central (entry 1)

	{221, [{quests, "data/missions/parum.counter.amfcentral-1.pack"}, {bg, 1}, {options, << 16#01000400:32, 0:32 >>}]}
]).
