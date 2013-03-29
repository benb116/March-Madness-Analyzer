BenB116's March Madness Analyzer
=======
This is a script I wrote that analyzes the results of each NCAA Men's Basketball Tournament since 1985 (the first year that the tournament was expanded to 64 teams). The script only pays attention to the seed of each team and how far they get in the tournament. From the historical data, which I got using [CBS Sports Year-by-Year History](http://www.cbssports.com/collegebasketball/ncaa-tournament/history/yearbyyear) I came up with averages that can be used to predict future tournaments.

Inside the folder "Raw Data" is the, well, the raw data. There are two text files for each year since 1985: the first, labeled "raw", is a list of the teams that won a game in the tournament. The first 32 lines are from the First Round, the next 16 are from the Second Round, the following 8 are from the Sweet Sixteen, and so on. The second file, labeled "key", is a list of every team in the tournament that year and their seed.

The script works by counting the number of times  teams with a specific seed win in each round of each tournament. The numbers are added and each divided by 28 (the number of tournaments since 1985) to find the average number of wins per seed in each round of a given tournament.

Here are ten facts and tips based on the data:

1. A 16 seed has never beaten a #1 seed.
2. A #9 seed is slightly more likely to beat an #8 seed than vice versa.
3. A #15 seed has never made it to the Sweet Sixteen (except for Florida Gulf Coast, but they did it in 2013).
4. An #8 or #9 seed is not likely to get past the Second Round (probably because they have to beat a #1 seed to do it).
5. That being said, it is equally likely that 3 #1 seeds and 4 #1 seeds advance to the Sweet Sixteen.
6. Knock out at least 1 #2 seed in the Second Round of your bracket, and maybe even leave only two #3 seeds standing.
7. Of teams with seeds lower than 8, #10 seeds and #12 seeds are the most likely to advance to the Sweet Sixteen.
8. A #2 seed winning the championship and a #3 seed winning the championship are equally likely.
9. Best Final Four seeds? 1, 1, 2, 3.
10. The championship has **never** been won by a #9 seed or lower

Here are the results from 1985 to 2012 (2013 will be included once the tournament is over).

	Round of 64
	Round of 32
	Sweet Sixteen
	Elite Eight
	Final Four
	Championship