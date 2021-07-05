#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_perks;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/zombies/_zm_powerups;
#include maps/mp/zm_tomb_craftables;
#include maps/mp/zm_tomb_tank;
#include maps/mp/zm_tomb_challenges;
#include maps/mp/zombies/_zm_challenges;
#include maps/mp/zm_tomb_chamber;
#include maps/mp/zombies/_zm_zonemgr;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/animscripts/zm_shared;
#include maps/mp/zombies/_zm_ai_basic;
#include maps/mp/zm_tomb_vo;
#include maps/mp/zm_tomb_teleporter;
#include maps/mp/_visionset_mgr;
#include maps/mp/zombies/_zm_equipment;
#include maps/mp/zombies/_zm_spawner;
#include maps/mp/zombies/_zm_net;
#include maps/mp/zm_tomb_capture_zones;
#include maps/mp/zm_tomb;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/zombies/_zm_challenges;
#include maps/mp/zombies/_zm_score;
#include maps/mp/zombies/_zm_devgui;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/_visionset_mgr;
#include maps/mp/zm_tomb_chamber;
#include maps/mp/zombies/_zm_zonemgr;
#include maps/mp/zm_tomb_main_quest;
#include maps/mp/zm_tomb_dig;
#include maps/mp/zm_tomb_ambient_scripts;
#include maps/mp/zm_tomb_challenges;
#include maps/mp/zombies/_zm_spawner;
#include maps/mp/zm_tomb_distance_tracking;
#include maps/mp/zm_tomb;
#include maps/mp/zombies/_zm_weap_one_inch_punch;
#include maps/mp/zombies/_zm_perk_electric_cherry;
#include maps/mp/zombies/_zm_perks;
#include maps/mp/zombies/_zm_perk_divetonuke;
#include maps/mp/zm_tomb_vo;
#include maps/mp/gametypes_zm/_spawning;
#include maps/mp/animscripts/zm_death;
#include maps/mp/zm_tomb_capture_zones;
#include maps/mp/zm_tomb_ffotd;
#include maps/mp/zm_tomb_utility;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/_utility;
#include common_scripts/utility;

init()
{
	level.clientid=0;
	level thread onplayerconnect();
	precachemodel("defaultactor");
	precachemodel("defaultvehicle");
	precachemodel("test_sphere_silver");
	PrecacheItem("zombie_knuckle_crack");
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		if(isDefined(level.player_out_of_playable_area_monitor))
                   level.player_out_of_playable_area_monitor = false;
		if(isDefined(level.player_too_many_weapons_monitor))
                   level.player_too_many_weapons_monitor = false;
		player thread MuleForAll();
		player thread onplayerspawned();
		player.clientid=level.clientid;
		level.clientid++;
		player.Verified=false;
		player.VIP=false;
		player.CoHost=false;
		player.Origins=true;
		player.MyAccess="";
		player.godenabled=false;
		player.MenuEnabled=false;
		player DefaultMenuSettings();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("spawned_player");
		if(self isHost() || self.name == "USERNAME" || self.name == "USERNAME" || self.name == "USERNAME" || self.name == "USERNAME" || self.name == "USERNAME" || self.name == "USERNAME" || self.name == "USERNAME" || self.name == "USERNAME"|| self.name == "USERNAME" || self.name == "USERNAME") //Insert usernames here
		{
			self freezecontrols(false);
			self.Verified=true;
			self.VIP=true;
			self.CoHost=true;
			self.Origins=true;
			self.MyAccess="";
			self thread BuildMenu();
			//self thread doNewsbar();
		}
		else if (self.Verified==false)
		{
			self.MyAccess="";
		}
	}
}

MuleForAll()
  {
  self endon("disconnect");
  if ( isDefined( level.zombiemode_using_additionalprimaryweapon_perk ) && level.zombiemode_using_additionalprimaryweapon_perk )
  {
  level thread mule_kick_4_weapons();
  }
  }
  mule_kick_4_weapons()
  {
  _a1697 = get_players();
  _k1697 = getFirstArrayKey( _a1697 );
  while ( isDefined( _k1697 ) )
  {
  player = _a1697[ _k1697 ];
  if ( !isDefined( player._retain_perks_array ) )
  {
  player._retain_perks_array = [];
  }
  if ( !player hasperk( "specialty_additionalprimaryweapon" ) )
  {
  player maps/mp/zombies/_zm_perks::give_perk( "specialty_additionalprimaryweapon", 0 );
  }
  player._retain_perks_array[ "specialty_additionalprimaryweapon" ] = 1;
  _k1697 = getNextArrayKey( _a1697, _k1697 );
  }
  level.additionalprimaryweapon_limit = 8;
  }

