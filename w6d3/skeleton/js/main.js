const View = require('./ttt-view.js');
const Game = require('../../solution/game.js');

$( () => {
  const game = new Game();
  let $ttt = $('.ttt');
  const view = new View(game, $ttt);
  view.bindEvents();
});
