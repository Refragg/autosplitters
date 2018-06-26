// Sonic R 2004 Autosplitter (v1)
// Made by Daily? Edited by IDGeek121

// 2004 release (should work with Sonic R Updater as well)
state("SonicR", "2004")
{
    byte inGame : "SonicR.exe", 0x3356E1;	// 3 is menu, 4 is in-game.
	byte transitionState : "SonicR.exe", 0x33569C;	// 0 normally. 1 when opening, 2 when closing.
    byte levelComplete : "SonicR.exe", 0x3B73E6;	// Lap counter.
    byte inDemo : "SonicR.exe", 0x33604C;	// 1 when in demo, 2 when in replay.
	byte pauseSelection : "SonicR.exe", 0x353658;	// 0 is Continue, 1 is Retry, 2 is Retire.
	byte playerReady : "SonicR.exe", 0xB5328;	// 1 when character is selected from the menu.
	byte menuProgression : "SonicR.exe", 0x3529B4;	// 1 when going forward (also main menu), 0 when backwards . 255 is no progression.
	
	// Lap timers
	ushort lap1 : "SonicR.exe", 0x3B73D8;
	ushort lap2 : "SonicR.exe", 0x3B73DC;
	ushort lap3 : "SonicR.exe", 0x3B73E0;
}

startup
{
	vars.timerCount = 0;
	refreshRate = 30;
}

start
{
	vars.timerCount = 0;
	
    if ( current.menuProgression == 1 && old.menuProgression == 255 
		&& current.playerReady == 1 && old.playerReady == 1 )
    {
		return true;
    }
}

update
{	
	int deltaTimer = (current.lap1 + current.lap2 + current.lap3)
		- (old.lap1 + old.lap2 + old.lap3);
	
	if (current.inDemo != 2 && deltaTimer > 0)
	{
		vars.timerCount += deltaTimer;
	}
}

gameTime
{
	double time = vars.timerCount / 60.0;
	return TimeSpan.FromSeconds(time);
}

split
{
	if (current.inDemo != 2 && old.levelComplete != 3)
	{
		return current.levelComplete == 3;
	}
}

reset
{
	if (current.transitionState == 2 && current.inGame == 4
		&& current.pauseSelection == 2)
	{
		return true;
	}
}

isLoading
{
	return true;
}