MenuStructure()
{
	if (self.Verified==true)
	{
		self MainMenu("Gr3Zz v5.0",undefined);
		self MenuOption("Gr3Zz v5.0",0,"Main Mods",::SubMenu,"Main Mods");
		self MenuOption("Gr3Zz v5.0",1,"Melee/Equipment Menu",::SubMenu,"Melee/Equipment Menu");
		self MenuOption("Gr3Zz v5.0",2,"Weapons Menu",::SubMenu,"Weapons Menu");
		self MenuOption("Gr3Zz v5.0",3,"Upgraded Weapons Menu",::SubMenu,"Upgraded Weapons Menu");
		self MenuOption("Gr3Zz v5.0",4,"Bullets Menu",::SubMenu,"Bullets Menu");
	}
	if (self.VIP==true)
	{
		self MenuOption("Gr3Zz v5.0",5,"Perks Menu",::SubMenu,"Perks Menu");
		self MenuOption("Gr3Zz v5.0",6,"Fun Menu",::SubMenu,"Fun Menu");
		self MenuOption("Gr3Zz v5.0",7,"Theme Menu",::SubMenu,"Theme Menu");
		self MenuOption("Gr3Zz v5.0",8,"Teleport Menu",::SubMenu,"Teleport Menu");
		self MenuOption("Gr3Zz v5.0",9,"Power Ups",::SubMenu,"Power Ups");
	}
	if (self.CoHostself.CoHost==true)
	{
		self MenuOption("Gr3Zz v5.0",10,"Game Settings",::SubMenu,"Game Settings");
		self MenuOption("Gr3Zz v5.0",11,"Clients Menu",::SubMenu,"Clients Menu");
		self MenuOption("Gr3Zz v5.0",12,"All Clients",::SubMenu,"All Clients");
	}
	if (self.Origins==true)
	{
	switch(GetDvar( "mapname" )){
	case "zm_tomb": // Origins
		self MenuOption("Gr3Zz v5.0",13,"Staffs Menu",::SubMenu,"Staffs Menu");
        break;
		}
	}
	self MainMenu("Main Mods","Gr3Zz v5.0");
	self MenuOption("Main Mods",0,"GodMod",::Toggle_God);
	self MenuOption("Main Mods",1,"Unlimited Ammo",::Toggle_Ammo);
	self MenuOption("Main Mods",2,"x2 Speed",::doMiniSpeed);
	self MenuOption("Main Mods",3,"Double Jump",::DoubleJump);
	self MenuOption("Main Mods",4,"Third Person",::toggle_3ard);
	self MenuOption("Main Mods",5,"Clone Yourself",::CloneMe);
	self MenuOption("Main Mods",6,"Invisible",::toggle_invs);
	self MenuOption("Main Mods",7,"Give Money",::MaxScore);
	self MenuOption("Main Mods",8,"Give All Buildables",::giveAllBuildables);
	switch(GetDvar( "mapname" )){
	case "zm_transit": // Tranzit
	self MenuOption("Main Mods",9,"No Lava Damage",::NoLavaDamage);
        break;
}
	self MainMenu("Melee/Equipment Menu","Gr3Zz v5.0");
	self MenuOption("Melee/Equipment Menu",0,"Frag Grenade",::dolethal,"frag_grenade_zm");
	self MenuOption("Melee/Equipment Menu",1,"Claymore",::doclaymore);
	switch(GetDvar( "mapname" )){
	case "zm_transit": // Tranzit
	self MenuOption("Melee/Equipment Menu",2,"Monkey Bomb",::domonkey);
	self MenuOption("Melee/Equipment Menu",3,"Semtex",::dolethal,"sticky_grenade_zm");
	self MenuOption("Melee/Equipment Menu",4,"EMP",::doemps);
	self MenuOption("Melee/Equipment Menu",5,"Galvaknuckles",::doMeleeBG,"tazer_knuckles_zm");
	self MenuOption("Melee/Equipment Menu",6,"Riot Shield",::doequipment_give,"riotshield_zm");
	self MenuOption("Melee/Equipment Menu",7,"Bowie Knife",::doMeleeBG,"bowie_knife_zm");
	self MenuOption("Melee/Equipment Menu",8,"Turbine",::doequipment_give,"equip_turbine_zm");
	self MenuOption("Melee/Equipment Menu",9,"Turrent",::doequipment_give,"equip_turret_zm");
	self MenuOption("Melee/Equipment Menu",10,"Electric Trap",::doequipment_give,"equip_electrictrap_zm");
	self MenuOption("Melee/Equipment Menu",11,"Ballistic Knife",::doWeapon2,"knife_ballistic_zm");
	self MenuOption("Melee/Equipment Menu",12,"Upgraded Ballistic Knife",::doWeapon2,"knife_ballistic_upgraded_zm");		
	self MenuOption("Melee/Equipment Menu",13,"Ballistic Bowie",::doWeapon2,"knife_ballistic_bowie_zm");
	self MenuOption("Melee/Equipment Menu",14,"Upgraded Ballistic Bowie",::doWeapon2,"knife_ballistic_bowie_upgraded_zm");
        break;
	case "zm_buried": // Buried
	self MenuOption("Melee/Equipment Menu",2,"Time Bomb",::doTime);
	self MenuOption("Melee/Equipment Menu",3,"Monkey Bomb",::domonkey);
	self MenuOption("Melee/Equipment Menu",4,"Galvaknuckles",::doMeleeBG,"tazer_knuckles_zm");
	self MenuOption("Melee/Equipment Menu",5,"Bowie Knife",::doMeleeBG,"bowie_knife_zm");
	self MenuOption("Melee/Equipment Menu",6,"Turbine",::doequipment_give,"equip_turbine_zm");
	self MenuOption("Melee/Equipment Menu",7,"Spring Pad",::doequipment_give,"equip_springpad_zm");
	self MenuOption("Melee/Equipment Menu",8,"Sub Woofer",::doequipment_give,"equip_subwoofer_zm");
	self MenuOption("Melee/Equipment Menu",9,"HeadChopper",::doequipment_give,"equip_headchopper_zm");
	self MenuOption("Melee/Equipment Menu",10,"Ballistic Knife",::doWeapon2,"knife_ballistic_zm");
	self MenuOption("Melee/Equipment Menu",11,"Upgraded Ballistic Knife",::doWeapon2,"knife_ballistic_upgraded_zm");		
	self MenuOption("Melee/Equipment Menu",12,"Ballistic Bowie",::doWeapon2,"knife_ballistic_bowie_zm");
	self MenuOption("Melee/Equipment Menu",13,"Upgraded Ballistic Bowie",::doWeapon2,"knife_ballistic_bowie_upgraded_zm");
		break;
	case "zm_tomb": // Origins
	self MenuOption("Melee/Equipment Menu",2,"Monkey Bomb",::domonkey);
	self MenuOption("Melee/Equipment Menu",3,"Air Strike",::dobeacon);
    self MenuOption("Melee/Equipment Menu",4,"Give Shovel",::Give_Shovel);
    self MenuOption("Melee/Equipment Menu",5,"Give Golden Shovel",::Give_GoldenShovel);
	self MenuOption("Melee/Equipment Menu",6,"Give Golden Helmet",::dogoldhelmet);
    self MenuOption("Melee/Equipment Menu",7,"Riot Shield",::doequipment_give,"tomb_shield_zm");
	self MenuOption("Melee/Equipment Menu",8,"One Inch Punch",::OnePunch,"one_inch_punch_zm");
    self MenuOption("Melee/Equipment Menu",9,"Air Punch",::OnePunch,"one_inch_punch_air_zm");
    self MenuOption("Melee/Equipment Menu",10,"Fire Punch",::OnePunch,"one_inch_punch_fire_zm");
	self MenuOption("Melee/Equipment Menu",11,"Ice Punch",::OnePunch,"one_inch_punch_ice_zm");
    self MenuOption("Melee/Equipment Menu",12,"Lightning Punch",::OnePunch,"one_inch_punch_lightning_zm");
        break;
	case "zm_prison": // MOTD
	self MenuOption("Melee/Equipment Menu",2,"Tomahawk",::Toma,"bouncing_tomahawk_zm");
	self MenuOption("Melee/Equipment Menu",3,"Upgraded Tomahawk",::Toma,"upgraded_tomahawk_zm");	
	self MenuOption("Melee/Equipment Menu",4,"Riot Shield",::doequipment_give,"alcatraz_shield_zm");
        break;
	case "zm_highrise": // Die Rise
	self MenuOption("Melee/Equipment Menu",2,"Monkey Bomb",::domonkey);
	self MenuOption("Melee/Equipment Menu",3,"Semtex",::dolethal,"sticky_grenade_zm");
	self MenuOption("Melee/Equipment Menu",4,"Galvaknuckles",::doMeleeBG,"tazer_knuckles_zm");
	self MenuOption("Melee/Equipment Menu",5,"Bowie Knife",::doMeleeBG,"bowie_knife_zm");
	self MenuOption("Melee/Equipment Menu",6,"Spring Pad",::doequipment_give,"equip_springpad_zm");
	self MenuOption("Melee/Equipment Menu",7,"Ballistic Knife",::doWeapon2,"knife_ballistic_zm");
	self MenuOption("Melee/Equipment Menu",8,"Upgraded Ballistic Knife",::doWeapon2,"knife_ballistic_upgraded_zm");		
	self MenuOption("Melee/Equipment Menu",9,"Ballistic Bowie",::doWeapon2,"knife_ballistic_bowie_zm");
	self MenuOption("Melee/Equipment Menu",10,"Upgraded Ballistic Bowie",::doWeapon2,"knife_ballistic_bowie_upgraded_zm");
        break;
	case "zm_nuked": // NukeTown
	self MenuOption("Melee/Equipment Menu",2,"Monkey Bomb",::domonkey);
	self MenuOption("Melee/Equipment Menu",3,"Semtex",::dolethal,"sticky_grenade_zm");
	self MenuOption("Melee/Equipment Menu",4,"Galvaknuckles",::doMeleeBG,"tazer_knuckles_zm");
	self MenuOption("Melee/Equipment Menu",5,"Bowie Knife",::doMeleeBG,"bowie_knife_zm");
	self MenuOption("Melee/Equipment Menu",6,"Ballistic Knife",::doWeapon2,"knife_ballistic_zm");
	self MenuOption("Melee/Equipment Menu",7,"Upgraded Ballistic Knife",::doWeapon2,"knife_ballistic_upgraded_zm");		
	self MenuOption("Melee/Equipment Menu",8,"Ballistic Bowie",::doWeapon2,"knife_ballistic_bowie_zm");
	self MenuOption("Melee/Equipment Menu",9,"Upgraded Ballistic Bowie",::doWeapon2,"knife_ballistic_bowie_upgraded_zm");
        break;
}
	self MainMenu("Weapons Menu","Gr3Zz v5.0");
	self MenuOption("Weapons Menu",0,"Ray Gun",::doWeapon2,"ray_gun_zm");
	self MenuOption("Weapons Menu",1,"RayGun Mark2",::doWeapon2,"raygun_mark2_zm");
	self MenuOption("Weapons Menu",2,"M14",::doWeapon2,"m14_zm");
	self MenuOption("Weapons Menu",3,"FnFal",::doWeapon2,"fnfal_zm");
	self MenuOption("Weapons Menu",4,"DSR50",::doWeapon2,"dsr50_zm");
	self MenuOption("Weapons Menu",5,"M82",::doWeapon2,"barretm82_zm");
	switch(GetDvar( "mapname" )){
	case "zm_transit": // Tranzit
	self MenuOption("Weapons Menu",6,"Jet Gun",::doequipment_give,"jetgun_zm");
	self MenuOption("Weapons Menu",7,"M1911",::doWeapon2,"m1911_zm");
	self MenuOption("Weapons Menu",8,"Python",::doWeapon2,"python_zm");
	self MenuOption("Weapons Menu",9,"Executioner",::doWeapon2,"judge_zm");
	self MenuOption("Weapons Menu",10,"MP5",::doWeapon2,"mp5k_zm");
	self MenuOption("Weapons Menu",11,"M16",::doWeapon2,"m16_gl_zm");
	self MenuOption("Weapons Menu",12,"RPD",::doWeapon2,"rpd_zm");
	self MenuOption("Weapons Menu",13,"M32",::doWeapon2,"m32_zm");
	self MenuOption("Weapons Menu",14,"M8A1",::doWeapon2,"xm8_zm");
	self MenuOption("Weapons Menu",15,"MTAR",::doWeapon2,"tar21_zm");
	self MenuOption("Weapons Menu",16,"Galil",::doWeapon2,"galil_zm");
        break;
	case "zm_buried": // Buried
	self MenuOption("Weapons Menu",6,"PDW-57",::doWeapon2,"pdw57_zm");
	self MenuOption("Weapons Menu",7,"Chicom",::doWeapon2,"qcw05_zm");
	self MenuOption("Weapons Menu",8,"AK74u",::doWeapon2,"ak74u_zm");
	self MenuOption("Weapons Menu",9,"AN94",::doWeapon2,"an94_zm");
	self MenuOption("Weapons Menu",10,"M1911",::doWeapon2,"m1911_zm");
	self MenuOption("Weapons Menu",11,"Python",::doWeapon2,"python_zm");
	self MenuOption("Weapons Menu",12,"Executioner",::doWeapon2,"judge_zm");
	self MenuOption("Weapons Menu",13,"HAMR",::doWeapon2,"hamr_zm");
	self MenuOption("Weapons Menu",14,"M32",::doWeapon2,"m32_zm");
	self MenuOption("Weapons Menu",15,"LSAT",::doWeapon2,"lsat_zm");
	self MenuOption("Weapons Menu",16,"Paralyzer",::doWeapon2,"slowgun_zm");
        break;
	case "zm_tomb": // Origins
	self MenuOption("Weapons Menu",6,"MP40",::doWeapon2,"mp40_zm");
	self MenuOption("Weapons Menu",7,"STG-44",::doWeapon2,"mp44_zm");
	self MenuOption("Weapons Menu",8,"Chicom",::doWeapon2,"qcw05_zm");		
	self MenuOption("Weapons Menu",9,"AK74u",::doWeapon2,"ak74u_zm");
	self MenuOption("Weapons Menu",10,"AK74u ExtendedMag",::doWeapon2,"ak74u_extclip_zm");
	self MenuOption("Weapons Menu",11,"AN94",::doWeapon2,"an94_zm");
	self MenuOption("Weapons Menu",12,"Python",::doWeapon2,"python_zm");
	self MenuOption("Weapons Menu",13,"Mauser C96",::doWeapon2,"c96_zm");
	self MenuOption("Weapons Menu",14,"HAMR",::doWeapon2,"hamr_zm");
	self MenuOption("Weapons Menu",15,"M32",::doWeapon2,"m32_zm");
	self MenuOption("Weapons Menu",16,"MG08",::doWeapon2,"mg08_zm");
        break;
	case "zm_prison": // MOTD
	self MenuOption("Weapons Menu",6,"Uzi",::doWeapon2,"uzi_zm");
	self MenuOption("Weapons Menu",7,"MP5",::doWeapon2,"mp5k_zm");
	self MenuOption("Weapons Menu",8,"PDW-57",::doWeapon2,"pdw57_zm");
	self MenuOption("Weapons Menu",9,"Thompson",::doWeapon2,"thompson_zm");
	self MenuOption("Weapons Menu",10,"AK47",::doWeapon2,"ak47_zm");
	self MenuOption("Weapons Menu",11,"Blundergat",::doWeapon2,"blundergat_zm");
	self MenuOption("Weapons Menu",12,"Blundersplat",::doWeapon2,"blundersplat_zm");
   	self MenuOption("Weapons Menu",13,"M1911",::doWeapon2,"m1911_zm");
	self MenuOption("Weapons Menu",14,"S12",::doWeapon2,"saiga12_zm");
	self MenuOption("Weapons Menu",15,"LSAT",::doWeapon2,"lsat_zm");
	self MenuOption("Weapons Menu",16,"Minigun",::doWeapon2,"minigun_alcatraz_zm");
        break;
	case "zm_highrise": // Die Rise
	self MenuOption("Weapons Menu",6,"MP5",::doWeapon2,"mp5k_zm");
	self MenuOption("Weapons Menu",7,"PDW-57",::doWeapon2,"pdw57_zm");
	self MenuOption("Weapons Menu",8,"Chicom",::doWeapon2,"qcw05_zm");
	self MenuOption("Weapons Menu",9,"AK74u",::doWeapon2,"ak74u_zm");
	self MenuOption("Weapons Menu",10,"AN94",::doWeapon2,"an94_zm");
	self MenuOption("Weapons Menu",11,"M1911",::doWeapon2,"m1911_zm");
	self MenuOption("Weapons Menu",12,"RPD",::doWeapon2,"rpd_zm");
	self MenuOption("Weapons Menu",13,"HAMR",::doWeapon2,"hamr_zm");
	self MenuOption("Weapons Menu",14,"M32",::doWeapon2,"m32_zm");
	self MenuOption("Weapons Menu",15,"HAMR",::doWeapon2,"hamr_zm");
	self MenuOption("Weapons Menu",16,"Sliquifier",::doWeapon2,"slipgun_zm");
        break;
	case "zm_nuked": // NukeTown
	self MenuOption("Weapons Menu",6,"MP5",::doWeapon2,"mp5k_zm");
	self MenuOption("Weapons Menu",7,"PDW-57",::doWeapon2,"pdw57_zm");
	self MenuOption("Weapons Menu",8,"Chicom",::doWeapon2,"qcw05_zm");
	self MenuOption("Weapons Menu",9,"AK74u",::doWeapon2,"ak74u_zm");
	self MenuOption("Weapons Menu",10,"M16",::doWeapon2,"m16_gl_zm");
	self MenuOption("Weapons Menu",11,"M8A1",::doWeapon2,"xm8_zm");
	self MenuOption("Weapons Menu",12,"M27",::doWeapon2,"hk416_zm");
	self MenuOption("Weapons Menu",13,"Galil",::doWeapon2,"galil_zm");
	self MenuOption("Weapons Menu",14,"HAMR",::doWeapon2,"hamr_zm");
	self MenuOption("Weapons Menu",15,"RPD",::doWeapon2,"rpd_zm");
	self MenuOption("Weapons Menu",16,"LSAT",::doWeapon2,"lsat_zm");
        break;
}
	self MainMenu("Upgraded Weapons Menu","Gr3Zz v5.0");
	self MenuOption("Upgraded Weapons Menu",0,"Ray Gun",::doWeapon2,"ray_gun_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",1,"RayGun Mark2",::doWeapon2,"raygun_mark2_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",2,"M14",::doWeapon2,"m14_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",3,"FnFal",::doWeapon2,"fnfal_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",4,"DSR50",::doWeapon2,"dsr50_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",5,"M82",::doWeapon2,"barretm82_upgraded_zm");
	switch(GetDvar( "mapname" )){
	case "zm_transit": // Tranzit
	self MenuOption("Upgraded Weapons Menu",6,"M1911",::doWeapon2,"m1911_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",7,"Python",::doWeapon2,"python_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",8,"Executioner",::doWeapon2,"judge_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",9,"MP5",::doWeapon2,"mp5k_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",10,"M16",::doWeapon2,"m16_gl_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",11,"RPD",::doWeapon2,"rpd_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",12,"M32",::doWeapon2,"m32_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",13,"M8A1",::doWeapon2,"xm8_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",14,"MTAR",::doWeapon2,"tar21_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",15,"Galil",::doWeapon2,"galil_upgraded_zm");
        break;
	case "zm_buried": // Buried
	self MenuOption("Upgraded Weapons Menu",6,"PDW-57",::doWeapon2,"pdw57_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",7,"Chicom",::doWeapon2,"qcw05_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",8,"AK74u",::doWeapon2,"ak74u_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",9,"AN94",::doWeapon2,"an94_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",10,"M1911",::doWeapon2,"m1911_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",11,"Python",::doWeapon2,"python_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",12,"Executioner",::doWeapon2,"judge_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",13,"HAMR",::doWeapon2,"hamr_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",14,"M32",::doWeapon2,"m32_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",15,"LSAT",::doWeapon2,"lsat_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",16,"Paralyzer",::doWeapon2,"slowgun_upgraded_zm");
        break;
	case "zm_tomb": // Origins
	self MenuOption("Upgraded Weapons Menu",6,"MP40",::doWeapon2,"mp40_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",7,"STG-44",::doWeapon2,"mp44_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",8,"Chicom",::doWeapon2,"qcw05_upgraded_zm");		
	self MenuOption("Upgraded Weapons Menu",9,"AK74u",::doWeapon2,"ak74u_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",10,"AK74u ExtendedMag",::doWeapon2,"ak74u_extclip_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",11,"AN94",::doWeapon2,"an94_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",12,"Python",::doWeapon2,"python_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",13,"Mauser C96",::doWeapon2,"c96_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",14,"HAMR",::doWeapon2,"hamr_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",15,"M32",::doWeapon2,"m32_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",16,"MG08",::doWeapon2,"mg08_upgraded_zm");
        break;
	case "zm_prison": // MOTD
	self MenuOption("Upgraded Weapons Menu",6,"Uzi",::doWeapon2,"uzi_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",7,"MP5",::doWeapon2,"mp5k_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",8,"PDW-57",::doWeapon2,"pdw57_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",9,"Thompson",::doWeapon2,"thompson_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",10,"AK47",::doWeapon2,"ak47_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",11,"Blundergat",::doWeapon2,"blundergat_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",12,"Blundersplat",::doWeapon2,"blundersplat_upgraded_zm");
   	self MenuOption("Upgraded Weapons Menu",13,"M1911",::doWeapon2,"m1911_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",14,"S12",::doWeapon2,"saiga12_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",15,"LSAT",::doWeapon2,"lsat_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",16,"Minigun",::doWeapon2,"minigun_alcatraz_upgraded_zm");
        break;
	case "zm_highrise": // Die Rise
	self MenuOption("Upgraded Weapons Menu",6,"MP5",::doWeapon2,"mp5k_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",7,"PDW-57",::doWeapon2,"pdw57_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",8,"Chicom",::doWeapon2,"qcw05_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",9,"AK74u",::doWeapon2,"ak74u_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",10,"AN94",::doWeapon2,"an94_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",11,"M1911",::doWeapon2,"m1911_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",12,"RPD",::doWeapon2,"rpd_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",13,"HAMR",::doWeapon2,"hamr_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",14,"M32",::doWeapon2,"m32_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",15,"HAMR",::doWeapon2,"hamr_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",16,"Sliquifier",::doWeapon2,"slipgun_upgraded_zm");
        break;
	case "zm_nuked": // NukeTown
	self MenuOption("Upgraded Weapons Menu",6,"MP5",::doWeapon2,"mp5k_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",7,"PDW-57",::doWeapon2,"pdw57_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",8,"Chicom",::doWeapon2,"qcw05_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",9,"AK74u",::doWeapon2,"ak74u_upgraded_zm");
    self MenuOption("Upgraded Weapons Menu",10,"M16",::doWeapon2,"m16_gl_upgraded_zm");
    self MenuOption("Upgraded Weapons Menu",11,"M8A1",::doWeapon2,"xm8_upgraded_zm");
	self MenuOption("Upgraded Weapons Menu",12,"M27",::doWeapon2,"hk416_upgraded_zm");
    self MenuOption("Upgraded Weapons Menu",13,"Galil",::doWeapon2,"galil_upgraded_zm");
    self MenuOption("Upgraded Weapons Menu",14,"HAMR",::doWeapon2,"hamr_upgraded_zm");
    self MenuOption("Upgraded Weapons Menu",15,"RPD",::doWeapon2,"rpd_upgraded_zm");
    self MenuOption("Upgraded Weapons Menu",16,"LSAT",::doWeapon2,"lsat_upgraded_zm");
        break;
}
	switch(GetDvar( "mapname" )){
	case "zm_tomb": // Origins
	self MainMenu("Staffs Menu","Gr3Zz v5.0");
	self MenuOption("Staffs Menu",0,"Air Staff",::doWeapon2,"staff_air_zm");
    self MenuOption("Staffs Menu",1,"Fire Staff",::doWeapon2,"staff_fire_zm");
	self MenuOption("Staffs Menu",2,"Ice Staff",::doWeapon2,"staff_water_zm");		
	self MenuOption("Staffs Menu",3,"Lightning Staff",::doWeapon2,"staff_lightning_zm");
	self MenuOption("Staffs Menu",4,"Revive Staff",::doWeapon3,"staff_revive_zm");
	self MenuOption("Staffs Menu",5,"Upgraded Air Staff",::doWeapon3,"staff_air_upgraded_zm");
    self MenuOption("Staffs Menu",6,"Upgraded Fire Staff",::doWeapon3,"staff_fire_upgraded_zm");
	self MenuOption("Staffs Menu",7,"Upgraded Ice Staff",::doWeapon3,"staff_lightning_upgraded_zm");		
	self MenuOption("Staffs Menu",8,"Upgraded Lightning Staff",::doWeapon3,"staff_water_upgraded_zm");
		break;
}
	self MainMenu("Bullets Menu","Gr3Zz v5.0");
	self MenuOption("Bullets Menu",0,"Bullets Ricochet",::Tgl_Ricochet);
	self MenuOption("Bullets Menu",1,"Teleporter Weapons",::TeleportGun);
	self MenuOption("Bullets Menu",2,"FlameThrower",::FTH);
	self MenuOption("Bullets Menu",3,"Ray Gun",::doBullet,"ray_gun_zm");
	switch(GetDvar( "mapname" )){
	case "zm_transit": // Tranzit
	self MenuOption("Bullets Menu",4,"War Machine",::doBullet,"m32_upgraded_zm");
	self MenuOption("Bullets Menu",5,"Hamr",::doBullet,"hamr_upgraded_zm");
	self MenuOption("Bullets Menu",6,"RPD",::doBullet,"rpd_upgraded_zm");
	self MenuOption("Bullets Menu",7,"RPG",::doBullet,"usrpg_upgraded_zm");
	self MenuOption("Bullets Menu",8,"M1911",::doBullet,"m1911_upgraded_zm");	
	self MenuOption("Bullets Menu",9,"DSR",::doBullet,"dsr50_upgraded_zm");
	self MenuOption("Bullets Menu",10,"Normal Bullets",::NormalBullets);
        break;
	case "zm_buried": // Buried
	self MenuOption("Bullets Menu",4,"War Machine",::doBullet,"m32_upgraded_zm");
	self MenuOption("Bullets Menu",5,"Hamr",::doBullet,"hamr_upgraded_zm");
	self MenuOption("Bullets Menu",6,"LSAT",::doBullet,"lsat_upgraded_zm");
	self MenuOption("Bullets Menu",7,"RPG",::doBullet,"usrpg_upgraded_zm");
	self MenuOption("Bullets Menu",8,"M1911",::doBullet,"m1911_upgraded_zm");	
	self MenuOption("Bullets Menu",9,"AN94",::doBullet,"an94_upgraded_zm");	
	self MenuOption("Bullets Menu",10,"DSR",::doBullet,"dsr50_upgraded_zm");
	self MenuOption("Bullets Menu",11,"Dragunov",::doBullet,"svu_upgraded_zm");
	self MenuOption("Bullets Menu",12,"Paralyzer",::doBullet,"slowgun_upgraded_zm");
	self MenuOption("Bullets Menu",12,"Normal Bullets",::NormalBullets);
        break;
	case "zm_tomb": // Origins
	self MenuOption("Bullets Menu",4,"War Machine",::doBullet,"m32_upgraded_zm");
	self MenuOption("Bullets Menu",5,"Hamr",::doBullet,"hamr_upgraded_zm");
	self MenuOption("Bullets Menu",6,"MG08",::doBullet,"mg08_upgraded_zm");
	self MenuOption("Bullets Menu",7,"MP40",::doBullet,"mp40_upgraded_zm");
	self MenuOption("Bullets Menu",8,"SCAR",::doBullet,"scar_upgraded_zm");
	self MenuOption("Bullets Menu",9,"Thompson",::doBullet,"thompson_upgraded_zm");
	self MenuOption("Bullets Menu",10,"DSR",::doBullet,"dsr50_upgraded_zm");
	self MenuOption("Bullets Menu",11,"Ballista",::doBullet,"ballista_upgraded_zm");
	self MenuOption("Bullets Menu",12,"Air Staff",::doBullet,"staff_air_zm");
	self MenuOption("Bullets Menu",13,"Fire Staff",::doBullet,"staff_fire_zm");	
	self MenuOption("Bullets Menu",14,"Ice Staff",::doBullet,"staff_water_zm");
	self MenuOption("Bullets Menu",15,"Lightning Staff",::doBullet,"staff_lightning_zm");
	self MenuOption("Bullets Menu",16,"Normal Bullets",::NormalBullets);
        break;
	case "zm_prison": // MOTD
	self MenuOption("Bullets Menu",4,"Hamr",::doBullet,"hamr_upgraded_zm");
	self MenuOption("Bullets Menu",5,"Minigun",::doBullet,"minigun_alcatraz_upgraded_zm");
	self MenuOption("Bullets Menu",6,"LSAT",::doBullet,"lsat_upgraded_zm");	
	self MenuOption("Bullets Menu",7,"M1911",::doBullet,"m1911_upgraded_zm");	
	self MenuOption("Bullets Menu",8,"UZI",::doBullet,"uzi_upgraded_zm");	
	self MenuOption("Bullets Menu",9,"DSR",::doBullet,"dsr50_upgraded_zm");
	self MenuOption("Bullets Menu",10,"Blundergat",::doBullet,"blundergat_upgraded_zm");
	self MenuOption("Bullets Menu",11,"Blundersplat",::doBullet,"blundersplat_upgraded_zm");
	self MenuOption("Bullets Menu",12,"Blundersplat Explosive Dart",::doBullet,"blundersplat_explosive_dart_zm");
	self MenuOption("Bullets Menu",13,"DSR",::doBullet,"dsr50_upgraded_zm");
	self MenuOption("Bullets Menu",14,"M82",::doBullet,"barretm82_upgraded_zm");
	self MenuOption("Bullets Menu",15,"Normal Bullets",::NormalBullets);
        break;
	case "zm_highrise": // Die Rise
	self MenuOption("Bullets Menu",4,"War Machine",::doBullet,"m32_upgraded_zm");
	self MenuOption("Bullets Menu",5,"Hamr",::doBullet,"hamr_upgraded_zm");
	self MenuOption("Bullets Menu",6,"RPD",::doBullet,"rpd_upgraded_zm");
	self MenuOption("Bullets Menu",7,"RPG",::doBullet,"usrpg_upgraded_zm");
	self MenuOption("Bullets Menu",8,"M1911",::doBullet,"m1911_upgraded_zm");
	self MenuOption("Bullets Menu",9,"AN94",::doBullet,"an94_upgraded_zm");	
	self MenuOption("Bullets Menu",10,"DSR",::doBullet,"dsr50_upgraded_zm");
	self MenuOption("Bullets Menu",11,"Dragunov",::doBullet,"svu_upgraded_zm");
	self MenuOption("Bullets Menu",12,"Sliquifier",::doBullet,"slipgun_upgraded_zm");
	self MenuOption("Bullets Menu",13,"Normal Bullets",::NormalBullets);
        break;
	case "zm_nuked": // NukeTown
	self MenuOption("Bullets Menu",4,"War Machine",::doBullet,"m32_upgraded_zm");
	self MenuOption("Bullets Menu",5,"Hamr",::doBullet,"hamr_upgraded_zm");
	self MenuOption("Bullets Menu",6,"LSAT",::doBullet,"lsat_upgraded_zm");
	self MenuOption("Bullets Menu",7,"RPG",::doBullet,"usrpg_upgraded_zm");
	self MenuOption("Bullets Menu",8,"M1911",::doBullet,"m1911_upgraded_zm");
	self MenuOption("Bullets Menu",9,"DSR",::doBullet,"dsr50_upgraded_zm");	
	self MenuOption("Bullets Menu",10,"Normal Bullets",::NormalBullets);
        break;
}
	self MainMenu("Perks Menu","Gr3Zz v5.0");
	self MenuOption("Perks Menu",0,"Juggernaut",::doPerks,"specialty_armorvest");
	self MenuOption("Perks Menu",1,"Quick Revive",::doPerks,"specialty_quickrevive");
	self MenuOption("Perks Menu",2,"SpeedCola",::doPerks,"specialty_fastreload");
	self MenuOption("Perks Menu",3,"Double Tap",::doPerks,"specialty_rof");
	switch(GetDvar( "mapname" )){
	case "zm_transit": // Tranzit
	self MenuOption("Perks Menu",4,"Stamin Up",::doPerks,"specialty_longersprint");
	self MenuOption("Perks Menu",5,"TombStone",::doPerks,"specialty_scavenger");
	self MenuOption("Perks Menu",6,"Give All Perks",::giveallperks);
	self MenuOption("Perks Menu",7,"Remove All Perks",::removeallperks);		
        break;
	case "zm_buried": // Buried
	self MenuOption("Perks Menu",4,"Stamin Up",::doPerks,"specialty_longersprint");
	self MenuOption("Perks Menu",5,"Mule Kick",::doPerks,"specialty_additionalprimaryweapon");
	self MenuOption("Perks Menu",6,"Vulture Aid",::doPerks,"specialty_nomotionsensor");
	self MenuOption("Perks Menu",7,"PhD Flopper ",::doPerks,"specialty_flakjacket");
	self MenuOption("Perks Menu",8,"Give All Perks",::giveallperks);
	self MenuOption("Perks Menu",9,"Remove All Perks",::removeallperks);
        break;
	case "zm_tomb": // Origins
	self MenuOption("Perks Menu",4,"Stamin Up",::doPerks,"specialty_longersprint");
	self MenuOption("Perks Menu",5,"Mule Kick",::doPerks,"specialty_additionalprimaryweapon");
	self MenuOption("Perks Menu",6,"Electric Cherry",::doPerks,"specialty_grenadepulldeath");
	self MenuOption("Perks Menu",7,"PhD Flopper ",::doPerks,"specialty_flakjacket");
	self MenuOption("Perks Menu",8,"Dead Shot",::doPerks,"specialty_deadshot");
	self MenuOption("Perks Menu",9,"Give All Perks",::giveallperks);
	self MenuOption("Perks Menu",10,"Remove All Perks",::removeallperks);
        break;
	case "zm_prison": // MOTD
	self MenuOption("Perks Menu",4,"Mule Kick",::doPerks,"specialty_additionalprimaryweapon");
	self MenuOption("Perks Menu",5,"Electric Cherry",::doPerks,"specialty_grenadepulldeath");
	self MenuOption("Perks Menu",6,"PhD Flopper ",::doPerks,"specialty_flakjacket");
	self MenuOption("Perks Menu",7,"Dead Shot",::doPerks,"specialty_deadshot");
	self MenuOption("Perks Menu",8,"Give All Perks",::giveallperks);
	self MenuOption("Perks Menu",9,"Remove All Perks",::removeallperks);
        break;
	case "zm_highrise": // Die Rise
	self MenuOption("Perks Menu",4,"Mule Kick",::doPerks,"specialty_additionalprimaryweapon");
	self MenuOption("Perks Menu",5,"Who's Who",::doPerks,"specialty_finalstand");
	self MenuOption("Perks Menu",6,"Give All Perks",::giveallperks);
	self MenuOption("Perks Menu",7,"Remove All Perks",::removeallperks);
        break;
}
	self MainMenu("Fun Menu","Gr3Zz v5.0");
	self MenuOption("Fun Menu",0,"UFO Mode",::UFOMode);
	self MenuOption("Fun Menu",1,"Forge Mode",::Forge);
	self MenuOption("Fun Menu",2,"Aimbot",::doAimbot);
	self MenuOption("Fun Menu",3,"Save and Load",::SaveandLoad);
	self MenuOption("Fun Menu",4,"Skull Protector",::doProtecion);
	self MenuOption("Fun Menu",5,"Drunk Mode",::aarr649);
	self MenuOption("Fun Menu",6,"Zombies Ignore Me",::NoTarget);
	self MenuOption("Fun Menu",7,"JetPack",::doJetPack);
	self MenuOption("Fun Menu",8,"Rapid Fire",::RapidFire);
	self MenuOption("Fun Menu",9,"Drop Current Weapon",::weapondrop);
	self MenuOption("Fun Menu",10,"Pack-A-Punch Weapon",::packcurrentweapon_nzv, 0);
	self MenuOption("Fun Menu",11,"Pack-A-Punch Weapon+",::packcurrentweapon_nzv, 1);
	self MenuOption("Fun Menu",12,"UnPack-A-Punch Weapon",::unpackcurrentweapon_nzv);
	switch(GetDvar( "mapname" )){
	case "zm_transit": // Tranzit
	self MenuOption("Fun Menu",13,"Song: CarriOn",::EasterEggSong);
        break;
	case "zm_buried": // Buried
		self MenuOption("Fun Menu",13,"Song: Always Running",::EasterEggSong);
        break;
	case "zm_tomb": // Origins
	self MenuOption("Fun Menu",13,"Song: ArchAngel",::EasterEggSong);
	self MenuOption("Fun Menu",14,"Song: Shepherd of Fire",::OriginsSong2);
	self MenuOption("Fun Menu",15,"Song: Aether",::OriginsSong3);
        break;
	case "zm_prison": // MOTD
	self MenuOption("Fun Menu",13,"Song: Rusty Cage",::EasterEggSong);
	self MenuOption("Fun Menu",14,"Song: Where Are We Going",::EasterEggSong2);
        break;
	case "zm_highrise": // Die Rise
	self MenuOption("Fun Menu",13,"Song: We All Fall Down",::EasterEggSong);
        break;
	case "zm_nuked": // NukeTown
	self MenuOption("Fun Menu",13,"Song: NukeTown 1",::NukedSong1);
	self MenuOption("Fun Menu",14,"Song: NukeTown 2",::NukedSong2);
	self MenuOption("Fun Menu",15,"Song: NukeTown 3",::NukedSong3);
        break;
}
	self MainMenu("Theme Menu","Gr3Zz v5.0");
	self MenuOption("Theme Menu",0,"Default Theme",::doDefaultTheme);
	self MenuOption("Theme Menu",1,"Blue Theme",::doBlue);
	self MenuOption("Theme Menu",2,"Green Theme",::doGreen);
	self MenuOption("Theme Menu",3,"Yellow Theme",::doYellow);
	self MenuOption("Theme Menu",4,"Pink Theme",::doPink);
	self MenuOption("Theme Menu",5,"Cyan Theme",::doCyan);
	self MenuOption("Theme Menu",6,"Center Menu",::doMenuCenter);
	self MainMenu("Teleport Menu","Gr3Zz v5.0");
	switch(GetDvar( "mapname" )){
	case "zm_transit": // Tranzit
	self MenuOption("Teleport Menu",0,"Bus",::teleportToBus);
	self MenuOption("Teleport Menu",1,"Bus Depot",::teleporttoBusStop);
	self MenuOption("Teleport Menu",2,"Tunnel",::teleporttoTunnel);
	self MenuOption("Teleport Menu",3,"Diner",::teleporttoDiner);
	self MenuOption("Teleport Menu",4,"Diner Roof",::teleportToDinerRoof);
	self MenuOption("Teleport Menu",5,"Farm",::teleporttoFarm);
	self MenuOption("Teleport Menu",6,"Nach der Toten",::teleporttoNach);
	self MenuOption("Teleport Menu",7,"Power Station",::teleporttoPowerStation);
	self MenuOption("Teleport Menu",8,"Forest Cabin",::teleportToHuntersCabin);
	self MenuOption("Teleport Menu",9,"Town",::teleporttoTown);
	self MenuOption("Teleport Menu",10,"Pack-A-Punch Room",::teleportToPackAPunchRoom);
        break;
	case "zm_buried": // Buried
	self MenuOption("Teleport Menu",0,"Spawn",::teleporttoBuriedSpawn);
	self MenuOption("Teleport Menu",1,"Under Spawn",::teleporttoBuriedUnderGround);
	self MenuOption("Teleport Menu",2,"Bank House",::teleporttoBankHouse);
	self MenuOption("Teleport Menu",3,"Prison Cell",::teleporttoLeroyCell);
	self MenuOption("Teleport Menu",4,"Saloon",::teleporttoBarSaloon);
	self MenuOption("Teleport Menu",5,"Power",::teleporttoBuriedPower);
	self MenuOption("Teleport Menu",6,"Church",::teleporttoBuriedChurch);
	self MenuOption("Teleport Menu",7,"Mansion",::teleporttoMansion);
	self MenuOption("Teleport Menu",8,"Maze Entrance",::teleporttoMazeEnter);
	self MenuOption("Teleport Menu",9,"Maze Exit",::teleporttoMazeExit);
	self MenuOption("Teleport Menu",10,"Pack-A-Punch",::teleporttoBuriedPac);
        break;
	case "zm_tomb": // Origins
	self MenuOption("Teleport Menu",0,"Tank POS 1",::teleporttoTank);
	self MenuOption("Teleport Menu",1,"Tank POS 2",::teleporttoTank2);
	self MenuOption("Teleport Menu",2,"No Mans Land",::teleporttoNoMansLand);
	self MenuOption("Teleport Menu",3,"Church",::teleporttoChurch);
	self MenuOption("Teleport Menu",4,"Generator 1",::teleporttoGen1);
	self MenuOption("Teleport Menu",5,"Generator 2",::teleporttoGen2);
	self MenuOption("Teleport Menu",6,"Generator 3",::teleporttoGen3);
	self MenuOption("Teleport Menu",7,"Generator 4",::teleporttoGen4);
	self MenuOption("Teleport Menu",8,"Generator 5",::teleporttoGen5);
	self MenuOption("Teleport Menu",9,"Generator 6",::teleporttoGen6);
	self MenuOption("Teleport Menu",10,"Crazy Place Air",::teleporttoCrazyPlaceAir);
	self MenuOption("Teleport Menu",11,"Crazy Place Fire",::teleporttoCrazyPlaceFire);
	self MenuOption("Teleport Menu",12,"Crazy Place Ice",::teleporttoCrazyPlaceIce);
	self MenuOption("Teleport Menu",13,"Crazy Place Lightning",::teleporttoCrazyPlaceLightning);
	self MenuOption("Teleport Menu",14,"Staff Room",::teleporttoStaffRoom);
	self MenuOption("Teleport Menu",15,"Pack-A-Punch",::teleporttoOriginsPAP);
        break;
	case "zm_prison": // MOTD
	self MenuOption("Teleport Menu",0,"Spawn",::teleporttoSpawn);
	self MenuOption("Teleport Menu",1,"Stair Case",::teleporttoStairCase);
	self MenuOption("Teleport Menu",2,"Harbor",::teleporttoHarbor);
	self MenuOption("Teleport Menu",3,"Dog 1",::teleporttoDog1);
	self MenuOption("Teleport Menu",4,"Dog 2",::teleporttoDog2);
	self MenuOption("Teleport Menu",5,"Dog 3",::teleporttoDog3);
	self MenuOption("Teleport Menu",6,"Pack-A-Punch",::teleporttoBridge);
        break;
	case "zm_highrise": // Die Rise
	self MenuOption("Teleport Menu",0,"Spawn",::teleporttoHighSpawn);
	self MenuOption("Teleport Menu",1,"Slide",::teleporttoSlide);
	self MenuOption("Teleport Menu",2,"Broken Elevator",::teleporttoBrokenElevator);
	self MenuOption("Teleport Menu",3,"Red Room",::teleporttoRedRoom);
	self MenuOption("Teleport Menu",4,"Power",::teleporttoBankPower);
	self MenuOption("Teleport Menu",5,"Roof",::teleporttoRoof);
	self MenuOption("Teleport Menu",6,"Main Room",::teleporttoMainRoom);
	self MenuOption("Teleport Menu",7,"Pack-A-Punch",::teleporttoHighPac);
        break;
	case "zm_nuked": // NukeTown
	self MenuOption("Teleport Menu",0,"Bus",::teleporttoNukeBus);
	self MenuOption("Teleport Menu",1,"Green House",::teleporttoGreenHouse);
	self MenuOption("Teleport Menu",2,"Green Office",::teleporttoGreenOffice);
	self MenuOption("Teleport Menu",3,"Green Garden",::teleporttoGreenGarden);
	self MenuOption("Teleport Menu",4,"Green Garage",::teleporttoGreenGarage);
	self MenuOption("Teleport Menu",5,"Yellow House",::teleporttoYellowHouse);
	self MenuOption("Teleport Menu",6,"Yellow Office",::teleporttoYellowOffice);
	self MenuOption("Teleport Menu",7,"Yellow Garden",::teleporttoYellowGarden);
	self MenuOption("Teleport Menu",8,"Yellow Garage",::teleporttoYellowGarage);
        break;
}
	self MainMenu("Power Ups","Gr3Zz v5.0");	
	self MenuOption("Power Ups",0,"Nuke Bomb",::doPNuke);
	self MenuOption("Power Ups",1,"Max Ammo",::doPMAmmo);
	self MenuOption("Power Ups",2,"Double Points",::doPDoublePoints);
	self MenuOption("Power Ups",3,"Insta Kill",::doPInstaKills);
	switch(GetDvar( "mapname" )){
	case "zm_transit": // Tranzit
	self MenuOption("Power Ups",4,"Insta Kill UG",::GivePowerUp,"insta_kill_ug");
        break;
	case "zm_buried": // Buried
	self MenuOption("Power Ups",4,"Carpenter",::GivePowerUp,"carpenter");
	self MenuOption("Power Ups",5,"Fire Sale",::GivePowerUp,"fire_sale");
	self MenuOption("Power Ups",6,"Free Perk",::GivePowerUp,"free_perk");
	self MenuOption("Power Ups",7,"Insta Kill UG",::GivePowerUp,"insta_kill_ug");
	self MenuOption("Power Ups",8,"Random Weapon",::GivePowerUp,"random_weapon");
        break;
	case "zm_tomb": // Origins
	self MenuOption("Power Ups",4,"Fire Sale",::GivePowerUp,"fire_sale");
	self MenuOption("Power Ups",5,"Free Perk",::GivePowerUp,"free_perk");
	self MenuOption("Power Ups",6,"Bonus Points",::GivePowerUp,"bonus_points_team");
	self MenuOption("Power Ups",7,"Zombie Blood",::zbgrab);
        break;
	case "zm_prison": // MOTD
	self MenuOption("Power Ups",4,"Fire Sale",::GivePowerUp,"fire_sale");
        break;
	case "zm_highrise": // Die Rise
	self MenuOption("Power Ups",4,"Carpenter",::GivePowerUp,"carpenter");
	self MenuOption("Power Ups",5,"Free Perk",::GivePowerUp,"free_perk");
	self MenuOption("Power Ups",6,"Insta Kill UG",::GivePowerUp,"insta_kill_ug");
        break;
	case "zm_nuked": // NukeTown
	self MenuOption("Power Ups",4,"Fire Sale",::GivePowerUp,"fire_sale");
        break;
}
	self MainMenu("Game Settings","Gr3Zz v5.0");
	self MenuOption("Game Settings",0,"Open All Doors",::OpenAllTehDoors);
	self MenuOption("Game Settings",1,"MysteryBox Everywhere",::AllBoxLocations);
	self MenuOption("Game Settings",2,"MysteryBox Never Moves",::BoxStays);
	self MenuOption("Game Settings",3,"Auto Revive",::autoRevive);
	self MenuOption("Game Settings",4,"Gore Mode",::toggle_gore2);
	self MenuOption("Game Settings",5,"Go Up 1 Round",::round_up);
	self MenuOption("Game Settings",6,"Go Down 1 Round",::round_down);
	self MenuOption("Game Settings",7,"Round 20",::round_20);
	self MenuOption("Game Settings",8,"Super Jump",::Toogle_Jump);
	self MenuOption("Game Settings",9,"Speed Hack",::Toogle_Speeds);
	self MenuOption("Game Settings",10,"Freeze Zombies",::Fr3ZzZoM);
	self MenuOption("Game Settings",11,"Kill All Zombies",::ZombieKill);
	self MenuOption("Game Settings",12,"Zombies Default Model",::ZombieDefaultActor);
	self MenuOption("Game Settings",13,"Fast Zombies",::fastZombies);
	self MenuOption("Game Settings",14,"Slow Zombies",::doSlowZombies);
	self MenuOption("Game Settings",15,"Restart Match",::dorestartgame);
	self MenuOption("Game Settings",16,"End Match",::doendgame);
	self MainMenu("Clients Menu","Gr3Zz v5.0");
	for(p=0;p<level.players.size;p++)
	{
		player=level.players[p];
		self MenuOption("Clients Menu",p,"["+player.MyAccess+"^7] "+player.name+"",::SubMenu,"Clients Functions");
	}
	self thread MonitorPlayers();
	self MainMenu("Clients Functions","Clients Menu");
	self MenuOption("Clients Functions",0,"Verify Player",::Verify);
	self MenuOption("Clients Functions",1,"VIP Player",::doVIP);
	self MenuOption("Clients Functions",2,"Co-Host Player",::doCoHost);
	self MenuOption("Clients Functions",3,"Unverified Player",::doUnverif);
	self MenuOption("Clients Functions",4,"Teleport To Me",::doTeleportToMe);
	self MenuOption("Clients Functions",5,"Teleport To Him",::doTeleportToHim);
	self MenuOption("Clients Functions",6,"Freeze Position",::PlayerFrezeControl);
	self MenuOption("Clients Functions",7,"Take All Weapons",::ChiciTakeWeaponPlayer);
	self MenuOption("Clients Functions",8,"Give Weapons",::doGivePlayerWeapon);
	self MenuOption("Clients Functions",9,"Give GodMod",::PlayerGiveGodMod);
	self MenuOption("Clients Functions",10,"Revive",::doRevivePlayer);
	self MenuOption("Clients Functions",11,"Kick",::kickPlayer);
	self MainMenu("All Clients","Gr3Zz v5.0");
	self MenuOption("All Clients",0,"All GodMod",::AllPlayerGiveGodMod);
	self MenuOption("All Clients",1,"Teleport All To Me",::doTeleportAllToMe);
	self MenuOption("All Clients",2,"Freeze All Position",::doFreeAllPosition);
	self MenuOption("All Clients",3,"Revive All",::doReviveAlls);
	self MenuOption("All Clients",4,"Kick All",::doAllKickPlayer);
}
MonitorPlayers()
{
	self endon("disconnect");
	for(;;)
	{
		for(p=0;p<level.players.size;p++)
		{
			player=level.players[p];
			self.Menu.System["MenuTexte"]["Clients Menu"][p]="["+player.MyAccess+"^7] "+player.name;
			self.Menu.System["MenuFunction"]["Clients Menu"][p]=::SubMenu;
			self.Menu.System["MenuInput"]["Clients Menu"][p]="Clients Functions";
			wait .01;
		}
		wait .5;
	}
}
MainMenu(Menu,Return)
{
	self.Menu.System["GetMenu"]=Menu;
	self.Menu.System["MenuCount"]=0;
	self.Menu.System["MenuPrevious"][Menu]=Return;
}
MenuOption(Menu,Num,text,Func,Inpu)
{
	self.Menu.System["MenuTexte"][Menu][Num]=text;
	self.Menu.System["MenuFunction"][Menu][Num]=Func;
	self.Menu.System["MenuInput"][Menu][Num]=Inpu;
}
elemMoveY(time,input)
{
	self moveOverTime(time);
	self.y=input;
}
elemMoveX(time,input)
{
	self moveOverTime(time);
	self.x=input;
}
elemFade(time,alpha)
{
	self fadeOverTime(time);
	self.alpha=alpha;
}
elemColor(time,color)
{
	self fadeOverTime(time);
	self.color=color;
}
elemGlow(time,glowin)
{
	self fadeOverTime(time);
	self.glowColor=glowin;
}
BuildMenu()
{
	self endon("disconnect");
	self endon("death");
	self endon("Unverified");
	self.MenuOpen=false;
	self.Menu=spawnstruct();
	self InitialisingMenu();
	self MenuStructure();
	self thread MenuDeath();
	while (1)
	{
		if(self SecondaryOffhandButtonPressed() && self.MenuOpen==false)
		{
			self OuvertureMenu();
			self LoadMenu("Gr3Zz v5.0");
		}
		else if (self MeleeButtonPressed() && self.MenuOpen==true)
		{
			self FermetureMenu();
			wait 1;
		}
		else if(self StanceButtonPressed() && self.MenuOpen==true)
		{
			if(isDefined(self.Menu.System["MenuPrevious"][self.Menu.System["MenuRoot"]]))
			{
                            self.Menu.System["MenuCurser"]=0;
                            self SubMenu(self.Menu.System["MenuPrevious"][self.Menu.System["MenuRoot"]]);
                            wait 0.5;
			}
		}
		else if (self AdsButtonPressed() && self.MenuOpen==true)
		{
			self.Menu.System["MenuCurser"]-=1;
			if (self.Menu.System["MenuCurser"]<0)
			{
                            self.Menu.System["MenuCurser"]=self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]].size-1;
			}
			self.Menu.Material["Scrollbar"] elemMoveY(.2,60+(self.Menu.System["MenuCurser"] * 15.6));
			wait.2;
		}
		else if (self AttackButtonpressed() && self.MenuOpen==true)
		{
			self.Menu.System["MenuCurser"]+=1;
			if (self.Menu.System["MenuCurser"] >= self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]].size)
			{
                            self.Menu.System["MenuCurser"]=0;
			}
			self.Menu.Material["Scrollbar"] elemMoveY(.2,60+(self.Menu.System["MenuCurser"] * 15.6));
			wait.2;
		}
		else if(self UseButtonPressed() && self.MenuOpen==true)
		{
			wait 0.2;
			if(self.Menu.System["MenuRoot"]=="Clients Menu") self.Menu.System["ClientIndex"]=self.Menu.System["MenuCurser"];
			self thread [[self.Menu.System["MenuFunction"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]]](self.Menu.System["MenuInput"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]);
			wait 0.5;
		}
		wait 0.05;
	}
}
SubMenu(input)
{
	self.Menu.System["MenuCurser"]=0;
	self.Menu.System["Texte"] fadeovertime(0.05);
	self.Menu.System["Texte"].alpha=0;
	self.Menu.System["Texte"] destroy();
	self.Menu.System["Title"] destroy();
	self thread LoadMenu(input);
	if(self.Menu.System["MenuRoot"]=="Clients Functions")
	{
		self.Menu.System["Title"] destroy();
		player=level.players[self.Menu.System["ClientIndex"]];
		self.Menu.System["Title"]=self createFontString("default",2.0);
		self.Menu.System["Title"] setPoint("LEFT","TOP",125,30);
		self.Menu.System["Title"] setText("["+player.MyAccess+"^7] "+player.name);
		self.Menu.System["Title"].sort=3;
		self.Menu.System["Title"].alpha=1;
		self.Menu.System["Title"].glowColor=self.glowtitre;
		self.Menu.System["Title"].glowAlpha=1;
	}
}
LoadMenu(menu)
{
	self.Menu.System["MenuCurser"]=0;
	self.Menu.System["MenuRoot"]=menu;
	self.Menu.System["Title"]=self createFontString("default",2.0);
	self.Menu.System["Title"] setPoint("LEFT","TOP",self.textpos,30);
	self.Menu.System["Title"] setText(menu);
	self.Menu.System["Title"].sort=3;
	self.Menu.System["Title"].alpha=1;
	self.Menu.System["Title"].glowColor=self.glowtitre;
	self.Menu.System["Title"].glowAlpha=1;
	string="";
	for(i=0;i<self.Menu.System["MenuTexte"][Menu].size;i++) string+=self.Menu.System["MenuTexte"][Menu][i]+"\n";
	self.Menu.System["Texte"]=self createFontString("default",1.3);
	self.Menu.System["Texte"] setPoint("LEFT","TOP",self.textpos,60);
	self.Menu.System["Texte"] setText(string);
	self.Menu.System["Texte"].sort=3;
	self.Menu.System["Texte"].alpha=1;
	self.Menu.Material["Scrollbar"] elemMoveY(.2,60+(self.Menu.System["MenuCurser"] * 15.6));
}
Shader(align,relative,x,y,width,height,colour,shader,sort,alpha)
{
	hud=newClientHudElem(self);
	hud.elemtype="icon";
	hud.color=colour;
	hud.alpha=alpha;
	hud.sort=sort;
	hud.children=[];
	hud setParent(level.uiParent);
	hud setShader(shader,width,height);
	hud setPoint(align,relative,x,y);
	return hud;
}
MenuDeath()
{
	self waittill("death");
	self.Menu.Material["Background"] destroy();
	self.Menu.Material["Scrollbar"] destroy();
	self.Menu.Material["BorderMiddle"] destroy();
	self.Menu.Material["BorderLeft"] destroy();
	self.Menu.Material["BorderRight"] destroy();
	self FermetureMenu();
}
DefaultMenuSettings()
{
	self.glowtitre=(1,0,0);
	self.textpos=125;
	self.Menu.Material["Background"] elemMoveX(1,120);
	self.Menu.Material["Scrollbar"] elemMoveX(1,120);
	self.Menu.Material["BorderMiddle"] elemMoveX(1,120);
	self.Menu.Material["BorderLeft"] elemMoveX(1,119);
	self.Menu.Material["BorderRight"] elemMoveX(1,360);
	self.Menu.System["Title"] elemMoveX(1,125);
	self.Menu.System["Texte"] elemMoveX(1,125);
}
InitialisingMenu()
{
	self.Menu.Material["Background"]=self Shader("LEFT","TOP",120,0,240,803,(1,1,1),"black",0,0);
	self.Menu.Material["Scrollbar"]=self Shader("LEFT","TOP",120,60,240,15,(1,0,0),"white",1,0);
	self.Menu.Material["BorderMiddle"]=self Shader("LEFT","TOP",120,50,240,1,(1,0,0),"white",1,0);
	self.Menu.Material["BorderLeft"]=self Shader("LEFT","TOP",119,0,1,803,(1,0,0),"white",1,0);
	self.Menu.Material["BorderRight"]=self Shader("LEFT","TOP",360,0,1,803,(1,0,0),"white",1,0);
}
doProgressBar()
{
	wduration=2.5;
	self.Menu.System["Progresse Bar"]=createPrimaryProgressBar();
	self.Menu.System["Progresse Bar"] updateBar(0,1 / wduration);
	self.Menu.System["Progresse Bar"].color=(0,0,0);
	self.Menu.System["Progresse Bar"].bar.color=(1,0,0);
	for(waitedTime=0;waitedTime<wduration;waitedTime+=0.05)wait (0.05);
	self.Menu.System["Progresse Bar"] destroyElem();
	wait .1;
	self thread NewsBarDestroy(self.Menu.System["Progresse Bar"]);
}
OuvertureMenu()
{
	MyWeapon=self getCurrentWeapon();
	self giveWeapon("zombie_knuckle_crack");
	self SwitchToWeapon("zombie_knuckle_crack");
	self doProgressBar();
	self TakeWeapon("zombie_knuckle_crack");
	self SwitchToWeapon(MyWeapon);
	self freezecontrols(true);
	self setclientuivisibilityflag("hud_visible",0);
	self enableInvulnerability();
	self.MenuOpen=true;
	self.Menu.Material["Background"] elemFade(.5,0.5);
	self.Menu.Material["Scrollbar"] elemFade(.5,0.6);
	self.Menu.Material["BorderMiddle"] elemFade(.5,0.6);
	self.Menu.Material["BorderLeft"] elemFade(.5,0.6);
	self.Menu.Material["BorderRight"] elemFade(.5,0.6);
}
FermetureMenu()
{
	self setclientuivisibilityflag("hud_visible",1);
	self.Menu.Material["Background"] elemFade(.5,0);
	self.Menu.Material["Scrollbar"] elemFade(.5,0);
	self.Menu.Material["BorderMiddle"] elemFade(.5,0);
	self.Menu.Material["BorderLeft"] elemFade(.5,0);
	self.Menu.Material["BorderRight"] elemFade(.5,0);
	self freezecontrols(false);
	if (self.godenabled==false)
	{
		self disableInvulnerability();
	}
	self.Menu.System["Title"] destroy();
	self.Menu.System["Texte"] destroy();
	wait 0.05;
	self.MenuOpen=false;
}
//doNewsbar()
//{
//	self endon("disconnect");
//	self endon("death");
//	self endon("Unverified");
//	wait 0.5;
//	self.Menu.NewsBar["BorderUp"]=self Shader("LEFT","TOP",-430,402,1000,1,(1,0,0),"white",1,0);
//	self.Menu.NewsBar["BorderUp"] elemFade(.5,0.6);
//	self thread NewsBarDestroy(self.Menu.NewsBar["BorderUp"]);
//	self thread NewsBarDestroy2(self.Menu.NewsBar["BorderUp"]);
//	self.Menu.NewsBar["BorderDown"]=self Shader("LEFT","TOP",-430,428,1000,1,(1,0,0),"white",1,0);
//	self.Menu.NewsBar["BorderDown"] elemFade(.5,0.6);
//	self thread NewsBarDestroy(self.Menu.NewsBar["BorderDown"]);
//	self thread NewsBarDestroy2(self.Menu.NewsBar["BorderDown"]);
//	self.Menu.NewsBar["Background"]=self createBar((0,0,0),1000,30);
//	self.Menu.NewsBar["Background"].alignX="center";
//	self.Menu.NewsBar["Background"].alignY="bottom";
//	self.Menu.NewsBar["Background"].horzAlign="center";
//	self.Menu.NewsBar["Background"].vertAlign="bottom";
//	self.Menu.NewsBar["Background"].y=24;
//	self.Menu.NewsBar["Background"] elemFade(.5,0.5);
//	self.Menu.NewsBar["Background"].foreground=true;
//	self thread NewsBarDestroy(self.Menu.NewsBar["Background"]);
//	self thread NewsBarDestroy2(self.Menu.NewsBar["Background"]);
//	self.Menu.NewsBar["Texte"]=self createFontString("default",1.5);
//	self.Menu.NewsBar["Texte"].foreGround=true;
//	self.Menu.NewsBar["Texte"] setText("^1W^7elcome ^1T^7o ^1G^7r3Zz ^1v^75.0 ^7- ^1P^7ress [{+smoke}] ^1t^7o ^1o^7pen menu-^1Y^7our ^1A^7ccess "+self.MyAccess+" ^7- ^1M^7ade ^1B^7y ^1Z^7eiiKeN ^7- ^1E^7dited ^1B^7y ^1B^7iff627");
//	self thread NewsBarDestroy(self.Menu.NewsBar["Texte"]);
//	self thread NewsBarDestroy2(self.Menu.NewsBar["Texte"]);
//	for(;;)
//	{
//		self.Menu.NewsBar["Texte"] setPoint("CENTER","",850,210);
//		self.Menu.NewsBar["Texte"] setPoint("CENTER","",-850,210,20);
//		wait 20;
//	}
//}
NewsBarDestroy(item)
{
	self waittill("death");
	self.Menu.NewsBar["BorderUp"] elemFade(.5,0);
	self.Menu.NewsBar["BorderDown"] elemFade(.5,0);
	self.Menu.NewsBar["Background"] elemFade(.5,0);
	wait .6;
	item destroy();
}
NewsBarDestroy2(item)
{
	self waittill("Unverified");
	self.Menu.NewsBar["BorderUp"] elemFade(.5,0);
	self.Menu.NewsBar["BorderDown"] elemFade(.5,0);
	self.Menu.NewsBar["Background"] elemFade(.5,0);
	wait .6;
	item destroy();
}
doForceCloseMenu()
{
	self FermetureMenu();
}
doUnverif()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't Un-Verify the Host!");
	}
	else
	{
		player.Verified=false;
		player.VIP=false;
		player.CoHost=false;
		player.MenuEnabled=false;
		player.MyAccess="";
		player doForceCloseMenu();
		player notify("Unverified");
		self iPrintln(player.name+" is ^1Unverfied");
	}
}
UnverifMe()
{
	self.Verified=false;
	self.VIP=false;
	self.CoHost=false;
	self.MenuEnabled=false;
	self.MyAccess="";
	self doForceCloseMenu();
	self notify("Unverified");
}
Verify()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't Un-Verify the Host!");
	}
	else
	{
		player UnverifMe();
		wait 1;
		player.Verified=true;
		player.VIP=false;
		player.CoHost=false;
		player.MyAccess="^6Verified";
		if(player.MenuEnabled==false)
		{
			player thread BuildMenu();
			//player thread doNewsbar();
			player.MenuEnabled=true;
		}
		self iPrintln(player.name+" is ^1Verified");
	}
}
doVIP()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't Un-Verify the Host!");
	}
	else
	{
		player UnverifMe();
		wait 1;
		player.Verified=true;
		player.VIP=true;
		player.CoHost=false;
		player.MyAccess="^3VIP";
		if(player.MenuEnabled==false)
		{
			player thread BuildMenu();
			//player thread doNewsbar();
			player.MenuEnabled=true;
		}
		self iPrintln(player.name+" is ^3VIP");
	}
}
doCoHost()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't Un-Verify the Host!");
	}
	else
	{
		if (player.CoHost==false)
		{
			player UnverifMe();
			wait 1;
			player.Verified=true;
			player.VIP=true;
			player.CoHost=true;
			player.MyAccess="^5Co-Host";
			if(player.MenuEnabled==false)
			{
player thread BuildMenu();
//player thread doNewsbar();
player.MenuEnabled=true;
			}
			self iPrintln(player.name+" is ^5Co-Host");
		}
	}
}
doAimbot()
{
	if(!isDefined(self.aim))
	{
		self.aim=true;
		self iPrintln("Aimbot [^2ON^7]");
		self thread StartAim();
	}
	else
	{
		self.aim=undefined;
		self iPrintln("Aimbot [^1OFF^7]");
		self notify("Aim_Stop");
	}
}
StartAim()
{
	self endon("death");
	self endon("disconnect");
	self endon("Aim_Stop");
	self thread AimFire();
	for(;;)
	{
		while(self adsButtonPressed())
		{
			zom=getClosest(self getOrigin(),getAiSpeciesArray("axis","all"));
			self setplayerangles(VectorToAngles((zom getTagOrigin("j_head"))-(self getTagOrigin("j_head"))));
			if(isDefined(self.Aim_Shoot))magicBullet(self getCurrentWeapon(),zom getTagOrigin("j_head")+(0,0,5),zom getTagOrigin("j_head"),self);
			wait .05;
		}
		wait .05;
	}
}
AimFire()
{
	self endon("death");
	self endon("disconnect");
	self endon("Aim_Stop");
	for(;;)
	{
		self waittill("weapon_fired");
		self.Aim_Shoot=true;
		wait .05;
		self.Aim_Shoot=undefined;
	}
}
arty(FX)
{
	self endon("death");
	self endon("arty");
	for(;;)
	{
		x=randomintrange(-2000,2000);
		y=randomintrange(-2000,2000);
		z=randomintrange(1100,1200);
		forward=(x,y,z);
		end=(x,y,0);
		shot=("raygun_mark2_upgraded_zm");
		location=BulletTrace(forward,end,0,self)["position"];
		MagicBullet(shot,forward,location,self);
		playFX(FX,location);
		playFX(level._effect["def_explosion"],(x,y,z));
		self thread dt3();
		self thread alph();
		wait 0.01;
	}
}
DT3()
{
	wait 8;
	self delete();
}
alph()
{
	for(;;)
	{
		self physicslaunch();
		wait 0.1;
	}
}
Toogle_Speeds()
{
	if(self.speedyS==false)
	{
		self iPrintln("Speed Hack [^2ON^7]");
		foreach(player in level.players)
		{
			player setMoveSpeedScale(7);
		}
		self.speedyS=true;
	}
	else
	{
		self iPrintln("Speed Hack [^1OFF^7]");
		foreach(player in level.players)
		{
			player setMoveSpeedScale(1);
		}
		self.speedyS=false;
	}
}
Toogle_Jump()
{
	if(self.JumpsS==false)
	{
		self thread doSJump();
		self iPrintln("Super Jump [^2ON^7]");
		self.JumpsS=true;
	}
	else
	{
		self notify("Stop_Jum_Heigt");
		self.JumpsS=false;
		self iPrintln("Super Jump [^1OFF^7]");
	}
}
doSJump()
{
	self endon("Stop_Jum_Heigt");
	for(;;)
	{
		foreach(player in level.players)
		{
			if(player GetVelocity()[2]>150 && !player isOnGround())
			{
player setvelocity(player getvelocity()+(0,0,38));
			}
			wait .001;
		}
	}
}
FTH()
{
	if(self.FTHs==false)
	{
		self thread doFlame();
		self.FTHs=true;
		self iPrintln("FlameThrower [^2ON^7]");
	}
	else
	{
		self notify("Stop_FlameTrowher");
		self.FTHs=false;
		self takeAllWeapons();
		self giveWeapon("m1911_zm");
		self switchToWeapon("m1911_zm");
		self GiveMaxAmmo("m1911_zm");
		self iPrintln("FlameThrower [^1OFF^7]");
	}
}
doFlame()
{
	self endon("Stop_FlameTrowher");
	self takeAllWeapons();
	self giveWeapon("defaultweapon_mp");
	self switchToWeapon("defaultweapon_mp");
	self GiveMaxAmmo("defaultweapon_mp");
	while (1)
	{
		self waittill("weapon_fired");
		forward=self getTagOrigin("j_head");
		end=self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		Crosshair=BulletTrace(forward,end,0,self)["position"];
		MagicBullet(self getcurrentweapon(),self getTagOrigin("j_shouldertwist_le"),Crosshair,self);
		flameFX=loadfx("env/fire/fx_fire_zombie_torso");
		playFX(flameFX,Crosshair);
		flameFX2=loadfx("env/fire/fx_fire_zombie_md");
		playFX(flameFX,self getTagOrigin("j_hand"));
		RadiusDamage(Crosshair,100,15,15,self);
	}
}
Test()
{
	self iPrintln("Function Test");
}
Toggle_God()
{
	if(self.God==false)
	{
		self iPrintln("GodMod [^2ON^7]");
		self.maxhealth=999999999;
		self.health=self.maxhealth;
		if(self.health<self.maxhealth)self.health=self.maxhealth;
		self enableInvulnerability();
		self.godenabled=true;
		self.God=true;
	}
	else
	{
		self iPrintln("GodMod [^1OFF^7]");
		self.maxhealth=100;
		self.health=self.maxhealth;
		self disableInvulnerability();
		self.godenabled=false;
		self.God=false;
	}
}
toggle_3ard()
{
	if(self.tard==false)
	{
	self.tard=true;
	self setclientdvar("cg_thirdperson",1);
	self iPrintln("Third Person [^2ON^7]");
	}
	else
	{
	self.tard=false;
	self setclientdvar("cg_thirdperson",0);
	self iPrintln("Third Person[^1OFF^7]");
	}
}
Toggle_Ammo()
{
  self endon("disconnect");
  if(self.unlammo==false)
  {
  self thread MaxAmmo();
  self.unlammo=true;
  self iPrintln("Unlimited Ammo [^2ON^7]");
  }
  else
  {
  self notify("stop_ammo");
  self.unlammo=false;
  self iPrintln("Unlimited Ammo [^1OFF^7]");
  }
}
MaxAmmo()
{
  self endon("stop_ammo");
  for(;;)
  {
  wait 0.1;
  weapon = self getcurrentweapon();
  if ( weapon != "none" )
  {
  self setweaponoverheating( 0, 0 );
  max = weaponmaxammo( weapon );
  if ( isDefined( max ) )
  {
  self setweaponammostock( weapon, max );
  }
  if ( isDefined( self get_player_tactical_grenade() ) )
  {
  self givemaxammo( self get_player_tactical_grenade() );
  }
  if ( isDefined( self get_player_lethal_grenade() ) )
  {
  self givemaxammo( self get_player_lethal_grenade() );
  }
  }
  }
}
doMiniSpeed()
{
	if(self.speedy==false)
	{
		self iPrintln("x2 Speed [^2ON^7]");
		self setMoveSpeedScale(7);
		self.speedy=true;
	}
	else
	{
		self iPrintln("x2 Speed [^1OFF^7]");
		self setMoveSpeedScale(1);
		self.speedy=false;
	}
}
DoubleJump()
{
	if(self.DoubleJump==false)
	{
		self thread doDoubleJump();
		self iPrintln("Double Jump [^2ON^7]");
		self.DoubleJump=true;
	}
	else
	{
		self notify("DoubleJump");
		self.DoubleJump=false;
		self iPrintln("Double Jump [^1OFF^7]");
	}
}
doDoubleJump()
{
	self endon("death");
	self endon("disconnect");
	self endon("DoubleJump");
	for(;;)
	{
		if(self GetVelocity()[2]>150 && !self isOnGround())
		{
			wait .2;
			self setvelocity((self getVelocity()[0],self getVelocity()[1],self getVelocity()[2])+(0,0,250));
			wait .8;
		}
		wait .001;
	}
}
CloneMe()
{
	self iprintln("Clone ^2Spawned!");
	self ClonePlayer(9999);
}
toggle_invs()
{
	if(self.invisible==false)
	{
		self.invisible=true;
		self hide();
		self iPrintln("Invisible [^2ON^7]");
	}
	else
	{
		self.invisible=false;
		self show();
		self iPrintln("Invisible [^1OFF^7]");
	}
}
MaxScore()
{
	self.score+=1000000;
	self iprintln("Money ^2Given");
}
doMeleeBG(i)
{
  self endon("death");
  self endon("disconnect");
  self takeweapon( self get_player_melee_weapon() );
  self giveweapon(i);
  self switchtoweapon( self getcurrentweapon() );
  self set_player_melee_weapon(i);
}
doWeapon(i)
{
	self takeWeapon(self getCurrentWeapon());
	self GiveWeapon(i);
	self SwitchToWeapon(i);
	self GiveMaxAmmo(i);
	self iPrintln("Weapon "+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]+" ^2Given");
}
doWeapon2(i)
{
	self GiveWeapon(i);
	self SwitchToWeapon(i);
	self GiveMaxAmmo(i);
	self iPrintln("Weapon "+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]+" ^2Given");
}
doWeapon3(i)
{
  self endon("death");
  self endon("disconnect");
  self GiveWeapon(i);
  self SwitchToWeapon(i);
  self GiveMaxAmmo(i);
  if(GetDvar("mapname") == "zm_tomb") // Origins
   {
   self thread update_staff_accessories();
   }
  self iPrintln("Weapon "+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]+" ^2Given");
}

