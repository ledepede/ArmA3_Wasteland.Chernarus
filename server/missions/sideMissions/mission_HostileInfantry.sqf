// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_HostileInfantry.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev, Zenophon
//	@file Created: 08/12/2012 15:19
//  @file Information: JoSchaap's Lite version of 'Infantry Occupy House' Original was made by: Zenophon

if (!isServer) exitwith {};

#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_townName", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly", "_tent1", "_chair1", "_chair2", "_cFire1"];

_setupVars =
{
	_missionType = "Terrorist Invasion";
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	
	// settings for this mission
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;

	//randomize amount of units
	_nbUnits = _nbUnits + round(random (_nbUnits*0.5));	
	// reduce radius for larger towns. for example to avoid endless hide and seek in kavala ;) 
	_buildingRadius = if (_buildingRadius > 201) then {(_buildingRadius*0.5)} else {_buildingRadius};	
	// 25% change on AI not going on rooftops
	if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };
	// 25% chance on AI trying to fit into a single building instead of spreading out
	if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };
};

_setupObjects =
{
	// spawn some crates in the middle of town (Town marker position)	
	_randomBox = ["mission_Mixed","mission_General","mission_UAV","mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers"] call BIS_fnc_selectRandom;
	_box1 = createVehicle ["Box_NATO_WpsSpecial_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, _randomBox] call fn_refillbox;
	
	_randomBox = ["mission_Mixed","mission_General","mission_UAV","mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers"] call BIS_fnc_selectRandom;
	_box2 = createVehicle ["Box_FIA_Support_F", _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, _randomBox] call fn_refillbox;
	
	
	// create some atmosphere around the crates 8)
	_tent1 = createVehicle ["CamoNet_INDP_open_F", _missionPos, [], 3, "None"];
	_tent1 setDir random 360;
	_tent1 allowDamage false;
	_chair1 = createVehicle ["Land_CampingChair_V1_F", _missionPos, [], 2, "None"];
	_chair1 setDir random 90;
	_chair2 = createVehicle ["Land_CampingChair_V2_F", _missionPos, [], 2, "None"];
	_chair2 setDir random 180;
	_cFire1	= createVehicle ["Campfire_burning_F", _missionPos, [], 2, "None"];
	
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];
	
	// spawn some rebels/enemies :)
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup2;
	
	// move them into buildings
	[_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;
		
	_missionHintText = format ["Hostiles have taken over <br/><t color='%1'>%2</t>!<br/><br/>There seem to be <t color='%1'>multiple enemies</t> hiding inside or on top of buildings. Get rid of them all, and take their high value supplies!.<br/>Watch out for those windows!", sideMissionColor, _townName, _nbUnits];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _tent1, _chair1, _chair2, _cFire1];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];

	_successHintMessage = format ["Nice work!<br/><br/><t color='%1'>%2</t><br/>is a safe place again!<br/>Their belongings are now yours to take!", sideMissionColor, _townName];
	{ deleteVehicle _x } forEach [_tent1, _chair1, _chair2, _cFire1];
};

_this call sideMissionProcessor;