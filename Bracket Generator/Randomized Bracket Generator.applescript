global thecolumns, therounds

set thecolumns to {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O"}
-- Initial weights for seeds by round (see results of historical data for source)
set r1 to {132, 124, 111, 106, 85, 82, 81, 67, 65, 51, 50, 47, 26, 21, 8, 0}
set r2 to {114, 83, 68, 62, 43, 42, 26, 13, 5, 23, 20, 20, 6, 2, 1, 0}
set r3 to {92, 61, 32, 21, 8, 14, 10, 8, 2, 8, 7, 1, 0, 0, 0, 0}
set r4 to {54, 28, 15, 13, 6, 3, 3, 5, 1, 1, 3, 0, 0, 0, 0, 0}
set r5 to {32, 13, 9, 3, 3, 2, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0}
set r6 to {20, 5, 4, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0}
set oldrounds to {r1, r2, r3, r4, r5, r6}
set therounds to {r1, r2, r3, r4, r5, r6}

(*
RECOMMENDATIONS for a completely average bracket

First Round - Pick eight upsets:
	Two 9 over 8, two 10 over 7, two/one 11 over 6, one/two 12 over 5 , one 13 over 4
Second Round - 
	Knock out at least one 2, two 3, two 4, two 5. Finish accordingly
Sweet Sixteen - 
	At this point, only the low number seeds that are actually good are left. 
	Still, knock out one 1, one 3, one/two 4
Elite Eight - 
	One more 1 should fall, leaving only two remaining. You should reach the Final Four with 1, 1, 2, and a 3, 4, or maybe 5.
*)

repeat 1 times
	-- Compute each round. The lists tell the script which rows to use in Excel
	doround(1, {1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63}, 1)
	doround(2, {1, 5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61}, 2)
	doround(3, {1, 9, 17, 25, 33, 41, 49, 57}, 4)
	doround(4, {1, 17, 33, 49}, 8)
	doround(5, {1, 33}, 16)
	doround(6, {1}, 32)
	
	(*tell application "Microsoft Excel"
		set firstp to (value of range "F1") as integer
		set secondp to (value of range "F17") as integer
		set thirdp to (value of range "F33") as integer
		set fourthp to (value of range "F49") as integer
		set winner to (value of range "H1") as integer
	end tell*)
	
	delay 1
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
			
			set sumval to fcurval + scurval
			tell current application
				--set rand to (random number from 0 to sumval) -- Choose a random number between 0 and the sum of the rank weights
			end tell
			log fcurval
			log scurval
			--(*
			set winner to 0
			
			repeat while winner = 0
				tell current application
					set rand to (random number from 0 to sumval)
					set rand1 to (random number from 0 to 124)
					set rand2 to (random number from 0 to 124)
				end tell
				if (rand1 ² fcurval) and (rand2 > scurval) then
					set winner to 1
				else if (rand1 > fcurval) and (rand2 ² scurval) then
					set winner to 2
				else if (fcurval = scurval) then
					set winner to 1
				end if
			end repeat
			--*)
			tell application "Microsoft Excel"
				if rand is less than or equal to fcurval then -- If the number is less than the sum (which is more likely for a higher seed)
					--if winner = 1 then
					set value of range ((item (theround + 1) of thecolumns) & therow) to firstcell -- Advance first cell
					set oldsum to (get value of range ((item (theround + 9) of thecolumns) & therow))
					set value of range ((item (theround + 9) of thecolumns) & therow) to (oldsum + firstcell)
				else if rand > fcurval then
					--else if winner = 2 then
					set value of range ((item (theround + 1) of thecolumns) & therow) to secondcell -- Advance second cell
					set oldsum to (get value of range ((item (theround + 9) of thecolumns) & therow))
					set value of range ((item (theround + 9) of thecolumns) & therow) to (oldsum + secondcell)
				end if
			end tell
			delay 0.1
		end repeat
	end tell
end doround