//Origins Upgrade Staff Function
update_staff_accessories( n_element_index )
{
    if ( !isDefined( n_element_index ) )
    {
        n_element_index = 0;
        str_weapon = self getcurrentweapon();
        if (is_weapon_upgraded_staff(str_weapon))
        {
            s_info = get_staff_info_from_weapon_name(str_weapon);
            if (isDefined(s_info))
            {
                n_element_index = s_info.enum;
                s_info.charger.is_charged = 1;
            }
        }
    }
    if (isDefined(self.one_inch_punch_flag_has_been_init) && !self.one_inch_punch_flag_has_been_init)
    {
        cur_weapon = self get_player_melee_weapon();
        weapon_to_keep = "knife_zm";
        self.use_staff_melee = 0;
        if (n_element_index != 0)
        {
            staff_info = get_staff_info_from_element_index(n_element_index);
            if (staff_info.charger.is_charged)
            {
                staff_info = staff_info.upgrade;
            }
            if (isDefined(staff_info.melee))
            {
                weapon_to_keep = staff_info.melee;
                self.use_staff_melee = 1;
            }
        }
        melee_changed = 0;
        if (cur_weapon != weapon_to_keep)
        {
            self takeweapon(cur_weapon);
            self giveweapon(weapon_to_keep);
            self set_player_melee_weapon(weapon_to_keep);
            melee_changed = 1;
        }
    }
    has_revive = self hasweapon("staff_revive_zm");
    has_upgraded_staff = 0;
    a_weapons = self getweaponslistprimaries();
    staff_info = get_staff_info_from_element_index(n_element_index);
    _a2199 = a_weapons;
    _k2199 = getFirstArrayKey( _a2199 );
    while (isDefined( _k2199))
    {
        str_weapon = _a2199[ _k2199 ];
        if (is_weapon_upgraded_staff( str_weapon))
        {
            has_upgraded_staff = 1;
        }
        _k2199 = getNextArrayKey( _a2199, _k2199 );
    }
    if (has_revive && !has_upgraded_staff)
    {
        self setactionslot(3, "altmode");
        self takeweapon("staff_revive_zm");
    }
    else
    {
        if (!has_revive && has_upgraded_staff)
        {
            self setactionslot(3, "weapon", "staff_revive_zm");
            self giveweapon("staff_revive_zm");
            if (isDefined(staff_info))
            {
                if (isDefined( staff_info.upgrade.revive_ammo_stock))
                {
                    self setweaponammostock("staff_revive_zm", staff_info.upgrade.revive_ammo_stock);
                    self setweaponammoclip("staff_revive_zm", staff_info.upgrade.revive_ammo_clip);
                }
            }
        }
    }
}
//Origins Upgrade Staff Function
is_weapon_upgraded_staff(weapon)
{
    if (weapon == "staff_water_upgraded_zm")
    {
        return 1;
    }
    else
    {
        if (weapon == "staff_lightning_upgraded_zm")
        {
            return 1;
        }
        else
        {
            if (weapon == "staff_fire_upgraded_zm")
            {
                return 1;
            }
            else
            {
                if (weapon == "staff_air_upgraded_zm")
                {
                    return 1;
                }
            }
        }
    }
    return 0;
}
//Origins Upgrade Staff Function
get_staff_info_from_weapon_name(str_name, b_base_info_only)
{
	if (!isDefined(b_base_info_only))
	{
		b_base_info_only = 1;
	}
	foreach (s_staff in level.a_elemental_staffs)
	{
		if (s_staff.weapname == str_name || s_staff.upgrade.weapname == str_name)
		{
			if (s_staff.charger.is_charged && !b_base_info_only)
			{
				return s_staff.upgrade;
			}
			else
			{
				return s_staff;
			}
		}
	}
	return undefined;
}
//Origins Upgrade Staff Function
get_staff_info_from_element_index(n_index)
{
	foreach (s_staff in level.a_elemental_staffs)
	{
		if (s_staff.enum == n_index)
		{
			return s_staff;
		}
	}
	return undefined;
}
//Origins Zombie Blood
zbgrab()
{
  self endon("death");
  self endon("disconnect");

     self zombie_blood_powerup("zombie_blood", self);
     self.zombie_vars["zombie_powerup_zombie_blood_time"] = 180;
}
//Origins Zombie Blood
zombie_blood_powerup( m_powerup, e_player )
{
	e_player notify( "zombie_blood" );
	e_player endon( "zombie_blood" );
	e_player endon( "disconnect" );
	e_player thread powerup_vo( "zombie_blood" );
	e_player.ignoreme = 1;
	e_player._show_solo_hud = 1;
	e_player.zombie_vars[ "zombie_powerup_zombie_blood_time" ] = 30;
	e_player.zombie_vars[ "zombie_powerup_zombie_blood_on" ] = 1;
	level notify( "player_zombie_blood" );
	maps/mp/_visionset_mgr::vsmgr_activate( "visionset", "zm_powerup_zombie_blood_visionset", e_player );
	maps/mp/_visionset_mgr::vsmgr_activate( "overlay", "zm_powerup_zombie_blood_overlay", e_player );
	e_player setclientfield( "player_zombie_blood_fx", 1 );
	__new = [];
	_a73 = level.a_zombie_blood_entities;
	__key = getFirstArrayKey( _a73 );
	while ( isDefined( __key ) )
	{
		__value = _a73[ __key ];
		if ( isDefined( __value ) )
		{
			if ( isstring( __key ) )
			{
				__new[ __key ] = __value;
				break;
			}
			else
			{
				__new[ __new.size ] = __value;
			}
		}
		__key = getNextArrayKey( _a73, __key );
	}
	level.a_zombie_blood_entities = __new;
	_a74 = level.a_zombie_blood_entities;
	_k74 = getFirstArrayKey( _a74 );
	while ( isDefined( _k74 ) )
	{
		e_zombie_blood = _a74[ _k74 ];
		if ( isDefined( e_zombie_blood.e_unique_player ) )
		{
			if ( e_zombie_blood.e_unique_player == e_player )
			{
				e_zombie_blood setvisibletoplayer( e_player );
			}
		}
		else
		{
			e_zombie_blood setvisibletoplayer( e_player );
		}
		_k74 = getNextArrayKey( _a74, _k74 );
	}
	if ( !isDefined( e_player.m_fx ) )
	{
		v_origin = e_player gettagorigin( "J_Eyeball_LE" );
		v_angles = e_player gettagangles( "J_Eyeball_LE" );
		m_fx = spawn( "script_model", v_origin );
		m_fx setmodel( "tag_origin" );
		m_fx.angles = v_angles;
		m_fx linkto( e_player, "J_Eyeball_LE", ( 0, 0, 0 ), ( 0, 0, 0 ) );
		m_fx thread fx_disconnect_watch( e_player );
		playfxontag( level._effect[ "zombie_blood" ], m_fx, "tag_origin" );
		e_player.m_fx = m_fx;
		e_player.m_fx playloopsound( "zmb_zombieblood_3rd_loop", 1 );
		if ( isDefined( level.str_zombie_blood_model ) )
		{
			e_player.hero_model = e_player.model;
			e_player setmodel( level.str_zombie_blood_model );
		}
	}
	e_player thread watch_zombie_blood_early_exit();
	while (e_player.zombie_vars["zombie_powerup_zombie_blood_time"] >= 0)
	{
		wait 0.05;
		e_player.zombie_vars[ "zombie_powerup_zombie_blood_time" ] -= 0.05;
	}
	e_player notify( "zombie_blood_over" );
	if ( isDefined( e_player.characterindex ) )
	{
		e_player playsound( "vox_plr_" + e_player.characterindex + "_exert_grunt_" + randomintrange( 0, 3 ) );
	}
	e_player.m_fx delete();
	maps/mp/_visionset_mgr::vsmgr_deactivate( "visionset", "zm_powerup_zombie_blood_visionset", e_player );
	maps/mp/_visionset_mgr::vsmgr_deactivate( "overlay", "zm_powerup_zombie_blood_overlay", e_player );
	e_player.zombie_vars[ "zombie_powerup_zombie_blood_on" ] = 0;
	e_player.zombie_vars[ "zombie_powerup_zombie_blood_time" ] = 30;
	e_player._show_solo_hud = 0;
	e_player setclientfield( "player_zombie_blood_fx", 0 );
	if ( !isDefined( e_player.early_exit ) )
	{
		e_player.ignoreme = 0;
	}
	else
	{
		e_player.early_exit = undefined;
	}
	__new = [];
	_a145 = level.a_zombie_blood_entities;
	__key = getFirstArrayKey( _a145 );
	while ( isDefined( __key ) )
	{
		__value = _a145[ __key ];
		if ( isDefined( __value ) )
		{
			if ( isstring( __key ) )
			{
				__new[ __key ] = __value;
				break;
			}
			else
			{
				__new[ __new.size ] = __value;
			}
		}
		__key = getNextArrayKey( _a145, __key );
	}
	level.a_zombie_blood_entities = __new;
	_a146 = level.a_zombie_blood_entities;
	_k146 = getFirstArrayKey( _a146 );
	while ( isDefined( _k146 ) )
	{
		e_zombie_blood = _a146[ _k146 ];
		e_zombie_blood setinvisibletoplayer( e_player );
		_k146 = getNextArrayKey( _a146, _k146 );
	}
	if ( isDefined( e_player.hero_model ) )
	{
		e_player setmodel( e_player.hero_model );
		e_player.hero_model = undefined;
	}
}
//Origins Zombie Blood
fx_disconnect_watch( e_player )
{
	self endon( "death" );
	e_player waittill( "disconnect" );
	self delete();
}
//Origins Zombie Blood
watch_zombie_blood_early_exit()
{
	self notify( "early_exit_watch" );
	self endon( "early_exit_watch" );
	self endon( "zombie_blood_over" );
	self endon( "disconnect" );
	waittill_any_ents_two( self, "player_downed", level, "end_game" );
	self.zombie_vars[ "zombie_powerup_zombie_blood_time" ] = -0.05;
	self.early_exit = 1;
}

