/* SADX frame counting timer. 
   The in-game time represents the what your time
   would be if there were 60 frames in a second.

   Example: Say your game runs at ~62.5 fps. After 1 minute
   of play, your RTA would be 1 minute, but your IGT would 
   be ~ 1 minute 2.5 seconds. This means having a higher 
   framerate does not give you any advantage over others
   in terms of IGT.
   
   As of now, this timer does not split for you, but that
   could of course be added on by merging this code 
   with the existing autosplitter.
   
   During cutscenes, the game runs at half the framerate, 
   so this timer adds double the frames when in cutscenes.
   
   This version tracks you IGT accurately even when playing
   the game at a lower display refresh rate, either from the config
   editor's "Frame Rate" option set to Low or Normal, from 
   options for your GPU, or just the computer being under stress.
   
   However, the address used to track the IGT like this does not 
   increase during various parts of the game, specifically during 
   pausing, title screen, etc., so the IGT increases by RTA during 
   these moments.
   
   The address used to track the IGT does not increase during
   credits either, but counting by RTA during credits is not 
   a good idea, so instead each characters credits IGT has been
   pre-calculated, and is added roughly 1 minute into their 
   credits. This allows for categories that skip the credits to
   not have the credits IGT added, yet also allows categories
   that do watch the credits to have the IGT added.
   
   
   Version 3 BETA */

state("sonic")
{
	int globalFrameCount: 0x0372C6C8; //0x03B2C6C8-0x00400000 //directly tied to game speed, but freezes when pausing
	int inCutscene: 0x0372C55C;//0x03B2C55C-0x00400000
	byte gameStatus: 0x03722DE4;//0x03B22DE4-0x00400000
	byte gameMode: 0x036BDC7C; //0x03ABDC7C-0x00400000
	int inPrerenderedMovie: 0x0368B0D0;//0x03A8B0D0-0x00400000
	byte currCharacter: 0x03722DC0;//0x03B22DC0-0x00400000
	byte lastStory: 0x03718DB4; //0x03B18DB4-0x00400000 //needed to distinguish between sonic/super sonic credits
	byte timerStart: 0x00512DF0;
	byte demoPlaying : 0x0372A2E4;
	byte bossHealth:  0x03858150;
	byte level: 0x03722DCC;
	byte levelCopy : 0x03722DC4;
	byte act : 0x03722DEC;
	byte lives : 0x370EF34;
	byte e101Flag : 0x037189A8;
	byte adventureData : 0x037183F0;
	byte rmFlag : 0x037189A5;
	byte mk2Value : 0x0386C760;
	byte AngelCutscene : 0x03883D08;
	byte selectedCharacter : 0x0372A2FD;
	byte music : 0x0512698;
	byte lwFlag : 0x0371892A;

	byte17 emblemBytes: 0x0372B5E8;
	byte353 eventBytes: 0x03718888;
	
	byte lightshoes : "sonic.exe", 0x3718895;
	byte crystalring : "sonic.exe", 0x3718896;
	byte ancientlight : "sonic.exe", 0x37188A7;
	byte jetanklet : "sonic.exe", 0x37188D5;
	byte rhythmbadge : "sonic.exe", 0x37188E3;
	byte shovelclaw : "sonic.exe", 0x3718921;
	byte fightinggloves : "sonic.exe", 0x3718922;
	byte warriorfeather : "sonic.exe", 0x371895A;
	byte longhammer : "sonic.exe", 0x3718966;
	byte lifebelt : "sonic.exe", 0x37189D8;
	byte powerrod : "sonic.exe", 0x37189D9;
	byte lureec : "sonic.exe", 0x37189E6;
	byte lureic : "sonic.exe", 0x37189E7;
	byte luress : "sonic.exe", 0x37189E8;
	byte luremr : "sonic.exe", 0x37189E9;
	byte jetbooster : "sonic.exe", 0x3718991;
	byte laserblaster : "sonic.exe", 0x3718992;
}

