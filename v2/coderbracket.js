function (game, team1, team2) {

  var weights = [ [ 132, 124, 111, 106, 85, 82, 81, 66, 65, 51, 50, 47, 26, 21, 8, 0, 0, 0],
  [ 114, 83, 68, 62, 43, 42, 26, 13, 5, 23, 20, 20, 6, 2, 1, 0 ],
  [ 92, 61, 32, 21, 8, 14, 10, 8, 2, 8, 7, 1, 0, 0, 0, 0 ],
  [ 54, 28, 15, 13, 6, 3, 3, 5, 1, 1, 3, 0, 0, 0, 0, 0 ],
  [ 31, 13, 9, 3, 3, 2, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [ 20, 5, 4, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 ] ];
  
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