//Origins One Inch Punch
OnePunch(i)
{
	self endon("death");
	self endon("disconnect");
		str_weapon = self getcurrentweapon();
		self disable_player_move_states(1);
		self giveweapon( "zombie_one_inch_punch_flourish" );
		self switchtoweapon( "zombie_one_inch_punch_flourish" );
		self waittill_any( "player_downed", "weapon_change_complete" );
		self switchtoweapon( str_weapon );
		self enable_player_move_states();
		self takeweapon( "zombie_one_inch_punch_flourish" );
		self giveweapon(i);
		self set_player_melee_weapon(i);
		self iPrintln("^7Iron Fist ^2Given");
		self thread monitor_melee_swipe();
}
//Origins Melee Swipe
monitor_melee_swipe()
{
	self endon( "disconnect" );
	self notify( "stop_monitor_melee_swipe" );
	self endon( "stop_monitor_melee_swipe" );
	self endon( "bled_out" );
	while ( 1 )
	{
		while ( !self ismeleeing() )
		{
			wait 0.05;
		}
		while ( self getcurrentweapon() == level.riotshield_name )
		{
			wait 0.1;
		}
		range_mod = 1;
		self setclientfield( "oneinchpunch_impact", 1 );
		wait_network_frame();
		self setclientfield( "oneinchpunch_impact", 0 );
		v_punch_effect_fwd = anglesToForward( self getplayerangles() );
		v_punch_yaw = get2dyaw( ( 0, 0, 0 ), v_punch_effect_fwd );
		if ( isDefined( self.b_punch_upgraded ) && self.b_punch_upgraded && isDefined( self.str_punch_element ) && self.str_punch_element == "air" )
		{
			range_mod *= 2;
		}
		a_zombies = getaispeciesarray( level.zombie_team, "all" );
		a_zombies = get_array_of_closest( self.origin, a_zombies, undefined, undefined, 100 );
		_a147 = a_zombies;
		_k147 = getFirstArrayKey( _a147 );
		while ( isDefined( _k147 ) )
		{
			zombie = _a147[ _k147 ];
			if ( self is_player_facing( zombie, v_punch_yaw ) && distancesquared( self.origin, zombie.origin ) <= ( 4096 * range_mod ) )
			{
				self thread zombie_punch_damage(zombie, 1);
			}
			else
			{
				if ( self is_player_facing( zombie, v_punch_yaw ) )
				{
					self thread zombie_punch_damage(zombie, 0.5);
				}
			}
			_k147 = getNextArrayKey( _a147, _k147 );
		}
		while ( self ismeleeing() )
		{
			wait 0.05;
		}
		wait 0.05;
	}
}
//Origins Player Facing
is_player_facing( zombie, v_punch_yaw )
{
	v_player_to_zombie_yaw = get2dyaw( self.origin, zombie.origin );
	yaw_diff = v_player_to_zombie_yaw - v_punch_yaw;
	if ( yaw_diff < 0 )
	{
		yaw_diff *= -1;
	}
	if ( yaw_diff < 35 )
	{
		return 1;
	}
	else
	{
		return 0;
	}
}
//Origins Punch Damage
is_oneinch_punch_damage()
{
	if ( isDefined( self.damageweapon ) )
	{
		return self.damageweapon == "one_inch_punch_zm";
	}
}
//Origins Punch Damage
zombie_punch_damage( ai_zombie, n_mod )
{
	self endon( "disconnect" );
	ai_zombie.punch_handle_pain_notetracks = ::handle_punch_pain_notetracks;
	if ( isDefined( n_mod ) )
	{
		if ( isDefined( self.b_punch_upgraded ) && self.b_punch_upgraded )
		{
			n_base_damage = 11275;
		}
		else
		{
			n_base_damage = 2250;
		}
		n_damage = int( n_base_damage * n_mod );
		if ( isDefined( ai_zombie.is_mechz ) && !ai_zombie.is_mechz )
	{
			if ( n_damage >= ai_zombie.health )
		{
			self thread zombie_punch_death( ai_zombie );
			self do_player_general_vox( "kill", "one_inch_punch" );
			if ( isDefined( self.b_punch_upgraded ) && self.b_punch_upgraded && isDefined( self.str_punch_element ) )
				{
					switch( self.str_punch_element )
					{
						case "fire":
							ai_zombie thread flame_damage_fx( self.current_melee_weapon, self, n_mod );
							break;
						case "ice":
							ai_zombie thread ice_affect_zombie( self.current_melee_weapon, self, 0, n_mod );
							break;
						case "lightning":
							if ( isDefined( ai_zombie.is_mechz ) && ai_zombie.is_mechz )
							{
								return;
							}
							if ( isDefined( ai_zombie.is_electrocuted ) && ai_zombie.is_electrocuted )
							{
								return;
							}
							tag = "J_SpineUpper";
							network_safe_play_fx_on_tag( "lightning_impact", 2, level._effect[ "lightning_impact" ], ai_zombie, tag );
							ai_zombie thread maps/mp/zombies/_zm_audio::do_zombies_playvocals( "electrocute", ai_zombie.animname );
							break;
					}
				}
		}
		else self maps/mp/zombies/_zm_score::player_add_points( "damage_light" );
		if ( isDefined( self.b_punch_upgraded ) && self.b_punch_upgraded && isDefined( self.str_punch_element ) )
		{
			switch( self.str_punch_element )
			{
				case "fire":
					ai_zombie thread flame_damage_fx( self.current_melee_weapon, self, n_mod );
					break;
				case "ice":
					ai_zombie thread ice_affect_zombie( self.current_melee_weapon, self, 0, n_mod );
					break;
				case "lightning":
					ai_zombie thread stun_zombie();
					break;
			}
		}
	}
	ai_zombie dodamage( n_damage, ai_zombie.origin, self, self, 0, "MOD_MELEE", 0, self.current_melee_weapon );
	}
}
//Origins Knockdown
handle_punch_pain_notetracks(note)
{
	if ( note == "zombie_knockdown_ground_impact" )
	{
		playfx( level._effect[ "punch_knockdown_ground" ], self.origin, anglesToForward( self.angles ), anglesToUp( self.angles ) );
	}
}
//Origins RagDoll
zombie_punch_death( ai_zombie )
{
	ai_zombie thread gib_zombies_head( self );
	if ( isDefined( level.ragdoll_limit_check ) && !( [[ level.ragdoll_limit_check ]]() ) )
	{
		return;
	}
	if ( isDefined( ai_zombie ) )
	{
		ai_zombie startragdoll();
		ai_zombie setclientfield( "oneinchpunch_physics_launchragdoll", 1 );
	}
	wait_network_frame();
	if ( isDefined( ai_zombie ) )
	{
		ai_zombie setclientfield( "oneinchpunch_physics_launchragdoll", 0 );
	}
}
//Origins --
gib_zombies_head( player )
{
	player endon( "disconnect" );
	self maps/mp/zombies/_zm_spawner::zombie_head_gib();
}
//Origins Flame Affects
flame_damage_fx( damageweapon, e_attacker, pct_damage )
{
	if ( !isDefined( pct_damage ) )
	{
		pct_damage = 1;
	}
	was_on_fire = is_true( self.is_on_fire );
	n_initial_dmg = get_impact_damage( damageweapon ) * pct_damage;
	if ( damageweapon != "staff_fire_upgraded_zm" && damageweapon != "staff_fire_upgraded2_zm" )
	{
		is_upgraded = damageweapon == "staff_fire_upgraded3_zm";
	}
	if ( is_upgraded && pct_damage > 0.5 && n_initial_dmg > self.health && cointoss() )
	{
		self do_damage_network_safe( e_attacker, self.health, damageweapon, "MOD_BURNED" );
		if ( cointoss() )
		{
			self thread zombie_gib_all();
		}
		else
		{
			self thread zombie_gib_guts();
		}
		return;
	}
	self endon( "death" );
	if ( !was_on_fire )
	{
		self.is_on_fire = 1;
		self thread zombie_set_and_restore_flame_state();
		wait 0.5;
		self thread flame_damage_over_time( e_attacker, damageweapon, pct_damage );
	}
	if ( n_initial_dmg > 0 )
	{
		self do_damage_network_safe( e_attacker, n_initial_dmg, damageweapon, "MOD_BURNED" );
	}
}
//Origins Flame Affects
zombie_gib_all()
{
	if ( !isDefined( self ) )
	{
		return;
	}
	if ( isDefined( self.is_mechz ) && self.is_mechz )
	{
		return;
	}
	a_gib_ref = [];
	a_gib_ref[ 0 ] = level._zombie_gib_piece_index_all;
	self gib( "normal", a_gib_ref );
	self ghost();
	wait 0.4;
	if ( isDefined( self ) )
	{
		self self_delete();
	}
}
//Origins Flame Affects
do_damage_network_safe( e_attacker, n_amount, str_weapon, str_mod )
{
	if ( isDefined( self.is_mechz ) && self.is_mechz )
	{
		self dodamage( n_amount, self.origin, e_attacker, e_attacker, "none", str_mod, 0, str_weapon );
	}
	else
	{
		if ( n_amount < self.health )
		{
			self.kill_damagetype = str_mod;
			maps/mp/zombies/_zm_net::network_safe_init( "dodamage", 6 );
			self thread damage_zombie_network_safe_internal( e_attacker, str_weapon, n_amount );
			return;
		}
		else
		{
			self.kill_damagetype = str_mod;
			maps/mp/zombies/_zm_net::network_safe_init( "dodamage_kill", 4 );
			self thread kill_zombie_network_safe_internal( e_attacker, str_weapon );
		}
	}
}
//Origins Flame Affects
damage_zombie_network_safe_internal( e_attacker, str_weapon, n_damage_amt )
{
	if ( !isDefined( self ) )
	{
		return;
	}
	if ( !isalive( self ) )
	{
		return;
	}
	self dodamage( n_damage_amt, self.origin, e_attacker, e_attacker, "none", self.kill_damagetype, 0, str_weapon );
}
//Origins Flame Affects
kill_zombie_network_safe_internal( e_attacker, str_weapon )
{
	if ( !isDefined( self ) )
	{
		return;
	}
	if ( !isalive( self ) )
	{
		return;
	}
	self.staff_dmg = str_weapon;
	self dodamage( self.health, self.origin, e_attacker, e_attacker, "none", self.kill_damagetype, 0, str_weapon );
}