state("Sonic Adventure DX")
{
	int globalFrameCount: 0x0372C6C8; //0x03B2C6C8-0x00400000 //directly tied to game speed, but freezes when pausing
	int inCutscene: 0x0372C55C;//0x03B2C55C-0x00400000
	byte gameStatus: 0x03722DE4;//0x03B22DE4-0x00400000
	byte gameMode: 0x036BDC7C; //0x03ABDC7C-0x00400000
	int inPrerenderedMovie: 0x0368B0D0;//0x03A8B0D0-0x00400000
	byte currCharacter: 0x03722DC0;//0x03B22DC0-0x00400000
	byte lastStory: 0x03718DB4; //0x03B18DB4-0x00400000 //needed to distinguish between sonic/super sonic credits
	byte timerStart: 0x00512DF0;
	byte demoPlaying : 0x0372A2E4;
	byte bossHealth:  0x03858150;
	byte level: 0x03722DCC;
	byte levelCopy : 0x03722DC4;
	byte act : 0x03722DEC;
	byte lives : 0x370EF34;
	byte e101Flag : 0x037189A8;
	byte adventureData : 0x037183F0;
	byte rmFlag : 0x037189A5;
	byte mk2Value : 0x0386C760;
	byte AngelCutscene : 0x03883D08;
	byte selectedCharacter : 0x0372A2FD;
	byte music : 0x0512698;
	byte lwFlag : 0x0371892A;

	byte17 emblemBytes: 0x0372B5E8;
	byte353 eventBytes: 0x03718888;
	
	byte lightshoes : "sonic.exe", 0x3718895;
	byte crystalring : "sonic.exe", 0x3718896;
	byte ancientlight : "sonic.exe", 0x37188A7;
	byte jetanklet : "sonic.exe", 0x37188D5;
	byte rhythmbadge : "sonic.exe", 0x37188E3;
	byte shovelclaw : "sonic.exe", 0x3718921;
	byte fightinggloves : "sonic.exe", 0x3718922;
	byte warriorfeather : "sonic.exe", 0x371895A;
	byte longhammer : "sonic.exe", 0x3718966;
	byte lifebelt : "sonic.exe", 0x37189D8;
	byte powerrod : "sonic.exe", 0x37189D9;
	byte lureec : "sonic.exe", 0x37189E6;
	byte lureic : "sonic.exe", 0x37189E7;
	byte luress : "sonic.exe", 0x37189E8;
	byte luremr : "sonic.exe", 0x37189E9;
	byte jetbooster : "sonic.exe", 0x3718991;
	byte laserblaster : "sonic.exe", 0x3718992;
}

