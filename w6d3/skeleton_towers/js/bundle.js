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

	const HanoiGame = __webpack_require__(1);
	const HanoiView = __webpack_require__(2);

	$( () => {
	  const rootEl = $('.hanoi');
	  const game = new HanoiGame();
	  new HanoiView(game, rootEl);
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	class Game {
	  constructor() {
	    this.towers = [[3, 2, 1], [], []];
	  }

	  isValidMove(startTowerIdx, endTowerIdx) {
	      const startTower = this.towers[startTowerIdx];
	      const endTower = this.towers[endTowerIdx];

	      if (startTower.length === 0) {
	        return false;
	      } else if (endTower.length == 0) {
	        return true;
	      } else {
	        const topStartDisc = startTower[startTower.length - 1];
	        const topEndDisc = endTower[endTower.length - 1];
	        return topStartDisc < topEndDisc;
	      }
	  }

	  isWon() {
	      // move all the discs to the last or second tower
	      return (this.towers[2].length == 3) || (this.towers[1].length == 3);
	  }

	  move(startTowerIdx, endTowerIdx) {
	      if (this.isValidMove(startTowerIdx, endTowerIdx)) {
	        this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());
	        return true;
	      } else {
	        return false;
	      }
	  }

	  print() {
	      console.log(JSON.stringify(this.towers));
	  }

	  promptMove(reader, callback) {
	      this.print();
	      reader.question("Enter a starting tower: ", start => {
	        const startTowerIdx = parseInt(start);
	        reader.question("Enter an ending tower: ", end => {
	          const endTowerIdx = parseInt(end);
	          callback(startTowerIdx, endTowerIdx);
	        });
	      });
	  }

	  run(reader, gameCompletionCallback) {
	      this.promptMove(reader, (startTowerIdx, endTowerIdx) => {
	        if (!this.move(startTowerIdx, endTowerIdx)) {
	          console.log("Invalid move!");
	        }

	        if (!this.isWon()) {
	          // Continue to play!
	          this.run(reader, gameCompletionCallback);
	        } else {
	          this.print();
	          console.log("You win!");
	          gameCompletionCallback();
	        }
	      });
	  }
	}

	module.exports = Game;


/***/ },
/* 2 */
/***/ function(module, exports) {

	function HanoiView(game, $el){
	  this.game = game;
	  this.el = $el;
	  this.setupTowers();
	  this.render();
	  this.clickTower();
	}

	HanoiView.prototype.setupTowers = function() {
	  for (let i = 0; i < 3; i++){
	    let $ul = $(`<ul class='tower${i+1}'></ul>`);
	    this.el.append($ul);
	  }
	};

	HanoiView.prototype.render = function() {
	  let $uls = $('ul');

	  $uls.each( function(i) {
	    console.log("in each!");
	    $($uls[i]).empty();
	  } );

	  for (let i = 0; i < 3; i++) {
	    for (let j = this.game.towers[i].length - 1; j >= 0; j--) {
	      let $ul = $(`.tower${i+1}`);
	      $ul.append(`<li class='disc${this.game.towers[i][j]}'></li>`);
	    }
	  }

	  if (this.game.isWon()) {
	    this.el.append('<h1>Congratulations YOU WON! go party.</h1>');
	  }
	};

	HanoiView.prototype.clickTower = function() {
	  $('ul').on('click', (event) => {
	    if (typeof this.selected === 'undefined'){
	      let $currentTarget = $(event.currentTarget);
	      let towerNum = $currentTarget.attr("class");
	      this.selected = parseInt(towerNum[towerNum.length - 1]) - 1;
	      $currentTarget.addClass("selected");
	    } else {
	      try {
	        let $currentTarget = $(event.currentTarget);
	        let towerNum = $currentTarget.attr("class");
	        let target = parseInt(towerNum[towerNum.length - 1]) - 1;
	        if (this.game.move(this.selected, target)) {

	        } else {
	          throw "e";
	        }
	        $('ul').removeClass("selected");
	        this.selected = undefined;
	        this.render();
	      } catch (e) {
	        alert('Hey bro that is not a valid move watch urself homie');
	        $('ul').removeClass("selected");
	        this.selected = undefined;
	      }
	    }
	  });
	};

	module.exports = HanoiView;


/***/ }
/******/ ]);