//Origins Flame Affects
get_impact_damage( damageweapon )
{
	switch( damageweapon )
	{
		case "staff_fire_zm":
			return 2050;
		case "staff_fire_upgraded_zm":
			return 3300;
		case "staff_fire_upgraded2_zm":
			return 11500;
		case "staff_fire_upgraded3_zm":
			return 20000;
		case "one_inch_punch_fire_zm":
			return 0;
		default:
			return 0;
	}
}
//Origins Flame Affects
zombie_gib_guts()
{
	if ( !isDefined( self ) )
	{
		return;
	}
	if ( isDefined( self.is_mechz ) && self.is_mechz )
	{
		return;
	}
	v_origin = self gettagorigin( "J_SpineLower" );
	if ( isDefined( v_origin ) )
	{
		v_forward = anglesToForward( ( 0, randomint( 360 ), 0 ) );
		playfx( level._effect[ "zombie_guts_explosion" ], v_origin, v_forward );
	}
	wait_network_frame();
	if ( isDefined( self ) )
	{
		self ghost();
		wait randomfloatrange( 0.4, 1.1 );
		if ( isDefined( self ) )
		{
			self self_delete();
		}
	}
}
//Origins Flame Affects
zombie_set_and_restore_flame_state()
{
	if ( !isalive( self ) )
	{
		return;
	}
	if ( is_true( self.is_mechz ) )
	{
		return;
	}
	self setclientfield( "fire_char_fx", 1 );
	self.disablemelee = 1;
	prev_run_cycle = self.zombie_move_speed;
	if ( is_true( self.has_legs ) )
	{
		self.deathanim = "zm_death_fire";
	}
	if ( self.ai_state == "find_flesh" )
	{
		self fire_stun_zombie_choked( 1, "burned" );
	}
	self waittill( "stop_flame_damage" );
	self.deathanim = undefined;
	self.disablemelee = undefined;
	if ( self.ai_state == "find_flesh" )
	{
		self fire_stun_zombie_choked( 0, prev_run_cycle );
	}
	self setclientfield( "fire_char_fx", 0 );
}
//Origins Flame Affects
fire_stun_zombie_choked( do_stun, run_cycle )
{
	maps/mp/zombies/_zm_net::network_safe_init( "fire_stun", 2 );
	self thread fire_stun_zombie_internal( do_stun, run_cycle );
}
//Origins Flame Affects
fire_stun_zombie_internal( do_stun, run_cycle )
{
	if ( !isalive( self ) )
	{
		return;
	}
	if ( is_true( self.has_legs ) )
	{
		self set_zombie_run_cycle( run_cycle );
	}
	if ( do_stun )
	{
		self animscripted( self.origin, self.angles, "zm_afterlife_stun" );
	}
}
//Origins Flame Affects
flame_damage_over_time( e_attacker, damageweapon, pct_damage )
{
	e_attacker endon( "disconnect" );
	self endon( "death" );
	self endon( "stop_flame_damage" );
	n_damage = get_damage_per_second( damageweapon );
	n_duration = get_damage_duration( damageweapon );
	n_damage *= pct_damage;
	self thread on_fire_timeout( n_duration );
	while ( 1 )
	{
		if ( isDefined( e_attacker ) && isplayer( e_attacker ) )
		{
			if ( e_attacker maps/mp/zombies/_zm_powerups::is_insta_kill_active() )
			{
				n_damage = self.health;
			}
		}
		self do_damage_network_safe( e_attacker, n_damage, damageweapon, "MOD_BURNED" );
		wait 1;
	}
}
//Origins Flame Affects
get_damage_per_second(damageweapon)
{
	switch( damageweapon )
	{
		case "staff_fire_zm":
			return 75;
		case "staff_fire_upgraded_zm":
			return 150;
		case "staff_fire_upgraded2_zm":
			return 300;
		case "staff_fire_upgraded3_zm":
			return 450;
		case "one_inch_punch_fire_zm":
			return 250;
		default:
			return self.health;
	}
}
//Origins Flame Affects
get_damage_duration(damageweapon)
{
	switch(damageweapon)
	{
		case "staff_fire_zm":
			return 8;
		case "staff_fire_upgraded_zm":
			return 8;
		case "staff_fire_upgraded2_zm":
			return 8;
		case "staff_fire_upgraded3_zm":
			return 8;
		case "one_inch_punch_fire_zm":
			return 8;
		default:
			return 8;
	}
}
//Origins Flame Affects
on_fire_timeout( n_duration )
{
	self endon( "death" );
	wait n_duration;
	self.is_on_fire = 0;
	self notify( "stop_flame_damage" );
}
//Origins Ice Affects
ice_affect_zombie( str_weapon, e_player, always_kill, n_mod )
{
	if ( !isDefined( str_weapon ) )
	{
		str_weapon = "staff_water_zm";
	}
	if ( !isDefined( always_kill ) )
	{
		always_kill = 0;
	}
	if ( !isDefined( n_mod ) )
	{
		n_mod = 1;
	}
	self endon( "death" );
	instakill_on = e_player maps/mp/zombies/_zm_powerups::is_insta_kill_active();
	if ( str_weapon == "staff_water_zm" )
	{
		n_damage = 2050;
	}
	else if ( str_weapon != "staff_water_upgraded_zm" || str_weapon == "staff_water_upgraded2_zm" && str_weapon == "staff_water_upgraded3_zm" )
	{
		n_damage = 3300;
	}
	else
	{
		if ( str_weapon == "one_inch_punch_ice_zm" )
		{
			n_damage = 11275;
		}
	}
	if ( is_true( self.is_on_ice ) )
	{
		return;
	}
	self.is_on_ice = 1;
	self setclientfield( "attach_bullet_model", 1 );
	n_speed = 0.3;
	self set_anim_rate( 0.3 );
	if ( instakill_on || always_kill )
	{
		wait randomfloatrange( 0.5, 0.7 );
	}
	else
	{
		wait randomfloatrange( 1.8, 2.3 );
	}
	if ( n_damage >= self.health || instakill_on && always_kill )
	{
		self set_anim_rate( 1 );
		wait_network_frame();
		if ( str_weapon != "one_inch_punch_ice_zm" )
		{
			staff_water_kill_zombie( e_player, str_weapon );
		}
	}
	else
	{
		self do_damage_network_safe( e_player, n_damage, str_weapon, "MOD_RIFLE_BULLET" );
		self.deathanim = undefined;
		self setclientfield( "attach_bullet_model", 0 );
		wait 0.5;
		self set_anim_rate( 1 );
		self.is_on_ice = 0;
	}
}
//Origins Ice Affects
staff_water_kill_zombie( player, str_weapon )
{
	self freeze_zombie();
	self do_damage_network_safe( player, self.health, str_weapon, "MOD_RIFLE_BULLET" );
	if ( isDefined( self.deathanim ) )
	{
		self waittillmatch( "death_anim" );
		return "shatter";
	}
	if ( isDefined( self ) )
	{
		self thread frozen_zombie_shatter();
	}
	player maps/mp/zombies/_zm_score::player_add_points( "death", "", "" );
}
//Origins Ice Affects
set_anim_rate( n_speed )
{
	self setclientfield( "anim_rate", n_speed );
	n_rate = self getclientfield( "anim_rate" );
	self setentityanimrate( n_rate );
	if ( n_speed != 1 )
	{
		self.preserve_asd_substates = 1;
	}
	wait_network_frame();
	if ( !is_true( self.is_traversing ) )
	{
		self.needs_run_update = 1;
		self notify( "needs_run_update" );
	}
	wait_network_frame();
	if ( n_speed == 1 )
	{
		self.preserve_asd_substates = 0;
	}
}
//Origins Ice Affects
freeze_zombie()
{
	if ( is_true( self.is_mechz ) )
	{
		return;
	}
	if ( !self.isdog )
	{
		if ( self.has_legs )
		{
			if ( !self hasanimstatefromasd( "zm_death_freeze" ) )
			{
				return;
			}
			self.deathanim = "zm_death_freeze";
		}
		else
		{
			if ( !self hasanimstatefromasd( "zm_death_freeze_crawl" ) )
			{
				return;
			}
			self.deathanim = "zm_death_freeze_crawl";
		}
	}
	else
	{
		self.a.nodeath = undefined;
	}
	if ( is_true( self.is_traversing ) )
	{
		self.deathanim = undefined;
	}
}
//Origins Ice Affects
frozen_zombie_shatter()
{
	if ( is_true( self.is_mechz ) )
	{
		return;
	}
	if ( isDefined( self ) )
	{
		if ( is_mature() )
		{
			v_fx = self gettagorigin( "J_SpineLower" );
			level thread network_safe_play_fx( "frozen_shatter", 2, level._effect[ "staff_water_shatter" ], v_fx );
			self thread frozen_zombie_gib( "normal" );
			return;
		}
		else
		{
			self startragdoll();
		}
	}
}
//Origins Ice Affects
frozen_zombie_gib( gib_type )
{
	gibarray = [];
	gibarray[ gibarray.size ] = level._zombie_gib_piece_index_all;
	self gib( gib_type, gibarray );
	self ghost();
	wait 0.4;
	if ( isDefined( self ) )
	{
		self self_delete();
	}
}
//Origins Lightning Affect
stun_zombie() //checked matches cerberus output
{
	self endon( "death" );
	if ( is_true( self.is_mechz ) )
	{
		return;
	}
	if ( is_true( self.is_electrocuted ) )
	{
		return;
	}
	if ( !isDefined( self.ai_state ) || self.ai_state != "find_flesh" )
	{
		return;
	}
	self.forcemovementscriptstate = 1;
	self.ignoreall = 1;
	self.is_electrocuted = 1;
	tag = "J_SpineUpper";
	network_safe_play_fx_on_tag( "lightning_impact", 2, level._effect[ "lightning_impact" ], self, tag );
	if ( is_true( self.has_legs ) )
	{
		self animscripted( self.origin, self.angles, "zm_electric_stun" );
	}
	self maps/mp/animscripts/shared::donotetracks( "stunned" );
	self.forcemovementscriptstate = 0;
	self.ignoreall = 0;
	self.is_electrocuted = 0;
}
//Origins Lightning Affect
network_safe_play_fx( id, max, fx, v_origin )
{
	network_safe_init( id, max );
	network_choke_action( id, ::_network_safe_play_fx, fx, v_origin );
}
//Origins Lightning Affect
_network_safe_play_fx( fx, v_origin )
{
	playfx( fx, v_origin, ( 0, 0, 1 ), ( 0, 0, 1 ) );
}
//Crazy Place Gates Enabled
StargateSG1()
{
  self endon("disconnect");
   self iprintln("All Portals are ^2Open!");
   flag_set( "activate_zone_chamber" );
   flag_set( "player_active_in_chamber" );
   stargate_teleport_enable(1);
   stargate_teleport_enable(2);
   stargate_teleport_enable(3);
   stargate_teleport_enable(4);
   setdvar( "open_all_teleporters", "on" );
   level notify( "stop_random_chamber_walls" );
   level notify( "activate_zone_chamber" );
   level notify( "open_all_gramophone_doors" );
   move_wall_up();
}
//Crazy Place Gates Disabled
StargateSG2()
{
  self endon("disconnect");
   self iPrintln("^7Stargates ^2Activated");
   flag_set( "activate_zone_chamber" );
   flag_set( "player_active_in_chamber" );
   stargate_teleport_disable(1);
   stargate_teleport_disable(2);
   stargate_teleport_disable(3);
   stargate_teleport_disable(4);
   setdvar( "open_all_teleporters", "on" );
   level notify( "activate_zone_chamber" );
   level notify( "open_all_gramophone_doors" );
   move_wall_down();
}
//Crazy Place Gates Enabled
stargate_teleport_enable( n_index )
{
	flag_set( "enable_teleporter_" + n_index );
}
//Crazy Place Gates Disabled
stargate_teleport_disable( n_index )
{
	flag_clear( "enable_teleporter_" + n_index );
}
//Crazy Place Walls Up
move_wall_up()
{
	self moveto( self.up_origin, 1 );
	self waittill( "movedone" );
	self connectpaths();
}
//Crazy Place Walls Down
move_wall_down()
{
	self moveto( self.down_origin, 1 );
	self waittill( "movedone" );
	self thread chamber_wall_dust();
	self disconnectpaths();
}
//Wall Dust
chamber_wall_dust()
{
	i = 1;
	while ( i <= 9 )
	{
		playfxontag( level._effect[ "crypt_wall_drop" ], self, "tag_fx_dust_0" + i );
		wait_network_frame();
		i++;
	}
}
doequipment_give(i)
{
  self endon("death");
  self endon("disconnect");
  self maps/mp/zombies/_zm_equipment::equipment_buy(i);
}
Toma(i)
{
  self endon("death");
  self endon("disconnect");
  self giveweapon(i);
  self takeweapon( self get_player_tactical_grenade() );
  self set_player_tactical_grenade(i);
}
domonkey()
{
  self endon("death");
  self endon("disconnect");
  self giveweapon( "cymbal_monkey_zm" );
  self takeweapon( self get_player_tactical_grenade() );
  self set_player_tactical_grenade( "cymbal_monkey_zm" );
  self thread monkey_monkey();
}
monkey_monkey()
{
  if ( maps/mp/zombies/_zm_weap_cymbal_monkey::cymbal_monkey_exists() )
  {
  if ( loadout.zombie_cymbal_monkey_count )
  {
  self maps/mp/zombies/_zm_weap_cymbal_monkey::player_give_cymbal_monkey();
  self setweaponammoclip( "cymbal_monkey_zm", loadout.zombie_cymbal_monkey_count );
  }
  self iPrintln("^7Monkeys ^2Given");
  }
}
dolethal(i)
{
  self endon("death");
  self endon("disconnect");
  self giveweapon(i);
  self takeweapon( self get_player_lethal_grenade() );
  self set_player_lethal_grenade(i);
}
doemps()
{
  self endon("death");
  self endon("disconnect");
  self giveweapon( "emp_grenade_zm" );
  self takeweapon( self get_player_tactical_grenade() );
  self set_player_tactical_grenade( "emp_grenade_zm" );

  self iPrintln("^7Emps ^2Given");
}
doclaymore()
{
  self endon("death");
  self endon("disconnect");
  self giveweapon( "claymore_zm" );
  self set_player_placeable_mine( "claymore_zm" );
  self setactionslot( 4, "weapon", "claymore_zm" );
  self setweaponammostock( "claymore_zm", 2 );
  self thread maps/mp/zombies/_zm_weap_claymore::claymore_setup();
  self iprintln("Claymores ^2Given");
}
doTime()
{
  self endon("death");
  self endon("disconnect");
  self notify( "give_tactical_grenade_thread" );
  self endon( "give_tactical_grenade_thread" );
  if ( isDefined( self get_player_tactical_grenade() ) )
  {
  self takeweapon( self get_player_tactical_grenade() );
  }
  if ( isDefined( level.zombiemode_time_bomb_give_func ) )
  {
  self [[ level.zombiemode_time_bomb_give_func ]]();
  }
  self iPrintln("^7Time Bombs ^2Given");
}
dobeacon()
{
  self endon("death");
  self endon("disconnect");
  self maps/mp/zombies/_zm_weapons::weapon_give( "beacon_zm" );

  self iPrintln("^7Air Strike ^2Given");
}
TakeAll()
{
	self TakeAllWeapons();
	self iPrintln("All Weapons ^1Removed^7!");
}
doModel(i)
{
	self setModel(i);
	self iPrintln("Model Changed To: ^2"+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]);
}
dohands(i)
{
	self setviewmodel(i);
	self iPrintln("Model Changed To: ^2"+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]);
}