startup
{
	vars.totalFrameCount = 0;
	vars.totalCutsceneRTA = new TimeSpan(0); //For pre-rendered cutscene rta and pausing
	vars.previousRTA = new TimeSpan(0);
	vars.creditsCounter = -1;
	refreshRate = 63;
	vars.bossStarted = false;
	vars.delay = 0;
	
	
	vars.splitMask = new byte[353];
	
	settings.Add("reset",false,"Auto Reset on Main Menu");
	
	settings.Add("stages",true,"Stages NOT To Split");
		settings.Add("36",true,"Sky Chace Act 1","stages");
		settings.Add("37",true,"Sky Chase Act 2","stages");
	
	settings.Add("bosses",true,"Final Boss To Split");
		settings.Add("22",true,"Egg Viper","bosses");//final 
		settings.Add("21",true,"Egg Walker","bosses");//final
		settings.Add("18",true,"Chaos 6","bosses");//final and not final
		settings.Add("23",true,"ZERO","bosses");//final
		settings.Add("25",true,"E-101mkII","bosses");//final
		settings.Add("19",true,"Perfect Chaos","bosses");//final
		
		
	settings.Add("sonicBoss", true, "Sonic Bosses");
		settings.Add("zeroSonic", true, "Chaos 0", "sonicBoss");
		settings.Add("eggHornetSonic", true, "Egg Hornet", "sonicBoss");
		settings.Add("knuxSonic", true, "Knuckles", "sonicBoss");
		settings.Add("fourSonic", true, "Chaos 4", "sonicBoss");
		settings.Add("gammaSonic", true, "Gamma", "sonicBoss");
		settings.Add("sixSonic", true, "Chaos 6", "sonicBoss");

	settings.Add("tailsBoss", true, "Tails Bosses");
		settings.Add("eggHornetTails", true, "Egg Hornet", "tailsBoss");
		settings.Add("knuxTails", true, "Knuckles", "tailsBoss");
		settings.Add("fourTails", true, "Chaos 4", "tailsBoss");
		settings.Add("gammaTails", true, "Gamma", "tailsBoss");	
			
	settings.Add("knucklesBoss", true, "Knuckles Bosses");
		settings.Add("twoKnuckles", true, "Chaos 2", "knucklesBoss");
		settings.Add("sonicKnuckles", true, "Sonic", "knucklesBoss");
		settings.Add("fourKnuckles", true, "Chaos 4", "knucklesBoss");	
		
	settings.Add("gammaBoss", true, "Gamma Bosses");
	settings.CurrentDefaultParent = "gammaBoss";
			settings.Add("E101", false, "E101 BETA");
			settings.Add("sonicGamma", true, "Sonic", "gammaBoss");
			settings.CurrentDefaultParent = null;
			
		settings.Add("MisceKnuckles", false, "Knuckles Miscellaneous");
		settings.CurrentDefaultParent = "MisceKnuckles";
			settings.Add("deathMRKnux", false, "Death Warp Mystic Ruin");
			settings.CurrentDefaultParent = null;	
		
		settings.Add("MisceGamma", false, "Gamma Miscellaneous");
		settings.CurrentDefaultParent = "MisceGamma";
			settings.Add("deathWV", false, "Death Mystic Ruin (Windy Valley Flag)");
			settings.Add("deathMRGamma", false, "Death Warp (Post Red Mountain)");
			settings.Add("eggCarrierMK2", false, "Enter Egg Carrier (Before MKII)");
			settings.CurrentDefaultParent = null;	
			
		settings.Add("MisceSS", false, "Super Sonic Miscellaneous");
		settings.CurrentDefaultParent = "MisceSS";
			settings.Add("AngelIsland", false, "Angel Island Cutscene");
			settings.Add("Tikal", false, "Tikal Cutscene");
			settings.Add("deathSS", false, "Death Warp post Tikal Cutscene");
			settings.Add("jungleSS", false, "Enter Jungle");
			settings.CurrentDefaultParent = null;	
		
	settings.Add("S_Enter", false, "Enter Stage");
	settings.CurrentDefaultParent = "S_Enter";
	settings.Add("EEC", false, "Enter Emerald Coast");
	settings.Add("EWV", false, "Enter Windy Valley");
	settings.Add("EC", false, "Enter Casino");
	settings.Add("EIC", false, "Enter Ice Cap");
	settings.Add("ETP", false, "Enter Twinkle Park");
	settings.Add("ESH", false, "Enter Speed Highway");
	settings.Add("ERM", false, "Enter Red Mountain");
	settings.Add("ESD", false, "Enter Sky Deck");
	settings.Add("ELW", false, "Enter  Lost World");
	settings.Add("EFE", false, "Enter Final Egg");
	settings.Add("EHS", false, "Enter Hot Shelter");
	settings.CurrentDefaultParent = null;		
			
	settings.Add("S_Power", false, "Upgrades");
	settings.CurrentDefaultParent = "S_Power";
	settings.Add("Sonic_Powerup1", false, "Light Speed Shoes");
	settings.Add("Sonic_Powerup2", false, "Crystal Ring");
	settings.Add("Sonic_Powerup3", false, "Ancient Light");
	settings.Add("Tails_Powerup1", false, "Jet Anklet");
	settings.Add("Tails_Powerup2", false, "Rhythm Badge");
	settings.Add("Knux_Powerup1", false, "Shovel Claw");
	settings.Add("Knux_Powerup2", false, "Fighting Gloves");
	settings.Add("Amy_Powerup1", false, "Warrior Feather");
	settings.Add("Amy_Powerup2", false, "Long Hammer");
	settings.Add("Big_Powerup1", false, "Power Rod");
	settings.Add("Big_Powerup2", false, "Life Belt");
	settings.Add("Big_Powerup3", false, "Lure");
	settings.Add("Gamma_Powerup1", false, "Jet Booster");
	settings.Add("Gamma_Powerup2", false, "Laser Blaster");
	settings.CurrentDefaultParent = null;	
	

}

