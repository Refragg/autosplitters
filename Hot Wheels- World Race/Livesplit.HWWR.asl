/* Hot Wheels: World Race Autosplitter 2.0.0
 * IDGeek121
 * Original by Prahaha
 *
 * This autosplitter reads the race timer for the game time and should be
 * accurate.
 *
 * The splits begin when you go to a league mode and select a car. Then it
 * splits when completing lap 3 on each race.
 *
 * I am confident that the race timer pointer is accurate, but the others might
 * not be accurate. I tested them on two computers and they worked on both. If
 * you have any issues let me know. */

state("HotWheelsWorldRace")
{
	// Used for starting autosplitter.
	int leagueCarSelect	: 0x002126BC, 0x7C, 0x8C, 0x14, 0x50;
	int menu			: 0x00211D10, 0xC, 0xB0;
	
	// Used for splitting.
	int lapCount		: 0x00211DEC, 0xA0, 0x6A0, 0x18, 0x80, 0x38C;
	
	// Used for reading the game time.
	float raceTimer		: 0x0023b014, 0x0, 0x18, 0x80, 0x0, 0x374;
}

init
{
	refreshRate = 60;
	vars.timeTotal = 0;
}

start
{
	vars.timeTotal = 0;
	
	/*
	if (current.leagueCarSelect != old.leagueCarSelect)
	{
		print(current.leagueCarSelect.ToString());
	}
	*/
	
	/*
	if (current.menu != old.menu)
	{
		print(current.menu.ToString());
	}
	*/
	
	// When in a loading screen, menu = 0. The second check sees if the last
	// screen was the league car select screen.
	if (current.menu == 0 &&
		current.leagueCarSelect == 0 && old.leagueCarSelect == 1)
	{
		return true;
	}
}

split
{
	/*
	if (current.lapCount != old.lapCount)
	{
		print(current.lapCount.ToString());
	}
	*/
	
	// Split when crossing finish line on lap 3.
	if (current.lapCount == 3 && old.lapCount == 2)
	{
		return true;
	}	
}

update
{
	// Race Timer Code
	// Time is stored in a float. To prevent float inaccuracies, we truncate it
	// to two decimal places like it's displayed in the game.
	
	// Convert floats to ints of centiseconds.
	int currTimeInt = (int) (current.raceTimer * 100);
	int oldTimeInt = (int) (old.raceTimer * 100);
	int timeDiff = (currTimeInt - oldTimeInt);
	
	// If timeDiff is positive, it's valid and should be added to total time.
	if ( timeDiff > 0 )
	{
		vars.timeTotal += timeDiff;
	}
}

gameTime
{
	// Convert centiseconds to milliseconds and return.
	return TimeSpan.FromMilliseconds(vars.timeTotal * 10);
}

isLoading
{
    return true;
}
