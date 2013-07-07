global therank, fldr
set fldr to quoted form of "/Users/Ben/Dropbox/Developer/March-Madness-Analyzer/Raw Data/"

set r1 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r2 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r3 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r4 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r5 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r6 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
repeat with yr from 1985 to 2013
	log ("Analyzing " & (yr as text)) as string
	set fulltext to (do shell script "cat " & fldr & (yr as text) & "raw.txt")
	repeat with x from 1 to 63
		set theteam to paragraph x of (fulltext)
		set therank to (do shell script "cat " & fldr & (yr as text) & "key.txt | grep -w '" & theteam & "' | cut -d ':' -f 1") as number
		if therank = "" then display dialog theteam & " - " & yr
		if x is less than 33 then
			calc(r1)
		else if x is less than 49 then
			calc(r2)
		else if x is less than 57 then
			calc(r3)
		else if x is less than 61 then
			calc(r4)
		else if x is less than 63 then
			calc(r5)
		else if x is less than 64 then
			calc(r6)
		end if
	end repeat
end repeat

newcalc(r1, 32)
newcalc(r2, 16)
newcalc(r3, 8)
newcalc(r4, 4)
newcalc(r5, 2)
newcalc(r6, 1)
try
	do shell script "rm " & fldr & "results.txt"
end try
do shell script "touch " & fldr & "results.txt"

dispresults(r1, "Round of 64")
dispresults(r2, "Round of 32")
dispresults(r3, "Sweet Sixteen")
dispresults(r4, "Elite Eight")
dispresults(r5, "Final Four")
dispresults(r6, "Championship")

set resulttext to (do shell script "cat " & fldr & "results.txt")

on calc(rnum)
	set item therank of rnum to ((item therank of rnum) + 1)
end calc

on newcalc(rr, num)
	set counter to 0
	repeat with x from 1 to (count of rr)
		set firstnum to ((item x of rr) / 29)
		set secondnum to ((round (firstnum * 1000)) / 1000)
		set (item x of rr) to (secondnum)
	end repeat
end newcalc

on dispresults(rr, rnd)
	set finaltxt to ""
	repeat with x from 1 to 16
		set finaltxt to finaltxt & (item x of rr as text) & " out of 4 #" & x & " seeds win in this round" & return
	end repeat
	
	do shell script "echo " & rnd & return & (quoted form of finaltxt) & return & " >> /Users/Ben/Dropbox/Developer/March-Madness-Analyzer/results.txt"
	
end dispresults