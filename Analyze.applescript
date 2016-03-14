global therank, fldr
set fldr to quoted form of "/Users/Ben/Dropbox/Developer/March-Madness-Analyzer/Raw Data/"

set r1 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r2 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r3 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r4 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r5 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
set r6 to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
repeat with yr from 1985 to 2015
	delay 0.1
	log ("Analyzing " & (yr as text) & "...") as string
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

log r1
log r2
log r3
log r4
log r5
log r6

on calc(rnum)
	set item therank of rnum to ((item therank of rnum) + 1)
end calc