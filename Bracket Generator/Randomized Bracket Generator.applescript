global thecolumns, therounds

set thecolumns to {"B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M"}
repeat 10 times
	delay 1
	-- Initial weights for seeds by round (see results of historical data for source)
	set r1 to {120, 113, 102, 95, 76, 79, 73, 59, 61, 47, 41, 44, 25, 18, 7, 0} -- 32
	set r2 to {104, 77, 61, 55, 39, 40, 20, 11, 5, 22, 17, 20, 6, 2, 1, 0} -- 16
	set r3 to {82, 56, 30, 19, 8, 13, 8, 8, 2, 7, 6, 1, 0, 0, 0, 0} -- 8
	set r4 to {48, 26, 14, 13, 6, 3, 1, 5, 1, 0, 3, 0, 0, 0, 0, 0} -- 4
	set r5 to {27, 12, 9, 3, 3, 2, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0} -- 2
	set r6 to {18, 4, 4, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0} -- 1
	set therounds to {r1, r2, r3, r4, r5, r6}
	
	-- Compute each round. The lists tell the script which rows to use in Excel
	doround(1, {1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63}, 1)
	doround(2, {1, 5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61}, 2)
	doround(3, {1, 9, 17, 25, 33, 41, 49, 57}, 4)
	doround(4, {1, 17, 33, 49}, 8)
	doround(5, {1, 33}, 16)
	doround(6, {1}, 32)
	
	tell application "Microsoft Excel"
		set firstp to (value of range "F1") as integer
		set secondp to (value of range "F17") as integer
		set thirdp to (value of range "F33") as integer
		set fourthp to (value of range "F49") as integer
	end tell
	do shell script "echo " & firstp & "	" & secondp & "	" & thirdp & "	" & fourthp & " >> ~/Desktop/results.txt"
end repeat
on doround(rn, lis, plus)
	tell application "Microsoft Excel"
		set theround to rn
		log "Round " & theround as text
		repeat with thenum in lis -- for each row
			set therow to thenum
			set firstcell to (value of range ((item theround of thecolumns) & (therow as text))) -- Get the ID of the first cell
			set thefrank to (firstcell) as integer -- Get its rank
			set fcurval to (item thefrank of (item theround of therounds)) -- get the appropriate rank weight
			
			set secondcell to (value of range ((item theround of thecolumns) & ((therow + plus) as text))) -- Same for the second cell
			set thesrank to secondcell as integer
			set scurval to (item thesrank of (item theround of therounds))
			
			log fcurval
			log scurval
			
			set sumval to fcurval + scurval
			tell current application
				set rand to (random number from 0 to sumval) -- Choose a random number between 0 and the sum of the rank weights
			end tell
			log rand
			log fcurval
			
			if rand is less than or equal to fcurval then -- If the number is less than the sum (which is more likely for a higher seed)
				set value of range ((item (theround + 1) of thecolumns) & therow) to firstcell -- Advance first cell
				--set prevsum to get value of range (((item (theround + 7) of thecolumns) & therow)) as number
				--set value of range (((item (theround + 7) of thecolumns) & therow)) to prevsum + (firstcell as number)
				set (item thefrank of (item theround of therounds)) to (item thefrank of (item theround of therounds)) - 29 -- Reduce the rank weight
			else if rand > fcurval then
				set value of range ((item (theround + 1) of thecolumns) & therow) to secondcell -- Advance second cell
				--set prevsum to get value of range (((item (theround + 7) of thecolumns) & therow)) as number
				--set value of range (((item (theround + 7) of thecolumns) & therow)) to prevsum + (secondcell as number)
				set (item thesrank of (item theround of therounds)) to (item thesrank of (item theround of therounds)) - 29 -- Reduce the rank weight
			end if
			delay 0.1
		end repeat
	end tell
end doround