start
{
	vars.totalFrameCount = 0;
	vars.totalCutsceneRTA = new TimeSpan(0); //For pre-rendered cutscene rta and pausing
	vars.previousRTA = new TimeSpan(0);
	vars.creditsCounter = -1;
	vars.delay = 0;
	
	vars.bossStarted = false;
	vars.bossArray = new List<int>();
	vars.ignoredStages = new List<int>();
	vars.finalBosses = new List<int>();
	
	// Splits for final bosses  http://info.sonicretro.org/SCHG:Sonic_Adventure/Level_List
	if (settings["bosses"]){
		if(settings["18"])
			vars.bossArray.Add(18);
		if(settings["21"])
			vars.bossArray.Add(21);
		if(settings["22"])
			vars.bossArray.Add(22);
		if(settings["23"])
			vars.bossArray.Add(23);
	}
	
	// Ignore splits for stages if selected
	if(settings["stages"]){
		if(settings["36"])
			vars.ignoredStages.Add(36);
		if(settings["37"])
			vars.ignoredStages.Add(37);
	}
	
	// tempMask to be assigned to splitMask at the end.
	byte[] tempMask = new byte[vars.splitMask.Length];	// One byte per event
	
	// Other boss splits
	if (settings["sonicBoss"])
	{
		if (settings["gammaSonic"])
			tempMask[36] = 1;
		if (settings["knuxSonic"])
			tempMask[37] = 1;
		if (settings["zeroSonic"])
			tempMask[48] = 1;
		if (settings["fourSonic"])
			tempMask[49] = 1;
		if (settings["sixSonic"])
			tempMask[50] = 1;
		if (settings["eggHornetSonic"])
			tempMask[51] = 1;
	}
	if (settings["tailsBoss"])
	{
		if (settings["gammaTails"])
			tempMask[95] = 1;
		if (settings["knuxTails"])
			tempMask[96] = 1;
		if (settings["fourTails"])
			tempMask[103] = 1;
		if (settings["eggHornetTails"])
			tempMask[105] = 1;
	}
	if (settings["knucklesBoss"])
	{
		if (settings["sonicKnuckles"])
			tempMask[158] = 1;
		if (settings["twoKnuckles"])
			tempMask[163] = 1;
		if (settings["fourKnuckles"])
			tempMask[165] = 1;
	}
	if (settings["gammaBoss"])
	{
		if (settings["sonicGamma"])
			tempMask[282] = 1;
	}

	vars.splitMask = tempMask;
	
	// Split on fade-to-black on story screen
	if (current.demoPlaying != 1 && old.gameStatus == 21 && (current.gameMode != 12 && current.gameMode != 20) && (old.gameMode == 12 || old.gameMode == 20))
		return true;
}

