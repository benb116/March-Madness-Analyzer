function (game, team1, team2) {

  var weights = [ [ 124, 117, 104, 99, 80, 81, 76, 63, 61, 48, 43, 44, 25, 20, 7, 0 ],
  [ 107, 79, 63, 57, 41, 41, 22, 12, 5, 22, 18, 20, 6, 2, 1, 0 ],
  [ 85, 58, 31, 20, 8, 13, 9, 8, 2, 7, 6, 1, 0, 0, 0, 0 ],
  [ 51, 26, 14, 13, 6, 3, 2, 5, 1, 0, 3, 0, 0, 0, 0, 0 ],
  [ 29, 12, 9, 3, 3, 2, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 19, 4, 4, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 ] ];
  
  var roundWeight = weights[(5-game.round)];

  var t1weight = roundWeight[(team1.seed)-1];
  var t2weight = roundWeight[(team2.seed)-1];
  var sum = t1weight + t2weight;
  
  var rand = Math.random() * sum;
  
  if (t1weight > rand) {
    team1.winsGame();
  } else {
    team2.winsGame();
  }
}