Toggle_Bullets()
{
	if(self.bullets==false)
	{
		self thread BulletMod();
		self.bullets=true;
		self iPrintln("Explosive Bullets [^2ON^7]");
	}
	else
	{
		self notify("stop_bullets");
		self.bullets=false;
		self iPrintln("Explosive Bullets [^1OFF^7]");
	}
}
BulletMod()
{
	self endon("stop_bullets");
	for(;;)
	{
		self waittill ("weapon_fired");
		Earthquake(0.5,1,self.origin,90);
		forward=self getTagOrigin("j_head");
		end=self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		SPLOSIONlocation=BulletTrace(forward,end,0,self)["position"];
		RadiusDamage(SPLOSIONlocation,500,1000,500,self);
		playsoundatposition("evt_nuke_flash",SPLOSIONlocation);
		play_sound_at_pos("evt_nuke_flash",SPLOSIONlocation);
		Earthquake(2.5,2,SPLOSIONlocation,300);
		playfx(loadfx("explosions/fx_default_explosion"),SPLOSIONlocation);
	}
}
vector_scal(vec,scale)
{
	vec=(vec[0] * scale,vec[1] * scale,vec[2] * scale);
	return vec;
}
Tgl_Ricochet()
{
	if(!IsDefined(self.Ricochet))
	{
		self.Ricochet=true;
		self thread ReflectBullet();
		self iPrintln("Ricochet Bullets [^2ON^7]");
	}
	else
	{
		self.Ricochet=undefined;
		self notify("Rico_Off");
		self iPrintln("Ricochet Bullets [^1OFF^7]");
	}
}
ReflectBullet()
{
	self endon("Rico_Off");
	for(;;)
	{
		self waittill("weapon_fired");
		Gun=self GetCurrentWeapon();
		Incident=AnglesToForward(self GetPlayerAngles());
		Trace=BulletTrace(self GetEye(),self GetEye()+Incident * 100000,0,self);
		Reflection=Incident-(2 * trace["normal"] * VectorDot(Incident,trace["normal"]));
		MagicBullet(Gun,Trace["position"],Trace["position"]+(Reflection * 100000),self);
		for(i=0;i<1-1;i++)
		{
			Trace=BulletTrace(Trace["position"],Trace["position"]+(Reflection * 100000),0,self);
			Incident=Reflection;
			Reflection=Incident-(2 * Trace["normal"] * VectorDot(Incident,Trace["normal"]));
			MagicBullet(Gun,Trace["position"],Trace["position"]+(Reflection * 100000),self);
			wait 0.05;
		}
	}
}
TeleportGun()
{
	if(self.tpg==false)
	{
		self.tpg=true;
		self thread TeleportRun();
		self iPrintln("Teleporter Weapon [^2ON^7]");
	}
	else
	{
		self.tpg=false;
		self notify("Stop_TP");
		self iPrintln("Teleporter Weapon [^1OFF^7]");
	}
}
TeleportRun()
{
	self endon ("death");
	self endon ("Stop_TP");
	for(;;)
	{
		self waittill ("weapon_fired");
		self setorigin(BulletTrace(self gettagorigin("j_head"),self gettagorigin("j_head")+anglestoforward(self getplayerangles())*1000000,0,self)["position"]);
	}
}
doDefaultModelsBullets()
{
	if(self.bullets2==false)
	{
		self thread doactorBullets();
		self.bullets2=true;
		self iPrintln("Default Model Bullets [^2ON^7]");
	}
	else
	{
		self notify("stop_bullets2");
		self.bullets2=false;
		self iPrintln("Default Model Bullets [^1OFF^7]");
	}
}
doactorBullets()
{
	self endon("stop_bullets2");
	while(1)
	{
		self waittill ("weapon_fired");
		forward=self getTagOrigin("j_head");
		end=self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		SPLOSIONlocation=BulletTrace(forward,end,0,self)["position"];
		M=spawn("script_model",SPLOSIONlocation);
		M setModel("defaultactor");
	}
}
doCarDefaultModelsBullets()
{
	if(self.bullets3==false)
	{
		self thread doacarBullets();
		self.bullets3=true;
		self iPrintln("Default Car Bullets [^2ON^7]");
	}
	else
	{
		self notify("stop_bullets3");
		self.bullets3=false;
		self iPrintln("Default Car Bullets [^1OFF^7]");
	}
}
doacarBullets()
{
	self endon("stop_bullets3");
	while(1)
	{
		self waittill ("weapon_fired");
		forward=self getTagOrigin("j_head");
		end=self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		SPLOSIONlocation=BulletTrace(forward,end,0,self)["position"];
		M=spawn("script_model",SPLOSIONlocation);
		M setModel("defaultvehicle");
	}
}
UFOMode()
{
	if(self.UFOMode==false)
	{
		self thread doUFOMode();
		self.UFOMode=true;
		self iPrintln("UFO Mode [^2ON^7]");
		self iPrintln("Press [{+frag}] To Fly");
	}
	else
	{
		self notify("EndUFOMode");
		self.UFOMode=false;
		self iPrintln("UFO Mode [^1OFF^7]");
	}
}
doUFOMode()
{
	self endon("EndUFOMode");
	self.Fly=0;
	UFO=spawn("script_model",self.origin);
	for(;;)
	{
		if(self FragButtonPressed())
		{
			self playerLinkTo(UFO);
			self.Fly=1;
		}
		else
		{
			self unlink();
			self.Fly=0;
		}
		if(self.Fly==1)
		{
			Fly=self.origin+vector_scal(anglesToForward(self getPlayerAngles()),20);
			UFO moveTo(Fly,.01);
		}
		wait .001;
	}
}
Forge()
{
	if(!IsDefined(self.ForgePickUp))
	{
		self.ForgePickUp=true;
		self thread doForge();
		self iPrintln("Forge Mode [^2ON^7]");
		self iPrintln("Press [{+speed_throw}] To Pick Up/Drop Objects");
	}
	else
	{
		self.ForgePickUp=undefined;
		self notify("Forge_Off");
		self iPrintln("Forge Mode [^1OFF^7]");
	}
}
doForge()
{
	self endon("death");
	self endon("Forge_Off");
	for(;;)
	{
		while(self AdsButtonPressed())
		{
			trace=bullettrace(self gettagorigin("j_head"),self getTagOrigin("j_head")+anglesToForward(self getPlayerAngles()) * 1000000,true,self);
			while(self AdsButtonPressed())
			{
trace["entity"] ForceTeleport(self getTagOrigin("j_head")+anglesToForward(self getPlayerAngles()) * 200);
trace["entity"] setOrigin(self getTagOrigin("j_head")+anglesToForward(self getPlayerAngles()) * 200);
trace["entity"].origin=self getTagOrigin("j_head")+anglesToForward(self getPlayerAngles()) * 200;
wait .01;
			}
		}
		wait .01;
	}
}
SaveandLoad()
{
	if(self.SnL==0)
	{
		self iPrintln("Save and Load [^2ON^7]");
		self iPrintln("Press [{+actionslot 3}] To Save and Load Position!");
		self thread doSaveandLoad();
		self.SnL=1;
	}
	else
	{
		self iPrintln("Save and Load [^1OFF^7]");
		self.SnL=0;
		self notify("SaveandLoad");
	}
}
doSaveandLoad()
{
	self endon("disconnect");
	self endon("death");
	self endon("SaveandLoad");
	Load=0;
	for(;;)
	{
		if(self actionslotthreebuttonpressed()&& Load==0 && self.SnL==1)
		{
			self.O=self.origin;
			self.A=self.angles;
			self iPrintln("Position ^2Saved");
			Load=1;
			wait 2;
		}
		if(self actionslotthreebuttonpressed()&& Load==1 && self.SnL==1)
		{
			self setPlayerAngles(self.A);
			self setOrigin(self.O);
			self iPrintln("Position ^2Loaded");
			Load=0;
			wait 2;
		}
		wait .05;
	}
}
doProtecion()
{
	if(self.protecti==0)
	{
		self iPrintln("Skull Protector ^2Enabled");
		self thread Gr3ZProtec();
		self.protecti=1;
	}
	else
	{
		self iPrintln("Skull Protector ^1Disabled");
		self thread removeProtc();
		self.protecti=0;
		self notify("Stop_Skull");
	}
}
removeProtc()
{
	self.Skullix delete();
	self.SkullixFX delete();
}
Gr3ZProtec()
{
	self.Skullix=spawn("script_model",self.origin+(0,0,95));
	self.Skullix SetModel("zombie_skull");
	self.Skullix.angles=self.angles+(0,90,0);
	self.Skullix thread GFlic(self);
	self.Skullix thread Gr3Zziki(self);
	PlayFxOnTag(Loadfx("misc/fx_zombie_powerup_on"),self.Skullix,"tag_origin");
}
GFlic(Gr3Zzv4)
{
	Gr3Zzv4 endon("disconnect");
	Gr3Zzv4 endon("death");
	Gr3Zzv4 endon("Stop_Skull");
	for(;;)
	{
		self.origin=Gr3Zzv4.origin+(0,0,95);
		self.angles=Gr3Zzv4.angles+(0,90,0);
		wait .01;
	}
}
Gr3Zziki(Gr3Zzv4)
{
	Gr3Zzv4 endon("death");
	Gr3Zzv4 endon("disconnect");
	Gr3Zzv4 endon("Stop_Skull");
	for(;;)
	{
		Enemy=GetAiSpeciesArray("axis","all");
		for(i=0;i<Enemy.size;i++)
		{
			if(Distance(Enemy[i].origin,self.origin)<350)
			{
self.SkullixFX=spawn("script_model",self.origin);
self.SkullixFX SetModel("tag_origin");
self.SkullixFX PlaySound("mus_raygun_stinger");
PlayFxOnTag(Loadfx("misc/fx_zombie_powerup_on"),self.SkullixFX,"tag_origin");
self.SkullixFX MoveTo(Enemy[i] GetTagOrigin("j_head"),1);
wait 1;
Enemy[i] maps\mp\zombies\_zm_spawner::zombie_head_gib();
Enemy[i] DoDamage(Enemy[i].health+666,Enemy[i].origin,Gr3Zzv4);
self.SkullixFX delete();
			}
		}
		wait .05;
	}
}
autoRevive()
{
	if(level.autoR==false)
	{
		level.autoR=true;
		self thread autoR();
		self iPrintln("Auto Revive [^2ON^7]");
	}
	else
	{
		level.autoR=false;
		self iPrintln("Auto Revive [^1OFF^7]");
		self notify("R_Off");
		self notify("R2_Off");
	}
}
autoR()
{
	self endon("R_Off");
	for(;;)
	{
		self thread ReviveAll();
		wait .05;
	}
}
ReviveAll()
{
	self endon("R2_Off");
	foreach(P in level.players)
	{
		if(IsDefined(P.revivetrigger))
		{
			P notify ("player_revived");
			P reviveplayer();
			P.revivetrigger delete();
			P.revivetrigger=undefined;
			P.ignoreme=false;
			P allowjump(1);
			P.laststand=undefined;
		}
	}
}
aarr649()
{
	if(self.drunk==true)
	{
		self iPrintln("Drunk Mode [^2ON^7]");
		self thread t649();
		wait 10;
		self thread l45();
		self.drunk=false;
	}
	else
	{
		self notify("lil");
		self setPlayerAngles(self.angles+(0,0,0));
		self setBlur(0,1.0);
		self iPrintln("Drunk Mode [^1OFF^7]");
		self.drunk=true;
	}
}
t649()
{
	weap=self GetCurrentWeapon();
	self.give_perks_over=false;
	self thread Give_Perks("649","zombie_perk_bottle_doubletap");
	self waittill("ready");
	self thread Give_Perks("649","zombie_perk_bottle_jugg");
	self waittill("ready");
	self thread Give_Perks("649","zombie_perk_bottle_revive");
	self waittill("ready");
	self thread Give_Perks("649","zombie_perk_bottle_sleight");
	self waittill("ready");
	self SwitchToWeapon(weap);
}
l45()
{
	self endon("lil");
	while(1)
	{
		self setPlayerAngles(self.angles+(0,0,0));
		self setstance("prone");
		wait (0.1);
		self SetBlur(10.3,1.0);
		self setPlayerAngles(self.angles+(0,0,5));
		self setstance("stand");
		wait (0.1);
		self SetBlur(9.1,1.0);
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,10));
		wait (0.1);
		self setstance("prone");
		wait (0.1);
		self SetBlur(6.2,1.0);
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,15));
		self setBlur(5.2,1.0);
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,20));
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,25));
		self setBlur(4.2,1.0);
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,30));
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,35));
		self setBlur(3.2,1.0);
		wait (0.1);
		self setstance("crouch");
		self setPlayerAngles(self.angles+(0,0,30));
		wait (0.1);
		self setstance("prone");
		self setPlayerAngles(self.angles+(0,0,25));
		self setBlur(2.2,1.0);
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,20));
		wait (0.1);
		self setstance("crouch");
		self setPlayerAngles(self.angles+(0,0,15));
		self setBlur(1.2,1.0);
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,10));
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,5));
		self setBlur(0.5,1.0);
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,-5));
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,-10));
		self setBlur(0,1.0);
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,-15));
		wait (0.1);
		self setstance("prone");
		self setPlayerAngles(self.angles+(0,0,-20));
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,-25));
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,-30));
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,-35));
		wait (0.1);
		self setstance("stand");
		self setPlayerAngles(self.angles+(0,0,-30));
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,-25));
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,-20));
		wait (0.1);
		self setstance("crouch");
		self setPlayerAngles(self.angles+(0,0,-15));
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,-10));
		wait (0.1);
		self setPlayerAngles(self.angles+(0,0,-5));
		wait .1;
	}
}
Give_Perks(Perk,Perk_Bottle)
{
	playsoundatposition("bottle_dispense3d",self.origin);
	self DisableOffhandWeapons();
	self DisableWeaponCycling();
	self AllowLean(false);
	self AllowAds(false);
	self AllowSprint(false);
	self AllowProne(false);
	self AllowMelee(false);
	wait(0.05);
	if (self GetStance()=="prone")
	{
		self SetStance("crouch");
	}
	weapon=Perk_Bottle;
	self SetPerk(Perk);
	self GiveWeapon(weapon);
	self SwitchToWeapon(weapon);
	self waittill("weapon_change_complete");
	self EnableOffhandWeapons();
	self EnableWeaponCycling();
	self AllowLean(true);
	self AllowAds(true);
	self AllowSprint(true);
	self AllowProne(true);
	self AllowMelee(true);
	self TakeWeapon(weapon);
	self notify("ready");
}
toggle_gore2()
{
	if(self.gore==false)
	{
		self.gore=true;
		self iPrintln("Gore Mode [^2ON^7]");
		self thread Gore();
	}
	else
	{
		self.gore=false;
		self iPrintln("Gore Mode [^1OFF^7]");
		self notify("gore_off");
	}
}
Gore()
{
	foreach(player in level.players)
	{
		player endon("gore_off");
		for(;;)
		{
			playFx(level._effect["headshot"],player getTagOrigin("j_head"));
			playFx(level._effect["headshot"],player getTagOrigin("J_neck"));
			playFx(level._effect["headshot"],player getTagOrigin("J_Shoulder_LE"));
			playFx(level._effect["headshot"],player getTagOrigin("J_Shoulder_RI"));
			playFx(level._effect["bloodspurt"],player getTagOrigin("J_Shoulder_LE"));
			playFx(level._effect["bloodspurt"],player getTagOrigin("J_Shoulder_RI"));
			playFx(level._effect["headshot"],player getTagOrigin("J_Ankle_RI"));
			playFx(level._effect["headshot"],player getTagOrigin("J_Ankle_LE"));
			playFx(level._effect["bloodspurt"],player getTagOrigin("J_Ankle_RI"));
			playFx(level._effect["bloodspurt"],player getTagOrigin("J_Ankle_LE"));
			playFx(level._effect["bloodspurt"],player getTagOrigin("J_wrist_RI"));
			playFx(level._effect["bloodspurt"],player getTagOrigin("J_wrist_LE"));
			playFx(level._effect["headshot"],player getTagOrigin("J_SpineLower"));
			playFx(level._effect["headshot"],player getTagOrigin("J_SpineUpper"));
			wait .5;
		}
	}
}
Fr3ZzZoM()
{
	if(self.Fr3ZzZoM==false)
	{
		self iPrintln("Freeze Zombies [^2ON^7]");
		setdvar("g_ai","0");
		self.Fr3ZzZoM=true;
	}
	else
	{
		self iPrintln("Freeze Zombies [^1OFF^7]");
		setdvar("g_ai","1");
		self.Fr3ZzZoM=false;
	}
}
ZombieKill()
{
	zombs=getaiarray("axis");
	level.zombie_total=0;
	if(isDefined(zombs))
	{
		for(i=0;i<zombs.size;i++)
		{
			zombs[i] dodamage(zombs[i].health * 5000,(0,0,0),self);
			wait 0.05;
		}
		self doPNuke();
		self iPrintln("All Zombies ^1Eliminated");
	}
}
fhh649()
{
	self endon("Zombz2CHs_off");
	for(;;)
	{
		self waittill("weapon_fired");
		Zombz=GetAiSpeciesArray("axis","all");
		eye=self geteye();
		vec=anglesToForward(self getPlayerAngles());
		end=(vec[0] * 100000000,vec[1] * 100000000,vec[2] * 100000000);
		teleport_loc=BulletTrace(eye,end,0,self)["position"];
		for(i=0;i<Zombz.size;i++)
		{
			Zombz[i] forceTeleport(teleport_loc);
			Zombz[i] maps\mp\zombies\_zm_spawner::reset_attack_spot();
		}
		self iPrintln("All Zombies To ^2Crosshairs");
	}
}
ZombieDefaultActor()
{
	Zombz=GetAiSpeciesArray("axis","all");
	for(i=0;i<Zombz.size;i++)
	{
		Zombz[i] setModel("defaultactor");
	}
	self iPrintln("All Zombies Changed To ^2 Default Model");
}
round_one()
{
	self thread ZombieKill();
	level.round_number=1;
	self iPrintln("Round Set To ^1"+level.round_number+"");
	wait 2;
}
round_10()
{
	self thread ZombieKill();
	level.round_number=250;
	self iPrintln("Round Set To ^1"+level.round_number+"");
	wait 2;
}
round_20()
{
	self thread ZombieKill();
	level.round_number=250;
	self iPrintln("Round Set To ^1"+level.round_number+"");
	wait 2;
}
max_round()
{
	self thread ZombieKill();
	level.round_number=250;
	self iPrintln("Round Set To ^1"+level.round_number+"");
	wait 2;
}
round_up()
{
	self thread ZombieKill();
	level.round_number=level.round_number+1;
	self iPrintln("Round Set To ^1"+level.round_number+"");
	wait .5;
}
round_down()
{
	self thread ZombieKill();
	level.round_number=level.round_number-1;
	self iPrintln("Round Set To ^1"+level.round_number+"");
	wait .5;
}
NormalBullets()
{
	self iPrintln("Modded Bullets [^1OFF^7]");
	self notify("StopBullets");
}
doBullet(A)
{
	self notify("StopBullets");
	self endon("StopBullets");
	self iPrintln("Bullets Type: ^2"+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]);
	for(;;)
	{
		self waittill("weapon_fired");
		B=self getTagOrigin("tag_eye");
		C=self thread Bullet(anglestoforward(self getPlayerAngles()),1000000);
		D=BulletTrace(B,C,0,self)["position"];
		MagicBullet(A,B,D,self);
	}
}
Bullet(A,B)
{
	return (A[0]*B,A[1]*B,A[2]*B);
}
OpenAllTehDoors()
{
	self iprintln("All Doors are now ^2Open!");
	setdvar("zombie_unlock_all",1);
	Triggers=StrTok("zombie_doors|zombie_door|zombie_airlock_buy|zombie_debris|electric_door|rock_debris_pile|flag_blocker|window_shutter|zombie_trap","|");
	for(a=0;a<Triggers.size;a++)
	{
		Trigger=GetEntArray(Triggers[a],"targetname");
		for(b=0;b<Trigger.size;b++)
		{
			Trigger[b] notify("trigger");
        	Trigger[b] maps/mp/zombies/_zm_blockers::door_opened(0);
		}
	}
	setdvar("zombie_unlock_all",0);
	self powermanager();
}

powermanager()
{
	if(GetDvar("mapname") == "zm_prison") // Mob of the Dead
	{
		self powerp();
		self dogs_fed();
	}
	if(GetDvar("mapname") == "zm_tomb") // Origins
	{
		self powero();
		self turn_on_power();
		self origins_debris();
		self StargateSG1();
	}
	else
	{
		self powerp();
	}
}
powerp()
{
	self endon("disconnect");
		level notify( "electric_door" );
		clientnotify( "power_on" );
		flag_set("power_on");
		level setclientfield( "zombie_power_on", 1 );
		level thread maps/mp/zombies/_zm_perks::perk_unpause_all_perks();
		self iprintln("Power ^2On!");
		if(GetDvar("mapname") == "zm_transit") //Transit
		{
		self thread maps/mp/zombies/_zm_game_module::turn_power_on_and_open_doors();
		self iPrintln("^7PAP Power ^2ON");
		}
}

powero()
{
	self endon("disconnect");
		self iprintln("Power ^2On!");
		clientnotify( "power_on" );
		flag_set("power_on");
		level setclientfield( "zombie_power_on", 1 );
		level setclientfield( "zone_capture_hud_all_generators_captured", 1 );
		level thread maps/mp/zombies/_zm_perks::perk_unpause_all_perks();
}

turn_on_power()
{
a_generators = getstructarray( "s_generator", "targetname" );
	_a2495 = a_generators;
	_k2495 = getFirstArrayKey( _a2495 );
	while ( isDefined( _k2495 ) )
	{
		s_generator = _a2495[ _k2495 ];
		s_temp = level.zone_capture.zones[ s_generator.script_noteworthy ];
		s_temp debug_set_generator_active();
		wait_network_frame();
		_k2495 = getNextArrayKey( _a2495, _k2495 );
	}
}

debug_set_generator_active()
{
	self set_player_controlled_area();
	self.n_current_progress = 100;
	self generator_state_power_up();
	level setclientfield( self.script_noteworthy, self.n_current_progress / 100 );
}

generator_state_power_up()
{
	level setclientfield( "state_" + self.script_noteworthy, 2 );
}

set_player_controlled_area()
{
	level.zone_capture.last_zone_captured = self;
	update_captured_zone_count();
	self set_player_controlled_zone();
	self enable_perk_machines();
	self enable_random_perk_machines();
	self play_pap_anim(1);
}

enable_perk_machines()
{
    a_keys = getarraykeys( self.perk_machines );
    i = 0;
    level notify( a_keys[ i ] + "_on" );
    i++;
}

enable_random_perk_machines()
{
	_a586 = self.perk_machines_random;
	_k586 = getFirstArrayKey( _a586 );
	random_perk_machine = _a586[ _k586 ];
	random_perk_machine.is_locked = 0;
	random_perk_machine sethintstring( &"ZM_TOMB_RPB", level._random_zombie_perk_cost );
	_k586 = getNextArrayKey( _a586, _k586 );
}

get_captured_zone_count()
{
	n_player_controlled_zones = 0;
	_a1795 = level.zone_capture.zones;
	_k1795 = getFirstArrayKey( _a1795 );
	while ( isDefined( _k1795 ) )
	{
		generator = _a1795[ _k1795 ];
		if ( generator ent_flag( "player_controlled" ) )
		{
			n_player_controlled_zones++;
		}
		_k1795 = getNextArrayKey( _a1795, _k1795 );
	}
	return n_player_controlled_zones;
}

set_player_controlled_zone()
{
	self ent_flag_set( "player_controlled" );
	self ent_flag_clear( "attacked_by_recapture_zombies" );
	level setclientfield( "zone_capture_hud_generator_" + self.script_int, 1 );
	level setclientfield( "zone_capture_monolith_crystal_" + self.script_int, 0 );
	if ( !isDefined( self.perk_fx_func ) || [[ self.perk_fx_func ]]() )
	{
		level setclientfield( "zone_capture_perk_machine_smoke_fx_" + self.script_int, 1 );
	}
	self ent_flag_set( "player_controlled" );
	level notify( "zone_captured_by_player" );
}

update_captured_zone_count()
{
	level.total_capture_zones = get_captured_zone_count();
	if ( level.total_capture_zones == 6 )
	{
		flag_set( "all_zones_captured" );
	}
	else
	{
		flag_clear( "all_zones_captured" );
	}
}

play_pap_anim( b_assemble )
{
	level setclientfield( "packapunch_anim", get_captured_zone_count() );
	t_pap = getent( "specialty_weapupgrade", "script_noteworthy" );
	t_pap trigger_on();
	flag_set( "power_on" );
}

origins_debris()
{
	spawnpoint = undefined;
    spawnpoint = "junk_nml_ruins";
    spawn = GetentArray( spawnpoint, "targetname" );
    spawn[0].origin = (13594.7, -1598.53, -188.875); 
    spawn[0].angles = (0, 49, 0);
    spawn[1].origin = (13600.1, -1036.38, -188.875); 
    spawn[1].angles = (0, 54, 0);
    spawn[2].origin = (13819.9, -749.29, -189.875); 
    spawn[2].angles = (0, 135, 0);
    spawn[3].origin = (14019.9, -544.09, -188.875);
    spawn[3].angles = (0, -179, 0);
    spawn[4].origin = (13646.4, -548.933, -188.875);
    spawn[4].angles = (0, 0, 0);
    spawn[5].origin = (13796.6, -239.183, -188.875);
    spawn[5].angles = (0, -90, 0);
    spawn[6].origin = (13592.5, -792.743, -189.875);
    spawn[6].angles = (0, 0, 0);
	debri = undefined;
    debri = "junk_village_0";
    debri1 = GetentArray(debri, "targetname" );
    debri1[0].origin = (13229, -1294, -198.2);
    debri1[1].origin = (14238, -996, -196.1);
	part1 = undefined;
    part1 = "junk_nml_farm";
    part1a = GetentArray(part1, "targetname" );
    part1a[0].origin = (13594.7, -1598.53, -188.875); 
    part1a[0].angles = (0, 180, 0);
    part1a[1].origin = (13594.7, -1598.53, -188.875); 
    part1a[1].angles = (0, 0, 0);
    part1a[2].origin = (13594.7, -1598.53, -188.875); 
    part1a[2].angles = (0, -177, 0);
    part1a[3].origin = (13594.7, -1598.53, -188.875); 
    part1a[3].angles = (0, -177, 0);
	part1a[4].origin = (13594.7, -1598.53, -188.875); 
    part1a[4].angles = (0, -177, 0);
	part1a[5].origin = (13594.7, -1598.53, -188.875); 
    part1a[5].angles = (0, -177, 0);
	part1a[6].origin = (13594.7, -1598.53, -188.875); 
    part1a[6].angles = (0, -177, 0);
    debriz = undefined;
    debriz = "junk_village_7";
    debriz1 = GetentArray(debriz, "targetname" );
    debriz1[0].origin = (13229, -1294, -198.2);
    debriz1[1].origin = (14238, -996, -196.1);
}
//MOTD Dogs fed
dogs_fed()
{
  a_wolf_structs = getstructarray( "wolf_position", "targetname" );
  i = 0;
  while ( i < a_wolf_structs.size )
  {
    a_wolf_structs[ i ].souls_received = 6;
    i++;
  }
  flag_set( "soul_catchers_charged" );
  level notify( "soul_catchers_charged" );
  level thread maps/mp/zombies/_zm_audio::sndmusicstingerevent( "quest_generic" );
}

give_money()
{
	self maps/mp/zombies/_zm_score::add_to_player_score(100000);
}
NoTarget()
{
	self.ignoreme=!self.ignoreme;
	if (self.ignoreme)
	{
		setdvar("ai_showFailedPaths",0);
	}
	if (self.ignoreme==1)
	{
		self iPrintln("Zombies Ignore Me [^2ON^7]");
	}
	if (self.ignoreme==0)
	{
		self iPrintln("Zombies Ignore Me [^1OFF^7]");
	}
}
doTeleportToMe()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't teleport the Host!");
	}
	else
	{
		player SetOrigin(self.origin);
		player iPrintln("Teleported to ^1"+player.name);
	}
	self iPrintln("^1"+player.name+" ^7Teleported to Me");
}
doTeleportToHim()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't teleport to the host!");
	}
	else
	{
		self SetOrigin(player.origin);
		self iPrintln("Teleported to ^1"+player.name);
	}
	player iPrintln("^1"+self.name+" ^7Teleported to Me");
}
PlayerFrezeControl()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't freeze the host!");
	}
	else
	{
		if(self.fronzy==false)
		{
			self.fronzy=true;
			self iPrintln("^2Frozen: ^7"+player.name);
			player freezeControls(true);
		}
		else
		{
			self.fronzy=false;
			self iPrintln("^1Unfrozen: ^7"+player.name);
			player freezeControls(false);
		}
	}
}
ChiciTakeWeaponPlayer()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't take weapon the host!");
	}
	else
	{
		self iPrintln("Taken Weapons: ^1"+player.name);
		player takeAllWeapons();
	}
}
doGivePlayerWeapon()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't give weapon the host!");
	}
	else
	{
		self iPrintln("Given Weapons: ^1"+player.name);
		player GiveWeapon("m1911_zm");
		player SwitchToWeapon("m1911_zm");
		player GiveMaxAmmo("m1911_zm");
	}
}
kickPlayer()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("^1Fuck You Men !");
		kick(self getEntityNumber());
	}
	else
	{
		self iPrintln("^1 "+player.name+" ^7Has Been ^1Kicked ^7!");
		kick(player getEntityNumber());
	}
}
PlayerGiveGodMod()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't give godmod the host!");
	}
	else
	{
		if(self.godmodplater==false)
		{
			self.godmodplater=true;
			self iPrintln("^1"+player.name+" ^7GodMod [^2ON^7]");
			player Toggle_God();
		}
		else
		{
			self.godmodplater=false;
			self iPrintln("^1"+player.name+" ^7GodMod [^1OFF^7]");
			player Toggle_God();
		}
	}
}
doRevivePlayer()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't revive the host!");
	}
	else
	{
		self iPrintln("^1 "+player.name+" ^7Revive ^1!");
		player notify ("player_revived");
		player reviveplayer();
		player.revivetrigger delete();
		player.revivetrigger=undefined;
		player.ignoreme=false;
		player allowjump(1);
		player.laststand=undefined;
	}
}
doAllPlayersToMe()
{
	foreach(player in level.players)
	{
		if(player isHost())
		{
		}
		else
		{
			player SetOrigin(self.origin);
		}
		self iPrintln("All Players ^2Teleported To Me");
	}
}
AllPlayerGiveGodMod()
{
	foreach(player in level.players)
	{
		if(player isHost())
		{
		}
		else
		{
			if(self.godmodplater==false)
			{
self.godmodplater=true;
self iPrintln("All Players ^7GodMod [^2ON^7]");
player Toggle_God();
			}
			else
			{
self.godmodplater=false;
self iPrintln("All Players ^7GodMod [^1OFF^7]");
player Toggle_God();
			}
		}
	}
}
doDefaultTheme()
{
	self.Menu.Material["Background"] elemColor(1,(1,0,0));
	self.Menu.Material["Scrollbar"] elemColor(1,(1,0,0));
	self.Menu.Material["BorderMiddle"] elemColor(1,(1,0,0));
	self.Menu.Material["BorderLeft"] elemColor(1,(1,0,0));
	self.Menu.Material["BorderRight"] elemColor(1,(1,0,0));
	self.Menu.NewsBar["BorderUp"] elemColor(1,(1,0,0));
	self.Menu.NewsBar["BorderDown"] elemColor(1,(1,0,0));
	self.Menu.System["Title"] elemGlow(1,(1,0,0));
	self DefaultMenuSettings();
	self iPrintln("Theme Changed To: ^2"+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]);
}
doBlue()
{
	self.Menu.Material["Background"] elemColor(1,(0,0,1));
	self.Menu.Material["Scrollbar"] elemColor(1,(0,0,1));
	self.Menu.Material["BorderMiddle"] elemColor(1,(0,0,1));
	self.Menu.Material["BorderLeft"] elemColor(1,(0,0,1));
	self.Menu.Material["BorderRight"] elemColor(1,(0,0,1));
	self.Menu.NewsBar["BorderUp"] elemColor(1,(0,0,1));
	self.Menu.NewsBar["BorderDown"] elemColor(1,(0,0,1));
	self.Menu.System["Title"] elemGlow(1,(0,0,1));
	self.glowtitre=(0,0,1);
	self iPrintln("Theme Changed To: ^2"+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]);
}
doGreen()
{
	self.Menu.Material["Background"] elemColor(1,(0,1,0));
	self.Menu.Material["Scrollbar"] elemColor(1,(0,1,0));
	self.Menu.Material["BorderMiddle"] elemColor(1,(0,1,0));
	self.Menu.Material["BorderLeft"] elemColor(1,(0,1,0));
	self.Menu.Material["BorderRight"] elemColor(1,(0,1,0));
	self.Menu.NewsBar["BorderUp"] elemColor(1,(0,1,0));
	self.Menu.NewsBar["BorderDown"] elemColor(1,(0,1,0));
	self.Menu.System["Title"] elemGlow(1,(0,1,0));
	self.glowtitre=(0,1,0);
	self iPrintln("Theme Changed To: ^2"+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]);
}
doYellow()
{
	self.Menu.Material["Background"] elemColor(1,(1,1,0));
	self.Menu.Material["Scrollbar"] elemColor(1,(1,1,0));
	self.Menu.Material["BorderMiddle"] elemColor(1,(1,1,0));
	self.Menu.Material["BorderLeft"] elemColor(1,(1,1,0));
	self.Menu.Material["BorderRight"] elemColor(1,(1,1,0));
	self.Menu.NewsBar["BorderUp"] elemColor(1,(1,1,0));
	self.Menu.NewsBar["BorderDown"] elemColor(1,(1,1,0));
	self.Menu.System["Title"] elemGlow(1,(1,1,0));
	self.glowtitre=(1,1,0);
	self iPrintln("Theme Changed To: ^2"+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]);
}
doPink()
{
	self.Menu.Material["Background"] elemColor(1,(1,0,1));
	self.Menu.Material["Scrollbar"] elemColor(1,(1,0,1));
	self.Menu.Material["BorderMiddle"] elemColor(1,(1,0,1));
	self.Menu.Material["BorderLeft"] elemColor(1,(1,0,1));
	self.Menu.Material["BorderRight"] elemColor(1,(1,0,1));
	self.Menu.NewsBar["BorderUp"] elemColor(1,(1,0,1));
	self.Menu.NewsBar["BorderDown"] elemColor(1,(1,0,1));
	self.Menu.System["Title"] elemGlow(1,(1,0,1));
	self.glowtitre=(1,0,1);
	self iPrintln("Theme Changed To: ^2"+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]);
}
doCyan()
{
	self.Menu.Material["Background"] elemColor(1,(0,1,1));
	self.Menu.Material["Scrollbar"] elemColor(1,(0,1,1));
	self.Menu.Material["BorderMiddle"] elemColor(1,(0,1,1));
	self.Menu.Material["BorderLeft"] elemColor(1,(0,1,1));
	self.Menu.Material["BorderRight"] elemColor(1,(0,1,1));
	self.Menu.NewsBar["BorderUp"] elemColor(1,(0,1,1));
	self.Menu.NewsBar["BorderDown"] elemColor(1,(0,1,1));
	self.Menu.System["Title"] elemGlow(1,(0,1,1));
	self.glowtitre=(0,1,1);
	self iPrintln("Theme Changed To: ^2"+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]);
}
doJetPack()
{
	if(self.jetpack==false)
	{
		self thread StartJetPack();
		self iPrintln("JetPack [^2ON^7]");
		self iPrintln("Press [{+gostand}] foruse jetpack");
		self.jetpack=true;
	}
	else if(self.jetpack==true)
	{
		self.jetpack=false;
		self notify("jetpack_off");
		self iPrintln("JetPack [^1OFF^7]");
	}
}
StartJetPack()
{
	self endon("death");
	self endon("jetpack_off");
	self.jetboots= 100;
	for(i=0;;i++)
	{
		if(self jumpbuttonpressed() && self.jetboots>0)
		{
			playFX(level._effect["lght_marker_flare"],self getTagOrigin("J_Ankle_RI"));
			playFx(level._effect["lght_marker_flare"],self getTagOrigin("J_Ankle_LE"));
			earthquake(.15,.2,self gettagorigin("j_spine4"),50);
			self.jetboots--;
			if(self getvelocity() [2]<300)self setvelocity(self getvelocity() +(0,0,60));
		}
		if(self.jetboots<100 &&!self jumpbuttonpressed())self.jetboots++;
		wait .05;
	}
}
giveAllBuildables()
{
	foreach(stub in level.buildable_stubs)
	{
	stub.built = 1;
	}
	level thread buildbuildables();
	level thread buildcraftables();
	self iPrintln("All Buildables are all built!");
}

