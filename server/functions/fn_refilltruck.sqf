// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: fn_refilltruck.sqf
//	@file Author: AgentRev
//	@file Created: 30/06/2013 15:28

if (!isServer) exitWith {};

#define RANDOM_BETWEEN(START,END) (START + floor random ((END - START) + 1))

private ["_truck", "_truckItems", "_item", "_qty", "_mag"];
_truck = _this;

// Clear prexisting cargo first
clearMagazineCargoGlobal _truck;
clearWeaponCargoGlobal _truck;
clearItemCargoGlobal _truck;

// Item type, Item, # of items, # of magazines per weapon
_truckItems =
[
	["wep", ["Binocular", "Rangefinder"], RANDOM_BETWEEN(0,2)],
	["itm", "FirstAidKit", RANDOM_BETWEEN(3,6)],
	["itm", "Medikit", RANDOM_BETWEEN(1,3)],
	["itm", "Toolkit", RANDOM_BETWEEN(0,1)],
	["itm", ["muzzle_snds_M", "muzzle_snds_H", "muzzle_snds_H_MG", "muzzle_snds_B", "muzzle_snds_acp"], RANDOM_BETWEEN(0,3)],
	["itm", ["optic_Aco", "optic_ACO_grn", "optic_MRCO", "optic_Hamr", "optic_Arco"], RANDOM_BETWEEN(2,4)],
	["wep", ["arifle_mas_saiga", "arifle_mas_m1014"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(3,5)],
	["wep", ["arifle_mas_m4_m203_d", "arifle_mas_mk16_l_gl", "arifle_mas_hk417c_d", "arifle_mas_akms"], RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(4,5)],
	["mag", "1Rnd_HE_Grenade_shell", RANDOM_BETWEEN(5,10)],
	["wep", ["srifle_mas_sr25_h", "srifle_mas_m110_h"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(4,6)],
	["wep", ["launch_RPG32_F", "mas_launch_RPG7_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(1,2)],
	["mag", "HandGrenade", RANDOM_BETWEEN(0,5)],
	["mag", ["APERSTripMine_Wire_Mag", "APERSBoundingMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag"], RANDOM_BETWEEN(2,6)]
];

[_truck, _truckItems] call processItems;
