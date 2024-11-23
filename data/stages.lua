-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 8,
		multiplier = 50,
	},
	{
		minlevel = 9,
		maxlevel = 50,
		multiplier = 80,
	},
	{
		minlevel = 51,
		maxlevel = 100,
		multiplier = 60,
	},
	{
		minlevel = 101,
		maxlevel = 200,
		multiplier = 40,
	},
	{
		minlevel = 201,
		maxlevel = 300,
		multiplier = 30,
	},
	{
		minlevel = 301,
		maxlevel = 400,
		multiplier = 15,
	},
	{
		minlevel = 401,
		maxlevel = 500,
		multiplier = 12,
	},
	{
		minlevel = 501,
		maxlevel = 600,
		multiplier = 10,
	},
	{
		minlevel = 601,
		maxlevel = 700,
		multiplier = 7,
	},
	{
		minlevel = 701,
		maxlevel = 800,
		multiplier = 6,
	},
	{
		minlevel = 801,
		maxlevel = 900,
		multiplier = 5,
	},
	{
		minlevel = 1001,
		maxlevel = 1100,
		multiplier = 4,
	},
	{
		minlevel = 1101,
		maxlevel = 1200,
		multiplier = 3,
	},
	{
		minlevel = 1201,
		maxlevel = 1300,
		multiplier = 2,
	},
	{
		minlevel = 1301,
		multiplier = 1.5,
	},
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 60,
		multiplier = 20,
	},
	{
		minlevel = 61,
		maxlevel = 80,
		multiplier = 10,
	},
	{
		minlevel = 81,
		maxlevel = 110,
		multiplier = 7,
	},
	{
		minlevel = 111,
		maxlevel = 125,
		multiplier = 4,
	},
	{
		minlevel = 126,
		multiplier = 2,
	},
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 30,
		multiplier = 20,
	},
	{
		minlevel = 31,
		maxlevel = 80,
		multiplier = 10,
	},
	{
		minlevel = 81,
		maxlevel = 100,
		multiplier = 9,
	},
	{
		minlevel = 101,
		maxlevel = 110,
		multiplier = 7,
	},
	{
		minlevel = 111,
		maxlevel = 125,
		multiplier = 4,
	},
	{
		minlevel = 126,
		multiplier = 2,
	}
}
