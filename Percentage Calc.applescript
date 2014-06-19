set r1 to {120, 113, 102, 95, 76, 79, 73, 59, 61, 47, 41, 44, 25, 18, 7, 0} -- 32
set r2 to {104, 77, 61, 55, 39, 40, 20, 11, 5, 22, 17, 20, 6, 2, 1, 0} -- 16
set r3 to {82, 56, 30, 19, 8, 13, 8, 8, 2, 7, 6, 1, 0, 0, 0, 0} -- 8
set r4 to {48, 26, 14, 13, 6, 3, 1, 5, 1, 0, 3, 0, 0, 0, 0, 0} -- 4
set r5 to {27, 12, 9, 3, 3, 2, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0} -- 2
set r6 to {18, 4, 4, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0} -- 1

set therounds to {r1, r2, r3, r4, r5, r6}

repeat with rr in therounds
	repeat with x from 1 to (count of rr)
		set firstnum to ((item x of rr) / 1.2)
		set secondnum to ((round (firstnum * 100)) / 100)
		set (item x of rr) to (secondnum)
	end repeat
end repeat

log r1
log r2
log r3
log r4
log r5
log r6