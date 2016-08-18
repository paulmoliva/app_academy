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