split
{
	//Ignore Stages
	if(vars.ignoredStages.Contains(current.level))
		return false;
	
	// Event split code
	for (int i = 0; i < vars.splitMask.Length; i++)
	{
		if (vars.splitMask[i] == 1 && current.gameStatus != 21 &&
			(current.eventBytes[i] != old.eventBytes[i]))
		{
			print("Event Split");
			return true;
		}
	}
	
	//Big ending
	if(current.inCutscene != 0 && old.inCutscene == 0 && current.level == 29 && current.currCharacter == 7)
		return true;

	//E-101 split
		if (settings["gammaBoss"])
	{
		if (settings["E101"] && current.currCharacter == 6 && current.e101Flag > old.e101Flag) 
		{return true;}
	}
	
	//MKII split
		if (settings["bosses"])
	{
		if (current.level == 25 && current.mk2Value == 255)
		{
			if (settings["25"] && current.bossHealth == 0 && current.timerStart == 0 && old.timerStart == 1)
			{return true;}
		}
		else //perfect Chaos splits
		{ 
			if (current.level == 19)
			{
				if (settings["19"] && current.bossHealth == 0 && old.bossHealth == 2)
				{return true;}
			}
		}
			
	}

	
	//Boss Split timing
	if (vars.bossArray.Contains(current.level))
	{
		// Prevents split at beginning of boss
		if(current.bossHealth == 0 && current.timerStart == 0)
		{
			vars.bossStarted = true;
		}
		// Boss beaten checks
		if(vars.bossStarted && current.inCutscene == 0 && old.inCutscene == 0
			&& current.bossHealth == 0 
			&& current.gameStatus == 15 && current.timerStart == 0 && old.timerStart == 1)
		{
			 if(current.level == 18 && current.currCharacter == 0)
				return false;
			else
				return true;
		}
	}


	//if (current.emblemBytes != old.emblemBytes)
	//	return true;
	byte[] curB = new byte[1];
	curB = current.emblemBytes;
	byte[] oldB = new byte[1];
	oldB = old.emblemBytes;
	
	//Upgrades split
	
	if (settings["S_Power"] && current.level != 0)
	{
		if (settings["Sonic_Powerup1"] && current.lightshoes > old.lightshoes)	{return true;}
		else if (settings["Sonic_Powerup2"] && current.crystalring > old.crystalring)	{return true;}
		else if (settings["Sonic_Powerup3"] && current.ancientlight > old.ancientlight)	{return true;}
		else if (settings["Tails_Powerup1"] && current.jetanklet > old.jetanklet)	{return true;}
		else if (settings["Tails_Powerup2"] && current.rhythmbadge > old.rhythmbadge) 	{return true;}
		else if (settings["Knux_Powerup1"] && current.shovelclaw > old.shovelclaw)	{return true;}
		else if (settings["Knux_Powerup2"] && current.fightinggloves > old.fightinggloves)	{return true;}
		else if (settings["Amy_Powerup1"] && current.warriorfeather > old.warriorfeather) 	{return true;}
		else if (settings["Amy_Powerup2"] && current.longhammer > old.longhammer)	{return true;}
		else if (settings["Big_Powerup1"] && current.powerrod > old.powerrod)	{return true;}
		else if (settings["Big_Powerup2"] && current.lifebelt > old.lifebelt)	{return true;}
		else if (settings["Big_Powerup3"] && (current.luress > old.luress || current.lureic != old.lureic || current.lureec != old.lureec || current.luremr != old.luremr))	{return true;}
		else if (settings["Gamma_Powerup1"] && current.jetbooster > old.jetbooster) 	{return true;}
		else if (settings["Gamma_Powerup2"] && current.laserblaster > old.laserblaster) {return true;}
	}
	
	// enter level split
	
	if (settings["S_Enter"])
	{
		if (settings["EEC"] && current.level == 01 && old.level == 26)	{return true;}
		else if (settings["EWV"] && current.level == 02 && old.level == 33)	{return true;}
		else if (settings["EC"] && current.level == 09 && old.level == 26)	{return true;}
		else if (settings["EIC"] && current.level == 08 && old.level == 33)	{return true;}
		else if (settings["ETP"] && current.level == 03 && old.level == 26)	{return true;}
		else if (settings["ESH"] && current.level == 04 && old.level == 26)	{return true;}
		else if (settings["ERM"] && current.level == 05 && old.level == 33)	{return true;}
		else if (settings["ESD"] && current.level == 06 && old.level == 29)	{return true;}
		else if (settings["ELW"] && current.level == 07 && old.level == 33)	{return true;}
		else if (settings["EFE"] && current.level == 10 && old.level == 33)	{return true;}
		else if (settings["EHS"] && current.level == 12 && old.level == 32)	{return true;}
	}
	
	//Miscellaneous splits 
	if (settings["MisceGamma"])
	{				 
		if (current.level == 33 && current.act == 0) //the condition is split like this, because otherwise too many "&&" make the autosplitter not working for some reason... 
		{
			if (settings["deathWV"] && current.adventureData != old.adventureData && current.currCharacter == 6) {return true;}
		}
		
		if (current.level == 33 && current.act == 1) //the condition is split like this, because otherwise too many "&&" make the autosplitter not working for some reason... 
		{
			if (settings["deathMRGamma"] && current.lives<old.lives && current.currCharacter == 6 && current.adventureData == 2) {return true;}
		}
		
		if (current.level == 29 && old.level == 33 && current.rmFlag == 1)
		{
			if (settings["eggCarrierMK2"] && current.currCharacter == 6) {return true;} 
		}
	}
	
	//Knuckles
		if (settings["MisceKnuckles"])
		{				
			if (current.level == 33 && current.act == 1)
			{
				if (settings["deathMRKnux"] && current.lwFlag == 1 && current.lives<old.lives && current.currCharacter == 3) {return true;}
			}
		}
		
	//Super Sonic
	if (settings["MisceSS"] && current.selectedCharacter == 6)
	{
		if (settings["AngelIsland"] && current.level == 33 && current.act == 1 && current.music == 40 && old.music != 40) {return true;}
		if (settings["Tikal"] && current.level == 33 && old.level == 34) {return true;} // leaving the past
		if (settings["deathSS"] && current.level == 33 && current.act == 1 && current.lives<old.lives) {return true;} // death warp
		if (settings["jungleSS"] && current.level == 33 && old.level != 0 && current.act == 2 && old.act == 0) {return true;} // enter jungle
	}
	
	for (int i = 0; i < curB.Length; i++)
	{
		// Do not check during menus
		if (current.gameMode != 12 && (curB[i] != oldB[i]))
		{
			if(current.level < 15)  //the action stages?
			{
				print("Going to split soon");
				vars.delay = current.globalFrameCount + 190;
			}
			else 
			{
				print("Field Emblem Split");
				return true;
			}
		}
	}
	
	if(Math.Abs(vars.delay - current.globalFrameCount) <= 2 && vars.delay > 0)
	{
		vars.delay = 0;
		print("Action Emblem Split");
		return true;
	}
}

