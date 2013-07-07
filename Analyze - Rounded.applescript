global therank, fldr
set fldr to quoted form of "/Users/Ben/Dropbox/Developer/March-Madness-Analyzer/Raw Data/"

set r1 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r2 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r3 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r4 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r5 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r6 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
repeat with yr from 1985 to 2013
	delay 0.1
	log ("Analyzing " & (yr as text)) as string
	set fulltext to (do shell script "cat " & fldr & (yr as text) & "raw.txt")
	repeat with x from 1 to 63
		set theteam to paragraph x of (fulltext)
		set therank to (do shell script "cat " & fldr & (yr as text) & "key.txt | grep -w '" & theteam & "' | cut -d ':' -f 1") as number
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

set resulttext to paragraphs of (do shell script "cat " & fldr & "results.txt")
log return
log "Results"
log return
repeat with x in resulttext
	log x
end repeat
on calc(rnum)
	set item therank of rnum to ((item therank of rnum) + 1)
end calc

on newcalc(rr, num)
	set counter to 0
	repeat with x from 1 to (count of rr)
		set firstnum to ((item x of rr) / 29)
		set secondnum to ((round (firstnum * 1000)) / 1000)
		if secondnum is greater than 0.5 then
			set (item x of rr) to (round secondnum)
			set counter to counter + (round secondnum)
		else if secondnum is equal to 0.5 then
			set (item x of rr) to 1
			set counter to counter + 1
		else
			set (item x of rr) to secondnum
		end if
	end repeat
	if counter is less than num then
		set newc to 0
		repeat with x from 1 to (count of rr)
			if (round (item x of rr)) is less than 1 then
				if ((item x of rr)) is greater than newc then
					set newc to round (item x of rr)
					set y to x
				end if
			end if
		end repeat
		set (item y of rr) to 1
	end if
end newcalc

on dispresults(rr, rnd)
	set finaltxt to ""
	repeat with x from 1 to 16
		if (item x of rr) is greater than or equal to 0.5 then
			set finaltxt to finaltxt & (item x of rr as text) & " out of 4 #" & x & " seeds win in this round" & return
		end if
	end repeat
	
	do shell script "echo " & rnd & return & (quoted form of finaltxt) & return & " >> " & fldr & "results.txt"
	
end dispresults