// BLUFOR WHITELISTING FOR SWWD CLAN MEMBERS !
_BLUFOR_Whitelist = [
"76561198032560659", //c_m0nst3r
"76561198010859952", // Hagar
"76561198011008664", // Blasie
"76561198011088763", // Crusty
"76561198030714684", // Diesel
"76561198032758675", // Saadsel
"76561198048862475", // Badger
"76561198057051280", // AcidBuddy
"76561198101478573", // BAASMANS
"76561198106526709", // Frank0
"76561198117632922", // Panga
"76561198126770614", // Wolf
"76561198139502677", // SL3T
"76561198147195498", // ACHMED
"76561198147245553", // PUNISHER
"76561198022113458", // GreyTear
"76561198021080452" //Dugg
];

if(playerSide == BLUFOR) then
{
	if(!((getPlayerUID player) in _BLUFOR_Whitelist)) then
	{
		hint "BLUFOR is Whitelisted for Sierra Whiskey Wild Dogs Only!";
		titleFadeOut 9999;
		titleText [format["BLUFOR is Whitelisted for Sierra Whiskey Wild Dogs Only!"],"PLAIN",0];
		[] spawn{
			sleep 5;
			endMission "Enquire on Teamspeak! CPTTS.GAMESERVERS.COM:9194";
		}
	};
};
