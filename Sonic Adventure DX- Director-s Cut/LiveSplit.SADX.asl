/* SADX Autosplitter v1.0

   Built off of turtlechuck's IGT script:
   SADX frame counting timer. 
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
	byte bossHealth:  0x03858150;
	byte level: 0x03722DCC;
	byte inDemo: 0x0372A2E4;
	
	byte17 emblemBytes: 0x0372B5E8;
	byte353 eventBytes: 0x03718888;

}

state("Sonic Adventure DX")
{
	int globalFrameCount: 0x0372C6C8; //0x03B2C6C8-0x00400000 //directly tied to game speed, but freezes when pausing
	int inCutscene: 0x0372C55C;//0x03B2C55C-0x00400000
	byte gameStatus: 0x03722DE4;//0x03B22DE4-0x00400000
	byte gameMode: 0x36BDC7C; //0x03ABDC7C-0x00400000
	int inPrerenderedMovie: 0x0368B0D0;//0x03A8B0D0-0x00400000
	byte currCharacter: 0x03722DC0;//0x03B22DC0-0x00400000
	byte lastStory: 0x03718DB4; //0x03B18DB4-0x00400000 //needed to distinguish between sonic/super sonic credits
	byte timerStart: 0x00512DF0;
	byte bossHealth : 0x3858150;
	byte level: 0x3722DCC;
	byte inDemo: 0x0372A2E4;
	
	byte17 emblemBytes: 0x0372B5E8;
	byte353 eventBytes: 0x03718888;
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
	
	settings.Add("reset",true,"Auto Reset on Main Menu");
	
	settings.Add("stages",true,"Stages NOT To Split");
		settings.Add("36",true,"Sky Chace Act 1","stages");
		settings.Add("37",true,"Sky Chase Act 2","stages");
	
	settings.Add("bosses",true,"Final Boss To Split");
		settings.Add("18",true,"Chaos 6","bosses");//final and not final
		settings.Add("19",true,"Perfect Chaos","bosses");//final
		settings.Add("21",true,"Egg Walker","bosses");//final
		settings.Add("22",true,"Egg Viper","bosses");//final 
		settings.Add("23",true,"ZERO","bosses");//final
		settings.Add("25",true,"E-101mkII","bosses");//final
		
		
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
			settings.Add("sonicGamma", true, "Sonic", "gammaBoss");
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
		if(settings["19"])
			vars.bossArray.Add(19);
		if(settings["21"])
			vars.bossArray.Add(21);
		if(settings["22"])
			vars.bossArray.Add(22);
		if(settings["23"])
			vars.bossArray.Add(23);
		if(settings["25"])
			vars.bossArray.Add(25);
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
	if (old.gameStatus == 21 && (current.gameMode != 12 && current.gameMode != 20) && (old.gameMode == 12 || old.gameMode == 20) && current.inDemo != 1)
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
		if(current.gameMode == 12)
			return true;
}