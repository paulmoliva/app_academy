/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const FollowToggle = __webpack_require__(1);
	const UsersSearch = __webpack_require__(2);
	const TweetCompose = __webpack_require__(3);
	$(() => {
	  let $togClass = $(".follow-toggle");
	  $togClass.each((i, el) => {
	    new FollowToggle($(el));
	  });
	  let $searchNav = $(".users-search");
	  new UsersSearch($searchNav);
	  new TweetCompose($('.tweet-compose'));
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

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


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const FollowToggle = __webpack_require__(1);
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


/***/ },
/* 3 */
/***/ function(module, exports) {

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


/***/ }
/******/ ]);
//# sourceMappingURL=bundle.js.map