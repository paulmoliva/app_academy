function Coord(x, y) {
  this.x = x;
  this.y = y;
}

Coord.DIRECTION = {
  "N": [0, 1],
  "E": [1, 0],
  "S": [0, -1],
  "W": [-1, 0],
};

Coord.prototype.plus = function(vector){
  this.x += vector[0];
  this.y += vector[1];
};

Coord.prototype.equals = function(coord) {
  return (this.x === coord.x && this.y === coord.y);
};

Coord.prototype.isOpposite = function(coord) {

};






module.exports = Coord;