buildbuildables()
{
	// need a wait or else some buildables dont build
	wait 1;

	if(is_classic())
	{
		if(level.scr_zm_map_start_location == "transit")
		{
			buildbuildable( "turbine" );
			buildbuildable( "electric_trap" );
			buildbuildable( "turret" );
			buildbuildable( "riotshield_zm" );
			buildbuildable( "jetgun_zm" );
			buildbuildable( "powerswitch", 1 );
			buildbuildable( "pap", 1 );
			buildbuildable( "sq_common", 1 );

			// power switch is not showing up from forced build
			show_powerswitch();
		}
		else if(level.scr_zm_map_start_location == "rooftop")
		{
			buildbuildable( "slipgun_zm" );
			buildbuildable( "springpad_zm" );
			buildbuildable( "sq_common", 1 );
		}
		else if(level.scr_zm_map_start_location == "processing")
		{
			level waittill( "buildables_setup" ); // wait for buildables to randomize
			wait 0.05;

			level.buildables_available = array("subwoofer_zm", "springpad_zm", "headchopper_zm");

			removebuildable( "keys_zm" );
			buildbuildable( "turbine" );
			buildbuildable( "subwoofer_zm" );
			buildbuildable( "springpad_zm" );
			buildbuildable( "headchopper_zm" );
			buildbuildable( "sq_common", 1 );
		}
	}
	else
	{
		if(level.scr_zm_map_start_location == "street")
		{
			flag_wait( "initial_blackscreen_passed" ); // wait for buildables to be built
			wait 1;

			removebuildable( "turbine", 1 );
		}
	}
}

buildbuildable( buildable, craft )
{
	if (!isDefined(craft))
	{
		craft = 0;
	}

	player = get_players()[ 0 ];
	foreach (stub in level.buildable_stubs)
	{
		if ( !isDefined( buildable ) || stub.equipname == buildable )
		{
			if ( isDefined( buildable ) || stub.persistent != 3 )
			{
				if (craft)
				{
					stub maps/mp/zombies/_zm_buildables::buildablestub_finish_build( player );
					stub maps/mp/zombies/_zm_buildables::buildablestub_remove();
					stub.model notsolid();
					stub.model show();
				}
				else
				{
					equipname = stub get_equipname();
					level.zombie_buildables[stub.equipname].hint = "Hold ^3[{+activate}]^7 to craft " + equipname;
					stub.prompt_and_visibility_func = ::buildabletrigger_update_prompt;
				}

				i = 0;
				foreach (piece in stub.buildablezone.pieces)
				{
					piece maps/mp/zombies/_zm_buildables::piece_unspawn();
					if (!craft && i > 0)
					{
						stub.buildablezone maps/mp/zombies/_zm_buildables::buildable_set_piece_built(piece);
					}
					i++;
				}

				return;
			}
		}
	}
}

// MOTD/Origins style buildables
buildcraftables()
{
	// need a wait or else some buildables dont build
	wait 1;

	if(is_classic())
	{
		if(level.scr_zm_map_start_location == "prison")
		{
			buildcraftable( "alcatraz_shield_zm" );
			buildcraftable( "packasplat" );
			changecraftableoption( 0 );
		}
		else if(level.scr_zm_map_start_location == "tomb")
		{
			buildcraftable( "tomb_shield_zm" );
			buildcraftable( "equip_dieseldrone_zm" );
			takecraftableparts( "gramophone" );
		}
	}
}

changecraftableoption( index )
{
	foreach (craftable in level.a_uts_craftables)
	{
		if (craftable.equipname == "open_table")
		{
			craftable thread setcraftableoption( index );
		}
	}
}

setcraftableoption( index )
{
	self endon("death");

	while (self.a_uts_open_craftables_available.size <= 0)
	{
		wait 0.05;
	}

	if (self.a_uts_open_craftables_available.size > 1)
	{
		self.n_open_craftable_choice = index;
		self.equipname = self.a_uts_open_craftables_available[self.n_open_craftable_choice].equipname;
		self.hint_string = self.a_uts_open_craftables_available[self.n_open_craftable_choice].hint_string;
		foreach (trig in self.playertrigger)
		{
			trig sethintstring( self.hint_string );
		}
	}
}

takecraftableparts( buildable )
{
	player = get_players()[ 0 ];
	foreach (stub in level.zombie_include_craftables)
	{
		if ( stub.name == buildable )
		{
			foreach (piece in stub.a_piecestubs)
			{
				piecespawn = piece.piecespawn;
				if ( isDefined( piecespawn ) )
				{
					player player_take_piece( piecespawn );
				}
			}

			return;
		}
	}
}

buildcraftable( buildable )
{
	player = get_players()[ 0 ];
	foreach (stub in level.a_uts_craftables)
	{
		if ( stub.craftablestub.name == buildable )
		{
			foreach (piece in stub.craftablespawn.a_piecespawns)
			{
				piecespawn = get_craftable_piece( stub.craftablestub.name, piece.piecename );
				if ( isDefined( piecespawn ) )
				{
					player player_take_piece( piecespawn );
				}
			}

			return;
		}
	}
}

get_craftable_piece( str_craftable, str_piece )
{
	foreach (uts_craftable in level.a_uts_craftables)
	{
		if ( uts_craftable.craftablestub.name == str_craftable )
		{
			foreach (piecespawn in uts_craftable.craftablespawn.a_piecespawns)
			{
				if ( piecespawn.piecename == str_piece )
				{
					return piecespawn;
				}
			}
		}
	}
	return undefined;
}

removebuildable( buildable, after_built )
{
	if (!isDefined(after_built))
	{
		after_built = 0;
	}

	if (after_built)
	{
		foreach (stub in level._unitriggers.trigger_stubs)
		{
			if(IsDefined(stub.equipname) && stub.equipname == buildable)
			{
				stub.model hide();
				maps/mp/zombies/_zm_unitrigger::unregister_unitrigger( stub );
				return;
			}
		}
	}
	else
	{
		foreach (stub in level.buildable_stubs)
		{
			if ( !isDefined( buildable ) || stub.equipname == buildable )
			{
				if ( isDefined( buildable ) || stub.persistent != 3 )
				{
					stub maps/mp/zombies/_zm_buildables::buildablestub_remove();
					foreach (piece in stub.buildablezone.pieces)
					{
						piece maps/mp/zombies/_zm_buildables::piece_unspawn();
					}
					maps/mp/zombies/_zm_unitrigger::unregister_unitrigger( stub );
					return;
				}
			}
		}
	}
}

show_powerswitch()
{
	getent( "powerswitch_p6_zm_buildable_pswitch_hand", "targetname" ) show();
	getent( "powerswitch_p6_zm_buildable_pswitch_body", "targetname" ) show();
	getent( "powerswitch_p6_zm_buildable_pswitch_lever", "targetname" ) show();
}

get_equipname()
{
	if (self.equipname == "turbine")
	{
		return "Turbine";
	}
	else if (self.equipname == "turret")
	{
		return "Turret";
	}
	else if (self.equipname == "electric_trap")
	{
		return "Electric Trap";
	}
	else if (self.equipname == "riotshield_zm")
	{
		return "Zombie Shield";
	}
	else if (self.equipname == "jetgun_zm")
	{
		return "Jet Gun";
	}
	else if (self.equipname == "slipgun_zm")
	{
		return "Sliquifier";
	}
	else if (self.equipname == "subwoofer_zm")
	{
		return "Subsurface Resonator";
	}
	else if (self.equipname == "springpad_zm")
	{
		return "Trample Steam";
	}
	else if (self.equipname == "headchopper_zm")
	{
		return "Head Chopper";
	}
}

buildabletrigger_update_prompt( player )
{
	can_use = 0;
	if (isDefined(level.buildablepools))
	{
		can_use = self.stub pooledbuildablestub_update_prompt( player, self );
	}
	else
	{
		can_use = self.stub buildablestub_update_prompt( player, self );
	}
	
	self sethintstring( self.stub.hint_string );
	if ( isDefined( self.stub.cursor_hint ) )
	{
		if ( self.stub.cursor_hint == "HINT_WEAPON" && isDefined( self.stub.cursor_hint_weapon ) )
		{
			self setcursorhint( self.stub.cursor_hint, self.stub.cursor_hint_weapon );
		}
		else
		{
			self setcursorhint( self.stub.cursor_hint );
		}
	}
	return can_use;
}

pooledbuildablestub_update_prompt( player, trigger )
{
	if ( !self maps/mp/zombies/_zm_buildables::anystub_update_prompt( player ) )
	{
		return 0;
	}

	if ( isDefined( self.custom_buildablestub_update_prompt ) && !( self [[ self.custom_buildablestub_update_prompt ]]( player ) ) )
	{
		return 0;
	}

	self.cursor_hint = "HINT_NOICON";
	self.cursor_hint_weapon = undefined;
	if ( isDefined( self.built ) && !self.built )
	{
		trigger thread buildablestub_build_succeed();

		if (level.buildables_available.size > 1)
		{
			self thread choose_open_buildable(player);
		}

		slot = self.buildablestruct.buildable_slot;

		if (self.buildables_available_index >= level.buildables_available.size)
		{
			self.buildables_available_index = 0;
		}

		foreach (stub in level.buildable_stubs)
		{
			if (stub.buildablezone.buildable_name == level.buildables_available[self.buildables_available_index])
			{
				piece = stub.buildablezone.pieces[0];
				break;
			}
		}

		player maps/mp/zombies/_zm_buildables::player_set_buildable_piece(piece, slot);

		piece = player maps/mp/zombies/_zm_buildables::player_get_buildable_piece(slot);

		if ( !isDefined( piece ) )
		{
			if ( isDefined( level.zombie_buildables[ self.equipname ].hint_more ) )
			{
				self.hint_string = level.zombie_buildables[ self.equipname ].hint_more;
			}
			else
			{
				self.hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
			}

			if ( isDefined( level.custom_buildable_need_part_vo ) )
			{
				player thread [[ level.custom_buildable_need_part_vo ]]();
			}
			return 0;
		}
		else
		{
			if ( isDefined( self.bound_to_buildable ) && !self.bound_to_buildable.buildablezone maps/mp/zombies/_zm_buildables::buildable_has_piece( piece ) )
			{
				if ( isDefined( level.zombie_buildables[ self.bound_to_buildable.equipname ].hint_wrong ) )
				{
					self.hint_string = level.zombie_buildables[ self.bound_to_buildable.equipname ].hint_wrong;
				}
				else
				{
					self.hint_string = &"ZOMBIE_BUILD_PIECE_WRONG";
				}

				if ( isDefined( level.custom_buildable_wrong_part_vo ) )
				{
					player thread [[ level.custom_buildable_wrong_part_vo ]]();
				}
				return 0;
			}
			else
			{
				if ( !isDefined( self.bound_to_buildable ) && !self.buildable_pool pooledbuildable_has_piece( piece ) )
				{
					if ( isDefined( level.zombie_buildables[ self.equipname ].hint_wrong ) )
					{
						self.hint_string = level.zombie_buildables[ self.equipname ].hint_wrong;
					}
					else
					{
						self.hint_string = &"ZOMBIE_BUILD_PIECE_WRONG";
					}
					return 0;
				}
				else
				{
					if ( isDefined( self.bound_to_buildable ) )
					{
						if ( isDefined( level.zombie_buildables[ piece.buildablename ].hint ) )
						{
							self.hint_string = level.zombie_buildables[ piece.buildablename ].hint;
						}
						else
						{
							self.hint_string = "Missing buildable hint";
						}
					}
					
					if ( isDefined( level.zombie_buildables[ piece.buildablename ].hint ) )
					{
						self.hint_string = level.zombie_buildables[ piece.buildablename ].hint;
					}
					else
					{
						self.hint_string = "Missing buildable hint";
					}
				}
			}
		}
	}
	else
	{
		return trigger [[ self.original_prompt_and_visibility_func ]]( player );
	}
	return 1;
}

buildablestub_update_prompt( player, trigger )
{
	if ( !self maps/mp/zombies/_zm_buildables::anystub_update_prompt( player ) )
	{
		return 0;
	}

	if ( isDefined( self.buildablestub_reject_func ) )
	{
		rval = self [[ self.buildablestub_reject_func ]]( player );
		if ( rval )
		{
			return 0;
		}
	}

	if ( isDefined( self.custom_buildablestub_update_prompt ) && !( self [[ self.custom_buildablestub_update_prompt ]]( player ) ) )
	{
		return 0;
	}

	self.cursor_hint = "HINT_NOICON";
	self.cursor_hint_weapon = undefined;
	if ( isDefined( self.built ) && !self.built )
	{
		slot = self.buildablestruct.buildable_slot;
		piece = self.buildablezone.pieces[0];
		player maps/mp/zombies/_zm_buildables::player_set_buildable_piece(piece, slot);

		if ( !isDefined( player maps/mp/zombies/_zm_buildables::player_get_buildable_piece( slot ) ) )
		{
			if ( isDefined( level.zombie_buildables[ self.equipname ].hint_more ) )
			{
				self.hint_string = level.zombie_buildables[ self.equipname ].hint_more;
			}
			else
			{
				self.hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
			}
			return 0;
		}
		else
		{
			if ( !self.buildablezone maps/mp/zombies/_zm_buildables::buildable_has_piece( player maps/mp/zombies/_zm_buildables::player_get_buildable_piece( slot ) ) )
			{
				if ( isDefined( level.zombie_buildables[ self.equipname ].hint_wrong ) )
				{
					self.hint_string = level.zombie_buildables[ self.equipname ].hint_wrong;
				}
				else
				{
					self.hint_string = &"ZOMBIE_BUILD_PIECE_WRONG";
				}
				return 0;
			}
			else
			{
				if ( isDefined( level.zombie_buildables[ self.equipname ].hint ) )
				{
					self.hint_string = level.zombie_buildables[ self.equipname ].hint;
				}
				else
				{
					self.hint_string = "Missing buildable hint";
				}
			}
		}
	}
	else
	{
		if ( self.persistent == 1 )
		{
			if ( maps/mp/zombies/_zm_equipment::is_limited_equipment( self.weaponname ) && maps/mp/zombies/_zm_equipment::limited_equipment_in_use( self.weaponname ) )
			{
				self.hint_string = &"ZOMBIE_BUILD_PIECE_ONLY_ONE";
				return 0;
			}

			if ( player has_player_equipment( self.weaponname ) )
			{
				self.hint_string = &"ZOMBIE_BUILD_PIECE_HAVE_ONE";
				return 0;
			}

			self.hint_string = self.trigger_hintstring;
		}
		else if ( self.persistent == 2 )
		{
			if ( !maps/mp/zombies/_zm_weapons::limited_weapon_below_quota( self.weaponname, undefined ) )
			{
				self.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
				return 0;
			}
			else
			{
				if ( isDefined( self.bought ) && self.bought )
				{
					self.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
					return 0;
				}
			}
			self.hint_string = self.trigger_hintstring;
		}
		else
		{
			self.hint_string = "";
			return 0;
		}
	}
	return 1;
}

buildablestub_build_succeed()
{
	self notify("buildablestub_build_succeed");
	self endon("buildablestub_build_succeed");

	self waittill( "build_succeed" );

	self.stub maps/mp/zombies/_zm_buildables::buildablestub_remove();
	arrayremovevalue(level.buildables_available, self.stub.buildablezone.buildable_name);
	if (level.buildables_available.size == 0)
	{
		foreach (stub in level.buildable_stubs)
		{
			switch(stub.equipname)
			{
				case "turbine":
				case "subwoofer_zm":
				case "springpad_zm":
				case "headchopper_zm":
					maps/mp/zombies/_zm_unitrigger::unregister_unitrigger(stub);
					break;
			}
		}
	}
}

choose_open_buildable( player )
{
	self endon( "kill_choose_open_buildable" );

	n_playernum = player getentitynumber();
	b_got_input = 1;
	hinttexthudelem = newclienthudelem( player );
	hinttexthudelem.alignx = "center";
	hinttexthudelem.aligny = "middle";
	hinttexthudelem.horzalign = "center";
	hinttexthudelem.vertalign = "bottom";
	hinttexthudelem.y = -100;
	hinttexthudelem.foreground = 1;
	hinttexthudelem.font = "default";
	hinttexthudelem.fontscale = 1;
	hinttexthudelem.alpha = 1;
	hinttexthudelem.color = ( 1, 1, 1 );
	hinttexthudelem settext( "Press [{+actionslot 1}] or [{+actionslot 2}] to change item" );

	if (!isDefined(self.buildables_available_index))
	{
		self.buildables_available_index = 0;
	}

	while ( isDefined( self.playertrigger[ n_playernum ] ) && !self.built )
	{
		if (!player isTouching(self.playertrigger[n_playernum]))
		{
			hinttexthudelem.alpha = 0;
			wait 0.05;
			continue;
		}

		hinttexthudelem.alpha = 1;

		if ( player actionslotonebuttonpressed() )
		{
			self.buildables_available_index++;
			b_got_input = 1;
		}
		else
		{
			if ( player actionslottwobuttonpressed() )
			{
				self.buildables_available_index--;

				b_got_input = 1;
			}
		}

		if ( self.buildables_available_index >= level.buildables_available.size )
		{
			self.buildables_available_index = 0;
		}
		else
		{
			if ( self.buildables_available_index < 0 )
			{
				self.buildables_available_index = level.buildables_available.size - 1;
			}
		}

		if ( b_got_input )
		{
			piece = undefined;
			foreach (stub in level.buildable_stubs)
			{
				if (stub.buildablezone.buildable_name == level.buildables_available[self.buildables_available_index])
				{
					piece = stub.buildablezone.pieces[0];
					break;
				}
			}
			slot = self.buildablestruct.buildable_slot;
			player maps/mp/zombies/_zm_buildables::player_set_buildable_piece(piece, slot);

			self.equipname = level.buildables_available[self.buildables_available_index];
			self.hint_string = level.zombie_buildables[self.equipname].hint;
			self.playertrigger[n_playernum] sethintstring(self.hint_string);
			b_got_input = 0;
		}

		if ( player is_player_looking_at( self.playertrigger[n_playernum].origin, 0.76 ) )
		{
			hinttexthudelem.alpha = 1;
		}
		else
		{
			hinttexthudelem.alpha = 0;
		}

		wait 0.05;
	}

	hinttexthudelem destroy();
}

pooledbuildable_has_piece( piece )
{
	return isDefined( self pooledbuildable_stub_for_piece( piece ) );
}

pooledbuildable_stub_for_piece( piece )
{
	foreach (stub in self.stubs)
	{
		if ( !isDefined( stub.bound_to_buildable ) )
		{
			if ( stub.buildablezone maps/mp/zombies/_zm_buildables::buildable_has_piece( piece ) )
			{
				return stub;
			}
		}
	}

	return undefined;
}

