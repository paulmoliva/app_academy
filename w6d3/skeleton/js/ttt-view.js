var View = function (game, $el) {
  this.el = $el;
  this.game = game;
  $el.append(this.setupBoard());
};

View.prototype.bindEvents = function () {
  let $li = $('li');
  $li.on('click', (event) => {
    let $currentTarget = $(event.currentTarget);
    this.makeMove($currentTarget);
  });
};

View.prototype.makeMove = function ($square) {
  let i = $square.index();
  let rowIdx = Math.floor(i/3);
  let colIdx = i % 3;

  try{
    this.game.playMove([rowIdx, colIdx]);
    if (this.game.currentPlayer === 'x'){
      $square.addClass('blueText');
    }
    else {
      $square.addClass('redText');
    }
    let playerMark = (this.game.currentPlayer === 'x') ? 'o' : 'x';
    $square.text(playerMark);
    $square.addClass('white');
  } catch (e) {
    alert('invalid move!');
  }


  if(this.game.isOver()){
    if (this.game.winner()) {
      this.el.append(`<h2>${this.game.winner()} has won the game!</h2>`);
    } else {
      this.el.append('<h2>It\'s a tie bro c\'mon figure it out</h2>');
    }
  }
};

View.prototype.setupBoard = function () {
  let $ul = $('<ul></ul>');
  for (let i = 0; i < 9; i++){
    $ul.append($('<li></li>'));
  }
  return $ul;
};

module.exports = View;
