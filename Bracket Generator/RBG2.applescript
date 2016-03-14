global thecolumns, therounds

set thecolumns to {"B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M"}
-- Initial weights for seeds by round (see results of historical data for source)
set r1 to {124, 117, 104, 99, 80, 81, 76, 63, 61, 48, 43, 44, 25, 20, 7, 0}
set r2 to {107, 79, 63, 57, 41, 41, 22, 12, 5, 22, 18, 20, 6, 2, 1, 0}
set r3 to {85, 58, 31, 20, 8, 13, 9, 8, 2, 7, 6, 1, 0, 0, 0, 0}
set r4 to {51, 26, 14, 13, 6, 3, 2, 5, 1, 0, 3, 0, 0, 0, 0, 0}
set r5 to {29, 12, 9, 3, 3, 2, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0}
set r6 to {19, 4, 4, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0}
set therounds to {r1, r2, r3, r4, r5, r6}

doround(6)
doround(5)
doround(4)
doround(4)
doround(3)
doround(3)
doround(3)
doround(3)

on doround(rn)
	log (item rn of therounds)
	(*set fullsum to 0
	repeat with x from 1 to 16
		set fullsum to fullsum + (item x of (item rn of therounds))
	end repeat
	set rand to random number from 1 to fullsum as integer
	set roundsum to 0
	repeat with seed from 1 to 16
		set roundsum to roundsum + (item seed of (item rn of therounds))
		if roundsum > rand then
			repeat with rnum from rn to rn
				
				set (item seed of (item rnum of therounds)) to (item seed of (item rnum of therounds)) - 31
				if (item seed of (item rnum of therounds)) < 0 then set (item seed of (item rnum of therounds)) to 0
			end repeat
			exit repeat
		end if
	end repeat
	
	log seed*)
	log (item rn of therounds)
	tell application "Microsoft Excel"
		set theround to rn
		log "Round " & theround as text
		repeat with thenum in theround -- for each row
			set therow to thenum
			set firstcell to (value of range ((item theround of thecolumns) & (therow as text))) -- Get the ID of the first cell
			set thefrank to (firstcell) as integer -- Get its rank
			set fcurval to (item thefrank of (item theround of therounds)) -- get the appropriate rank weight
			
			set secondcell to (value of range ((item theround of thecolumns) & ((therow + plus) as text))) -- Same for the second cell
			set thesrank to secondcell as integer
			set scurval to (item thesrank of (item theround of therounds))
			
			set sumval to fcurval + scurval
			set rand to (random number from 0 to sumval) -- Choose a random number between 0 and the sum of the rank weights
			
			log fcurval
			log scurval
			log rand
			
			if rand is less than or equal to fcurval then -- If the number is less than the sum (which is more likely for a higher seed)
				set value of range ((item (theround + 1) of thecolumns) & therow) to firstcell -- Advance first cell
			else if rand > fcurval then
				set value of range ((item (theround + 1) of thecolumns) & therow) to secondcell -- Advance second cell
			end if
			delay 0.1
		end repeat
	end tell
end doround