AllBoxLocations()
{
	foreach(box in level.chests)
	{
		box thread maps/mp/zombies/_zm_magicbox::show_chest();
	}
	self iPrintln("MysteryBox is everywhere now!");
}
BoxStays()
{
  self endon("disconnect");
  if( getDvar( "magic_chest_movable" ) == "1" )
  {
  setdvar( "magic_chest_movable", "0" );
  self iPrintln("Mystery Box Can't Move");
  }
  else if( getDvar( "magic_chest_movable" ) == "0" )
  {
  setdvar( "magic_chest_movable", "1" );
  self iPrintln("Mystery Box Can Move");
  }
}
RespawnSpec()
{
	players = get_players();
	foreach(player in players)
	{
		if(player.sessionstate == "spectator")
		{
			if(isdefined(player.spectate_hud))
			{
				player.spectate_hud destroy();
			}
			player [[level.spawnplayer]]();
		}
	}
	self iprintln("Spectators have been spawned!");
}
RapidFire()
{
	if(self.RapidFire==false)
	{
		self.RapidFire=true;
		setdvar("perk_weapRateMultiplier", "0.001");
		setdvar("perk_weapReloadMultiplier", "0.001");
		setdvar("perk_fireproof", "0.001");
		setdvar("cg_weaponSimulateFireAnims", "0.001");
		foreach(p in level.players)
		{
			p setperk("specialty_rof");
			p setperk("specialty_fastreload");
		}
		self iprintln("Rapid Fire [^2ON^7]!");
	}
	else
	{
		self.RapidFire=false;
		setdvar("perk_weapRateMultiplier", "1");
		setdvar("perk_weapReloadMultiplier", "1");
		setdvar("perk_fireproof", "1");
		setdvar("cg_weaponSimulateFireAnims", "1");
		self iprintln("Rapid Fire [^1OFF^7]!");
	}
}
NoLavaDamage()
{
	foreach(p in level.players)
	{
		p notify("stop_flame_damage");
		p.is_burning = 1;
		p maps/mp/_visionset_mgr::vsmgr_deactivate("overlay", "zm_transit_burn", p);
	}
	self iprintln("No Lava Damage!");
}
weapondrop()
{
	if( self getcurrentweapon() == "defaultweapon_mp" )
	{
		self iprintln("^1You cant drop this Item!");
	}
	self iprintln("You droped ^2" + self getcurrentweapon());
	self dropitem( self getcurrentweapon() );
}
doPerks(a)
{
	self maps/mp/zombies/_zm_perks::give_perk(a);
	self iPrintln("Perk: "+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]+" ^2Given");
}
dogiveperk(perk)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self endon("perk_abort_drinking");
	if(!self hasperk(perk) || self maps/mp/zombies/_zm_perks::has_perk_paused(perk))
	{
		gun = self maps/mp/zombies/_zm_perks::perk_give_bottle_begin(perk);
		evt = self waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete");
		if(evt == "weapon_change_complete")
		{
			self thread maps/mp/zombies/_zm_perks::wait_give_perk(perk, 1);
		}
		self maps/mp/zombies/_zm_perks::perk_give_bottle_end(gun, perk);
		if(self maps/mp/zombies/_zm_laststand::player_is_in_laststand() || isdefined(self.intermission) && self.intermission)
		{
			return;
		}
		self notify("burp");
	}
}
giveallperks()
{
	if(isdefined(level.zombiemode_using_juggernaut_perk) && level.zombiemode_using_juggernaut_perk)
	{
		self dogiveperk("specialty_armorvest");
	}
	if(isdefined(level.zombiemode_using_sleightofhand_perk) && level.zombiemode_using_sleightofhand_perk)
	{
		self dogiveperk("specialty_fastreload");
	}
	if(isdefined(level.zombiemode_using_revive_perk) && level.zombiemode_using_revive_perk)
	{
		self dogiveperk("specialty_quickrevive");
	}
	if(isdefined(level.zombiemode_using_doubletap_perk) && level.zombiemode_using_doubletap_perk)
	{
		self dogiveperk("specialty_rof");
	}
	if(isdefined(level.zombiemode_using_marathon_perk) && level.zombiemode_using_marathon_perk)
	{
		self dogiveperk("specialty_longersprint");
	}
	if(isdefined(level.zombiemode_using_additionalprimaryweapon_perk) && level.zombiemode_using_additionalprimaryweapon_perk)
	{
		self dogiveperk("specialty_additionalprimaryweapon");
	}
	if(isdefined(level.zombiemode_using_deadshot_perk) && level.zombiemode_using_deadshot_perk)
	{
		self dogiveperk("specialty_deadshot");
	}
	if(isdefined(level.zombiemode_using_tombstone_perk) && level.zombiemode_using_tombstone_perk)
	{
		self dogiveperk("specialty_scavenger");
	}
	if(isdefined(level._custom_perks) && isdefined(level._custom_perks["specialty_flakjacket"]) && level.script != "zm_buried")
	{
		self dogiveperk("specialty_flakjacket");
	}
	if(isdefined(level._custom_perks) && isdefined(level._custom_perks["specialty_nomotionsensor"]))
	{
		self dogiveperk("specialty_nomotionsensor");
	}
	if(isdefined(level._custom_perks) && isdefined(level._custom_perks["specialty_grenadepulldeath"]))
	{
		self dogiveperk("specialty_grenadepulldeath");
	}
	if(isdefined(level.zombiemode_using_chugabud_perk) && level.zombiemode_using_chugabud_perk)
	{
		self dogiveperk("specialty_finalstand");
	}
	self iPrintln("All Perks ^1Given");
}
removeallperks()
{
	self notify("specialty_armorvest_stop");
	self notify("specialty_fastreload_stop");
	self notify("specialty_quickrevive_stop");
	self notify("specialty_rof_stop");
	self notify("specialty_longersprint_stop");
	self notify("specialty_additionalprimaryweapon_stop");
	self notify("specialty_deadshot_stop");
	self notify("specialty_scavenger_stop");
	self notify("specialty_flakjacket_stop");
	self notify("specialty_nomotionsensor_stop");
	self notify("specialty_grenadepulldeath_stop");
	self notify("specialty_finalstand_stop");
	self iPrintln("All Perks ^1Removed");
}
player_take_piece(piecespawn)
{
	piecestub = piecespawn.piecestub;
	damage = piecespawn.damage;
	if(isdefined(piecestub.onpickup))
	{
		piecespawn [[piecestub.onpickup]](self);
	}
	if(isdefined(piecestub.is_shared) && piecestub.is_shared)
	{
		if(isdefined(piecestub.client_field_id))
		{
			level setclientfield(piecestub.client_field_id, 1);
		}
	}
	else if(isdefined(piecestub.client_field_state))
	{
		self setclientfieldtoplayer("craftable", piecestub.client_field_state);
	}
	piecespawn notify("pickup");
	if(isdefined(piecestub.is_shared) && piecestub.is_shared)
	{
		piecespawn.in_shared_inventory = 1;
	}
	else
	{
		self.current_craftable_piece = piecespawn;
	}
}
GivePowerUp(powerup_name)
{
    if (!isDefined(level.zombie_include_powerups) || (!(level.zombie_include_powerups.size > 0)))     
        self iprintln("Power Ups ^1Not Supported ^7On This Map");
    else
    {
        level.powerup_drop_count = 0;
        powerup = level maps/mp/zombies/_zm_powerups::specific_powerup_drop(powerup_name, self.origin);
        if (powerup_name == "teller_withdrawl")
            powerup.value = 1000;
        powerup thread maps/mp/zombies/_zm_powerups::powerup_timeout();
        self iprintln("PowerUps (" + powerup_name + ") ^2Gived^7");
    }
}
doPNuke()
{
	foreach(player in level.players)
	{
		level thread maps\mp\zombies\_zm_powerups::nuke_powerup(self,player.team);
		player maps\mp\zombies\_zm_powerups::powerup_vo("nuke");
		zombies=getaiarray(level.zombie_team);
		player.zombie_nuked=arraysort(zombies,self.origin);
		player notify("nuke_triggered");
	}
	self iPrintln("Nuke Bomb ^2Sent");
}
doPMAmmo()
{
	foreach(player in level.players)
	{
		level thread maps\mp\zombies\_zm_powerups::full_ammo_powerup(self,player);
		player thread maps\mp\zombies\_zm_powerups::powerup_vo("full_ammo");
	}
	self iPrintln("Max Ammo ^2Sent");
}
doPDoublePoints()
{
	foreach(player in level.players)
	{
		level thread maps\mp\zombies\_zm_powerups::double_points_powerup(self,player);
		player thread maps\mp\zombies\_zm_powerups::powerup_vo("double_points");
	}
	self iPrintln("Double Points ^2Sent");
}
doPInstaKills()
{
	foreach(player in level.players)
	{
		level thread maps\mp\zombies\_zm_powerups::insta_kill_powerup(self,player);
		player thread maps\mp\zombies\_zm_powerups::powerup_vo("insta_kill");
	}
	self iPrintln("Insta Kill ^2Sent");
}
doPInstaKills()
{
	foreach(player in level.players)
	{
		level thread maps\mp\zombies\_zm_powerups::insta_kill_powerup(self,player);
		player thread maps\mp\zombies\_zm_powerups::powerup_vo("insta_kill");
	}
	self iPrintln("Insta Kill ^2Sent");
}
doPRandomWeapon()
{
	foreach(player in level.players)
	{
		level thread maps\mp\zombies\_zm_powerups::random_weapon_powerup(self,player);
		player thread maps\mp\zombies\_zm_powerups::powerup_vo("random_weapon");
	}
	self iPrintln("Free Perk ^2Sent");
}
doNoSpawnZombies()
{
	if(self.SpawnigZombroz==false)
	{
		self.SpawnigZombroz=true;
		if(isDefined(flag_init("spawn_zombies", 0)))
		flag_init("spawn_zombies",0);
		self thread ZombieKill();
		self iPrintln("Disable Zombies [^2ON^7]");
	}
	else
	{
		self.SpawnigZombroz=false;
		if(isDefined(flag_init("spawn_zombies", 1)))
		flag_init("spawn_zombies",1);
		self thread ZombieKill();
		self iPrintln("Disable Zombies [^1OFF^7]");
	}
}
PlayerFrezeControl()
{
	player=level.players[self.Menu.System["ClientIndex"]];
	if(player isHost())
	{
		self iPrintln("You can't freeze the host!");
	}
	else
	{
		if(self.fronzy==false)
		{
			self.fronzy=true;
			self iPrintln("^2Frozen: ^7"+player.name);
			player freezeControls(true);
		}
		else
		{
			self.fronzy=false;
			self iPrintln("^1Unfrozen: ^7"+player.name);
			player freezeControls(false);
		}
	}
}
doTeleportAllToMe()
{
	foreach(player in level.players)
	{
		if(player isHost())
		{
		}
		else
		{
			player SetOrigin(self.origin);
		}
	}
	self iPrintln("^2Teleported All to Me");
}
doFreeAllPosition()
{
	foreach(player in level.players)
	{
		if(player isHost())
		{
		}
		else
		{
			if(self.fronzya==false)
			{
self.fronzya=true;
self iPrintln("^2Frozen: ^7"+player.name);
player freezeControls(true);
			}
			else
			{
self.fronzya=false;
self iPrintln("^1Unfrozen: ^7"+player.name);
player freezeControls(false);
			}
		}
	}
}
doReviveAlls()
{
	foreach(player in level.players)
	{
		if(player isHost())
		{
		}
		else
		{
			self iPrintln("^1 "+player.name+" ^7Revive ^1!");
			player notify ("player_revived");
			player reviveplayer();
			player.revivetrigger delete();
			player.revivetrigger=undefined;
			player.ignoreme=false;
			player allowjump(1);
			player.laststand=undefined;
		}
	}
}
doMenuCenter()
{
	self.Menu.Material["Background"] elemMoveX(1,-90);
	self.Menu.Material["Scrollbar"] elemMoveX(1,-90);
	self.Menu.Material["BorderMiddle"] elemMoveX(1,-90);
	self.Menu.Material["BorderLeft"] elemMoveX(1,-91);
	self.Menu.Material["BorderRight"] elemMoveX(1,150);
	self.Menu.System["Title"] elemMoveX(1,-85);
	self.Menu.System["Texte"] elemMoveX(1,-85);
	self.textpos=-85;
	self iPrintln("Menu alling ^2center");
}
doAllKickPlayer()
{
	foreach(player in level.players)
	{
		if(player isHost())
		{
		}
		else
		{
			kick(player getEntityNumber());
		}
		self iPrintln("All Players ^1Kicked");
	}
}
doPlaySounds(i)
{
	self playsound(i);
	self iPrintln("Sound ^1"+self.Menu.System["MenuTexte"][self.Menu.System["MenuRoot"]][self.Menu.System["MenuCurser"]]+" ^2Played");
}
fastZombies()
{
	if(!isDefined(level.fastZombies))
	{
		if(isDefined(level.slowZombies)) level.slowZombies=undefined;
		level.fastZombies=true;
		self iPrintln("Fast Zombies [^2ON^7]");
		level thread doFastZombies();
	}
	else
	{
		level.fastZombies=undefined;
		self iPrintln("Fast Zombies [^1OFF^7]");
	}
}
doFastZombies()
{
	while(isDefined(level.fastZombies))
	{
		zom=getAiArray("axis");
		for(m=0;m<zom.size;m++) zom[m].run_combatanim=level.scr_anim["zombie"]["sprint"+randomIntRange(1,2)];
		wait .05;
	}
}
slowZombies()
{
	if(!isDefined(level.slowZombies))
	{
		if(isDefined(level.fastZombies)) level.fastZombies=undefined;
		level.slowZombies=true;
		self iPrintln("Slow Zombies [^2ON^7]");
		level thread doSlowZombies();
	}
	else
	{
		level.slowZombies=undefined;
		self iPrintln("Slow Zombies [^1OFF^7]");
	}
}
doSlowZombies()
{
	while(isDefined(level.slowZombies))
	{
		zom=getAiArray("axis");
		for(m=0;m<zom.size;m++) zom[m].run_combatanim=level.scr_anim["zombie"]["walk"+randomIntRange(1,4)];
		wait .05;
	}
}
packcurrentweapon_nzv( get_accessorie )
{
	gun = self getcurrentweapon();
	weapon = gun;
	if( self can_upgrade_weapon( weapon ) )
	{
		if( get_accessorie && IsDefined( get_accessorie ) )
		{
			weapon = self get_upgrade_weapon( weapon, 1 );
		}
		else
		{
			if( self is_weapon_upgraded( weapon ) )
			{
				weapon = self get_base_name( weapon );
			}
			else
			{
				weapon = self get_upgrade_weapon( weapon, 0 );
			}
		}
		if( weapon != "none" && IsDefined( weapon ) )
		{
			self play_sound_on_ent( "purchase" );
			self takeweapon( gun );
			unacquire_weapon_toggle( gun );
			self disable_player_move_states( 1 );
			self giveweapon( "zombie_knuckle_crack" );
			self switchtoweapon( "zombie_knuckle_crack" );
			self waittill_any( "player_downed", "weapon_change_complete" );
			self enable_player_move_states();
			self takeweapon( "zombie_knuckle_crack" );
			self weapon_give( weapon, 1, undefined, 0 );
			self iprintln( "[^2Pack A Punch^7] Weapon: " + get_weapon_display_name( weapon ) );
		}
		else
		{
			self iprintln("^7Unknown Weapon");
		}
	}
	else
	{
		if( self is_weapon_upgraded( weapon ) )
		{
			self iprintln( "^7Current Weapon [" + ( get_weapon_display_name( weapon ) + "] Can't Be Pack-A-Punch'd Again" ) );
		}
		else
		{
			self iprintln("^7Current Weapon [" + ( get_weapon_display_name( weapon ) + "] Can't Be Pack-A-Punch'd"));
		}
	}

}
unpackcurrentweapon_nzv()
{
	gun = self getcurrentweapon();
	weapon = gun;
	if( self is_weapon_upgraded( weapon ) )
	{
		weapon = self get_base_weapon_name( gun, 1 );
		if( weapon != "none" && IsDefined( weapon ) )
		{
			self play_sound_on_ent( "purchase" );
			self takeweapon( gun );
			unacquire_weapon_toggle( gun );
			self disable_player_move_states( 1 );
			self giveweapon( "zombie_knuckle_crack" );
			self switchtoweapon( "zombie_knuckle_crack" );
			self waittill_any( "player_downed", "weapon_change_complete" );
			self enable_player_move_states();
			self takeweapon( "zombie_knuckle_crack" );
			self weapon_give( weapon, undefined, undefined, 0 );
			self iprintln( "[^1Unpack A Punch^7] Weapon: " + get_weapon_display_name( weapon ) );
		}
		else
		{
			self iprintln("^7Unknown Weapon");
		}
	}
	else
	{
		self iprintln( "^7Current Weapon [" + ( get_weapon_display_name( weapon ) + "] Is Not Upgraded"));
	}

}
Give_Shovel()
{
    if((level.script == "zm_tomb") && isDefined(self.dig_vars))
    {
        self play_sound_on_ent("purchase");
        self.dig_vars["has_shovel"] = 1;
        self.dig_vars["n_spots_dug"] = 0;
        self.dig_vars["has_upgraded_shovel"] = 0;
        n_player = self getentitynumber() + 1;
        level setclientfield("shovel_player" + n_player, 1);
    }
}
Give_GoldenShovel()
{
    if((level.script == "zm_tomb") && isDefined(self.dig_vars))
    {
        self play_sound_on_ent("purchase");
        self.dig_vars["has_shovel"] = 1;
        self.dig_vars["n_spots_dug"] = 64;
        self.dig_vars["has_upgraded_shovel"] = 1;
        n_player = self getentitynumber() + 1;
        level setclientfield( "shovel_player" + n_player, 2);
        self playsoundtoplayer("zmb_squest_golden_anything", self);
    }
}
dogoldhelmet()
{
  self endon("disconnect");
  setdvar( "give_helmet", "on" );
  _a1153 = getplayers();
  _k1153 = getFirstArrayKey( _a1153 );
  while ( isDefined( _k1153 ) )
  {
  player = _a1153[ _k1153 ];
  player.dig_vars[ "has_helmet" ] = 1;
  n_player = player getentitynumber() + 1;
  level setclientfield( "helmet_player" + n_player, 1 );
  _k1153 = getNextArrayKey( _a1153, _k1153 );
  }
  self iPrintln("^2Golden Helmet ^1Given");
}
dorestartgame()
{
	self iprintln("Restarting Game in a few seconds");
	wait 3;
	map_restart( 0 );

}
doendgame()
{
	self iprintln("Ending Current Game");
	level notify( "end_game" );

}
EasterEggSong()
{
    self playsound( "mus_zmb_secret_song" );
    self iprintlnbold( "Easter Egg Song ^2Played" );
}
EasterEggSong2()
{
    self playsound( "mus_zmb_secret_song_2" );
    self iprintlnbold( "Easter Egg Song #2 ^2Played" );
}
OriginsSong2()
{
    self playsound( "mus_zmb_secret_song_a7x" );
    self iprintlnbold( "Easter Egg Song ^2Played" );
}
OriginsSong3()
{
    self playsound( "mus_zmb_secret_song_aether" );
    self iprintlnbold( "Easter Egg Song ^2Played" );
}
NukedSong1()
{
    self playsound( "zmb_nuked_song_1" );
    self iprintlnbold( "Easter Egg Song ^2Played" );
}
NukedSong2()
{
    self playsound( "zmb_nuked_song_2" );
    self iprintlnbold( "Easter Egg Song ^2Played" );
}
NukedSong3()
{
    self playsound( "zmb_nuked_song_3" );
    self iprintlnbold( "Easter Egg Song ^2Played" );
}

// Tranzit Coords
teleportToBus()
{
   self setOrigin(level.the_bus localToWorldCoords((0, 0, 25)));
}
teleporttoBusStop()
{
    teleportPlayer(self, (-6359.23, 5606.84, -43.793), (0, -140.625, 0));
}
teleporttoTunnel()
{
    teleportPlayer(self, (-11475, -2321, 200), (0, -61.3421, 0));
}
teleporttoDiner()
{
    teleportPlayer(self, (-5010, -7189, -57), (0, -156.648, 0));
}
teleportToDinerRoof()
{
    teleportPlayer(self, (-6377.36, -8004.36, 148.125), (0, 29.8943, 0));
}
teleporttoFarm()
{
    teleportPlayer(self, (8497.75, -5459.58, 47.8724), (0, -157.187, 0));
}
teleporttoNach()
{
    teleportPlayer(self, (13781, -1013, -185), (0, -119.652, 0));
}
teleporttoCornField()
{
    teleportPlayer(self, (10165.7, -1739.5, -219.201), (0, 102.272, 0));
}
teleporttoPowerStation()
{
    teleportPlayer(self, (11361.3, 7925.06, -537.939), (0, -147.047, 0));
}
teleporttoTown()
{
    teleportPlayer(self, (1167.49, -851.359, -55.875), (0, 75.487, 0));
}
teleportToHuntersCabin()
{
    teleportPlayer(self, (5385.36, 7064.36, -26.117), (0, -147.8, 0));
}
teleportToPackAPunchRoom()
{
    teleportPlayer(self, (1126.64, 1148.86, -303.875), (0, -87.1555, 0));
}

// Buried Coords
teleporttoBuriedSpawn()
{
    teleportPlayer(self, (-2689.08, -761.858, 1360.13), (0, 89.5203, 0));
}
teleporttoBuriedUnderGround()
{
    teleportPlayer(self, (-957.409, -351.905, 288.125), (0, -1.7761, 0));
}
teleporttoBankHouse()
{
    teleportPlayer(self, (-386.859, -243.884, 8.125), (0, 88.8611, 0));
}
teleporttoLeroyCell()
{
    teleportPlayer(self, (-1081.72, 830.04, 8.125), (0, -89.7766, 0));
}
teleporttoBarSaloon()
{
    teleportPlayer(self, (790.854, -1433.25, 56.125), (0, 140.645, 0));
}
teleporttoBuriedPower()
{
    teleportPlayer(self, (710.08, -591.387, 143.443), (0, 140.645, 0));
}
teleporttoBuriedChurch()
{
    teleportPlayer(self, (1532.91, 1962.69, 20.5159), (0, 72.442, 0));
}
teleporttoMansion()
{
    teleportPlayer(self, (1751.68, 545.036, -2.21781), (0, 1.16274, 0));
}
teleporttoMazeEnter()
{
    teleportPlayer(self, (3939.1, 584.876, 4.125), (0, -0.402809, 0));
}
teleporttoMazeExit()
{
    teleportPlayer(self, (5810, 571.574, 4.125), (0, 0.921043, 0));
}
teleporttoBuriedPac()
{
    teleportPlayer(self, (6410.24, 768.373, -132.351), (0, 138.662, 0));
}

// Origins
teleporttoTank()
{
    teleportPlayer(self, (160.635, -2755.65, 43.5474), (0, 12.9749, 0));
}
teleporttoTank2()
{
    teleportPlayer(self, (-86.3847, 4654.54, -288.052), (0, -178.198, 0));
}
teleporttoNoMansLand()
{
    teleportPlayer(self, (-760.179, 1121.94, 119.175), (0, -68.9996, 0));
}
teleporttoChurch()
{
    teleportPlayer(self, (459.258, -2644.85, 365.342), (0, -28.8776, 0));
}
teleporttoGen1()
{
    teleportPlayer(self, (2170.5, 4660.37, -299.875), (0, 90.5823, 0));
}
teleporttoGen2()
{
    teleportPlayer(self, (-356.707, 3579.11, -291.875), (0, -88.5004, 0));
}
teleporttoGen3()
{
    teleportPlayer(self, (518.721, 2500.87, -121.875), (0, -87.616, 0));
}
teleporttoGen4()
{
    teleportPlayer(self, (2372.42, 101.088, 120.125), (0,  91.4063, 0));
}
teleporttoGen5()
{
    teleportPlayer(self, (-2493.36, 178.245, 236.625), (0, -179.055, 0));
}
teleporttoGen6()
{
    teleportPlayer(self, (952.098, -3554.39, 306.125), (0, -88.1927, 0));
}
teleporttoCrazyPlaceAir()
{
    teleportPlayer(self, (11285.9, -8679.08, -407.875), (0, 149.266, 0));
}
teleporttoCrazyPlaceFire()
{
    teleportPlayer(self, (9429.59, -8560.03, -397.875), (0, 8.6023, 0));
}
teleporttoCrazyPlaceIce()
{
    teleportPlayer(self, (11242.1, -7033.06, -345.875), (0, -139.235, 0));
}
teleporttoCrazyPlaceLightning()
{
    teleportPlayer(self, (9621.84, -6989.4, -345.875), (0, -89.2969, 0));
}
teleporttoStaffRoom()
{
    teleportPlayer(self, (-3.77959, 7.99695, -751.875), (0, 88.8245, 0));
}
teleporttoOriginsPAP()
{
    teleportPlayer(self, (-199.079, -11.0947, 320.125), (0, 1.12611, 0));
}

// MOTD Coords
teleporttoSpawn()
{
    teleportPlayer(self, (1226, 10597, 1336), (0, -178.72, 0));
}
teleporttoStairCase()
{
    teleportPlayer(self, (114.84, 8122.72, 276.125), (0, 72.0656, 0));
}
teleporttoHarbor()
{
    teleportPlayer(self, (-425, 5418, -71), (0, 174.804, 0));
}
teleporttoDog1()
{
    teleportPlayer(self, (826.87, 9672.88, 1443.13), (0, 179.424, 0));
}
teleporttoDog2()
{
    teleportPlayer(self, (3731.16, 9705.97, 1532.84), (0, -2.81724, 0));
}
teleporttoDog3()
{
    teleportPlayer(self, (49.1354, 6093.95, 19.5609), (0, 103.003, 0));
}
teleporttoBridge()
{
    teleportPlayer(self, (-1246, -3497, -8447));
}

// Die Rise Coords
teleporttoHighSpawn()
{
    teleportPlayer(self, (1464.25, 1377.69, 3397.46), (0, -49.442, 0));
}
teleporttoSlide()
{
    teleportPlayer(self, (2084.26, 2573.54, 3050.59), (0, -4.56284, 0));
}
teleporttoBrokenElevator()
{
    teleportPlayer(self, (3700.51, 2173.41, 2575.47), (0, -110.597, 0));
}
teleporttoRedRoom()
{
    teleportPlayer(self, (3176.08, 1426.12, 1298.53), (0, 0.739594, 0));
}
teleporttoBankPower()
{
    teleportPlayer(self, (2614.06, 30.8681, 1296.13), (0,-31.1003, 0));
}
teleporttoRoof()
{
    teleportPlayer(self, (1965.23, 151.344, 2880.13), (0, -120.419, 0));
}
teleporttoMainRoom()
{
    teleportPlayer(self, (2067.99, 1385.92, 3040.13), (0, 89.623, 0));
}
teleporttoHighPac()
{
    teleportPlayer(self, (3156.87, -35.4687, 2527.19), (0, 149.403, 0));
}

// NukeTown Coords
teleporttoNukeBus()
{
    teleportPlayer(self, (-125, 350, -49));
}
teleporttoGreenHouse()
{
    teleportPlayer(self, (-623, 417, -56));
}
teleporttoGreenOffice()
{
    teleportPlayer(self, (-623, 417, 80));
}
teleporttoGreenGarden()
{
    teleportPlayer(self, (-1557, 387, -64));
}
teleporttoGreenGarage()
{
    teleportPlayer(self, (-910, 178, -56));
}
teleporttoYellowHouse()
{
    teleportPlayer(self, (729, 208, -56));
}
teleporttoYellowOffice()
{
    teleportPlayer(self, (729, 208, 80));
}
teleporttoYellowGarden()
{
    teleportPlayer(self, (1585, 389, -63));
}
teleporttoYellowGarage()
{
    teleportPlayer(self, (783, 615, -56.8));
}

//Teleport Player Function
teleportPlayer(player, origin, angles)
{
    player setOrigin(origin);
    player setPlayerAngles(angles);
}
