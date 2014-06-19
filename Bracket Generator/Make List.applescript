set fulltext to ""
repeat with y in {"A", "B", "C", "D"}
	repeat with x in {1, 8, 5, 4, 6, 3, 7, 2}
		set firstline to (x as text) & y & return
		set secondline to ((17 - x) as text) & y & return
		set fulltext to fulltext & firstline
		set fulltext to fulltext & secondline
	end repeat
end repeat

log fulltext