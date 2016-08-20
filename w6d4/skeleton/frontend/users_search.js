const FollowToggle = require('./follow_toggle.js');
class UsersSearch{
  constructor(el){
    this.el = el;
    this.input = $(this.el.children('input'));
    this.ul = $(this.el.children('ul'));
    this.handleInput();
  }

  renderResults(data){
    let results = data.map((el) => [el.id, el.username, el.followed]);
    this.ul.empty();
    results.forEach((el) => {
      let followed;
      if (el[2]){
        followed = "follow";
      }else{
        followed = "unfollow";
      }
      let li = $("<li>");
      this.ul.append(li);
      li.html(`<a href="/users/${el[0]}">${el[1]}</a>`);
      li.append(`<button class="follow-toggle" data-user-id="${el[0]}"
       data-initial-follow-state="${followed}">`);
       let $btn = $(li.find('button')[0]);
      let follow_toggle = new FollowToggle($btn);
    });
  }

  handleInput(){
    this.input.on('keyup', (event) => {
      let val = $(event.currentTarget).serialize();
      $.ajax({
        url: '/users/search',
        method: "GET",
        dataType: 'JSON',
        data: val,
        contentType: 'JSON',
        context: this,
        success(data) {

          this.renderResults(data);
        }
      });
    });
  }

}

module.exports = UsersSearch;
