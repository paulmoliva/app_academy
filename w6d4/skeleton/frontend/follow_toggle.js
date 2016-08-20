class FollowToggle {

  constructor(el){
    this.user_id = el.data("user-id");
    this.init_follow_state = el.data("initial-follow-state");
    this.el = el;
    this.render();
    this.handleCLick();
  }

  render(){
    this.el.html(this._oppFollow());
    this.el.prop("disabled", false);
  }

  _oppFollow() {
    if(this.init_follow_state === "follow"){
      return "unfollow";
    }else{
      return "follow";
    }
  }

  handleCLick() {
    this.el.on('click', (event) => {
      this.el.prop("disabled", true);
      event.preventDefault();
      if (this.init_follow_state === "follow"){
        $.ajax({
          url: `/users/${this.user_id}/follow`,
          method: "DELETE",
          dataType: "JSON",
          context: this,
          success(data) {
            this.init_follow_state = this._oppFollow();
            this.render();
          }
        });
      }else{
        $.ajax({
          url: `/users/${this.user_id}/follow`,
          method: "POST",
          dataType: "JSON",
          context: this,
          success(data) {
            this.init_follow_state = this._oppFollow();
            this.render();
          }
        });
      }
    });
  }
}


module.exports = FollowToggle;
