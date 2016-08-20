class TweetCompose {
  constructor(el){
    this.el = el;
    this.handleInput();
    this.handleFormSubmit();
    this.char_count = 0;
  }

  handleInput(){
    this.el.on('keyup', (event) => {
      let ta = event.target;
      let $target = $(ta);
      let tweetLength = $target.val().length;
      $(event.currentTarget).find('p').html(parseInt(140 - tweetLength));
      if (tweetLength > 140){
        this.el.find(":submit").prop("disabled", true);
      }else{
        this.el.find(":submit").prop("disabled", false);
      }
    });
  }

  handleFormSubmit(){
    this.el.on('submit', (event) => {
      event.preventDefault();
      this.submit(event.currentTarget);
    });
  }

  submit(target) {
    let allInputs = $(":input");
    let val = $(target).serializeJSON();
    allInputs.prop("disabled", true);
    $.ajax({
      method: 'POST',
      url: '/tweets',
      dataType: 'JSON',
      context: this,
      data: val,
      success(data){
        this.handleSuccess(data, allInputs);
      }
    });
  }

  handleSuccess(data, allInputs){
    let ul = $("#feed");
    ul.prepend(`<li>${data.content} --
      <a href="/users/${data.user_id}">${data.user.username}</a> --
      ${data.created_at}</li>`);
    let li = ul.find("li").first();
    if (data.mentions.length){
      li.append(`<ul><li><a href="/users/${data.mentions[0].user.id}">${data.mentions[0].user.username}</a></li></ul>`);
    }

    allInputs.prop("disabled", false);
    this.clearInput(allInputs);
  }

  clearInput(allInputs){
    allInputs.each((i, el) => {
      $(el).not(':submit').val("");
    });
    $(this.el.find('p')[0]).html("140");
  }

}
module.exports = TweetCompose;