update
{
	TimeSpan? rawRTA = timer.CurrentTime.RealTime;
	TimeSpan currentRTA = new TimeSpan(0);
	if (rawRTA.HasValue)
	{
		currentRTA = new TimeSpan(0).Add(rawRTA.Value);
	}
	
	/* Add RTA to the IGT when the frame counter
		does not increase */
	if (current.inPrerenderedMovie != 0 ||
		current.gameMode == 1 || //Splash logos
		current.gameMode == 12 || //Title + menus
		current.gameMode == 18 || //Story introduction screen
		current.gameMode == 20 || //Instruction
		current.gameStatus == 19 || //Game over screen
		current.gameStatus == 16) //Pause
	{
		vars.totalCutsceneRTA = vars.totalCutsceneRTA.Add(currentRTA-vars.previousRTA);
	}
	
	if (current.gameMode == 22) //Credits
	{
		if (old.gameMode != 22)
		{
			/* Arbitrary delay before frames are added during credits,
				so that categories that skip the credits don't get
				the frames added */
			vars.creditsCounter = 3600;
		}
		
		vars.creditsCounter -= 1;
		
		if (vars.creditsCounter == 0)
		{
			int character = current.currCharacter;
			switch (character)
			{
				case 0: 
					if (current.lastStory == 0)
						vars.totalFrameCount += 16804; //Sonic credits + emblem frame count
					else
						vars.totalFrameCount += 17360; //Super Sonic credits + emblem frame count
					break;
				case 2: vars.totalFrameCount += 14657; break;//Tails credits + emblem frame count
				case 3: vars.totalFrameCount += 16804; break;//Knuckles credits + emblem frame count
				case 5: vars.totalFrameCount += 18950; break;//Amy credits + emblem frame count
				case 6: vars.totalFrameCount += 17545; break;//Gamma credits + emblem frame count
				case 7: vars.totalFrameCount += 15333; break;//Big credits + emblem frame count
				default: break;
			}
		}
	}
	
	int deltaFrames = current.globalFrameCount - old.globalFrameCount;
	
	/* Add twice the amount of time when in a cutscene */
	if (current.inCutscene != 0)
	{
		deltaFrames*=2;
	}
	
	vars.totalFrameCount+=deltaFrames;
	
	vars.previousRTA = new TimeSpan(currentRTA.Ticks);
}


gameTime
{
	return TimeSpan.FromSeconds((vars.totalFrameCount)/60.0)+vars.totalCutsceneRTA;
}

isLoading
{
    return true;
}


reset
{
	if (settings["reset"])
		if(current.gameMode == 12 && old.currCharacter != 6 && current.levelCopy != 32)
			return true;
}
