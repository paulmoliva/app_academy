const Board = require('./board.js');
const Game = require('./game.js');
const Snake = require('./snake.js');
const View = require('./view.js');

$( () => {
  const rootEl = $('.snake');
  const game = new Game();
  new View(game, rootEl);
});
