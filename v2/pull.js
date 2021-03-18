var fs = require('fs');
var seedKey = {};
var sumVals = {};
var totalVals = blankArray();
var startYear = 1985;
var endYear = 2019;

function blankArray() {
	return [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]];
}

for (var year = startYear; year <= endYear; year++) {
	seedKey[year] = {};
	var data = fs.readFileSync('./RawData/'+year+'key.txt', "utf-8").replace(/\'/g, "").replace(/\r/g, "").split('\n');
	// console.log(data)
	for(var line in data) {
		var split = data[line].split(': ');
		if (split[1] && split[1] !== 'undefined') {
			seedKey[year][split[1].replace(' ', '')] = Number(split[0]);
		}
	}
}
// console.log(seedKey)
for (var year = startYear; year <= endYear; year++) {
	sumVals[year] = blankArray();
	var data = fs.readFileSync('./RawData/'+year+'raw.txt', "utf-8").replace(/\'/g, "").replace(/\r/g, "").split('\n');
	// console.log(data)
	for (var line in data) {
		if (data[line]) {
			// console.log(data[line]);
			var seed = seedKey[year][data[line]];
			// console.log(seed);
			var round;
			if (line < 32) {
				round = 1;
			} else if (line < 48) {
				round = 2;
			} else if (line < 56) {
				round = 3;
			} else if (line < 60) {
				round = 4;
			} else if (line < 62) {
				round = 5;
			} else if (line < 63) {
				round = 6;
			}
			++sumVals[year][round-1][seed-1];
		}
	}
}
// console.log(sumVals);
for (var year = startYear; year <= endYear; year++) {
	var thisSumVal = sumVals[year];
	for (var round in thisSumVal) {
		for (var seed in thisSumVal[round]) {
			// console.log(year, round, seed);
			// console.log(thisSumVal[round][seed]);
			totalVals[round][seed] += (thisSumVal[round][seed] || 0);
			// console.log(totalVals);
		}
	}
}
console.log(totalVals);
var outOf4 = totalVals.map(function(round) {
	return round.map(function(num) {
		return Math.round(num * 100 / ((endYear - startYear + 1) * 4)) / 25;
	});
});
// console.log(outOf4)
// console.log(totalVals[5].reduce(function(a, b) {return a + b;}))