const Board = require('./board.js');
const Coord = require('./coord.js');

function View(game, $el)  {
  this.$el = $el;
  this.game = game;
  this.board = new Board();
  this.setUpGrid();
  this.handleKeyEvent();

  setInterval( () => {
    View.prototype.step();
  }, 500);
}

View.prototype.handleKeyEvent = function(){
  this.$el.keydown( event => {
    let code = event.keyCode;
    if (code === 38) { //up
      if (this.board.snake.direction === "E" || this.board.direction === "W") {
        this.board.snake.turn("N");
      }
    } else if (code === 40) { //down
      if (this.board.snake.direction === "E" || this.board.direction === "W") {
        this.board.snake.turn("S");
      }
    } else if (code === 37) { //left
      if (this.board.snake.direction === "N" || this.board.direction === "S") {
        this.board.snake.turn("W");
      }
    } else if (code === 39) { //right
      if (this.board.snake.direction === "N" || this.board.direction === "S") {
        this.board.snake.turn("E");
      }
    }
  });
};

View.prototype.step = function () {

};

View.prototype.render = function() {

};

View.prototype.setUpGrid = function() {
  let $ul = $('<ul class="clearfix"></ul>');

  for (let i = 0; i < 2500; i++) {
    $ul.append('<li class="square"></li>');
  }
  this.$el.append($ul);
};

module.exports = View;
