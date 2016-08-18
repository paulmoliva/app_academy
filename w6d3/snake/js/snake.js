const Coord = require('./coord.js');

function Snake() {
  this.direction = "N";
  this.segments = [new Coord(25, 25)];
}

Snake.prototype.move = function() {
  for (let i = 0; i < this.segments.length - 1; i++) {
    let temp = this.segments[i];
    if (i === 0) {
      let direction = Coord.DIRECTION[this.direction];
      this.segments[i].plus(direction);
    }

    this.segments[i + 1] = temp;
  }
};

Snake.prototype.turn = function(newDirection) {
  this.direction = newDirection; 
};









module.exports = Snake;
