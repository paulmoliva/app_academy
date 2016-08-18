/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const Board = __webpack_require__(1);
	const Game = __webpack_require__(2);
	const Snake = __webpack_require__(3);
	const View = __webpack_require__(4);

	$( () => {
	  const rootEl = $('.snake');
	  const game = new Game();
	  new View(game, rootEl);
	});


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Snake = __webpack_require__(3);

	function Board() {
	  this.snake = new Snake();
	}



	module.exports = Board;


/***/ },
/* 2 */
/***/ function(module, exports) {

	function Game(){
	  
	}

	module.exports = Game;


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const Coord = __webpack_require__(5);

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


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const Board = __webpack_require__(1);
	const Coord = __webpack_require__(5);

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


/***/ },
/* 5 */
/***/ function(module, exports) {

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


/***/ }
/******/ ]);