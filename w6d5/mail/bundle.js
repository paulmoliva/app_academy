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

	const Router = __webpack_require__(1);
	const Inbox = __webpack_require__(2);
	const Spam = __webpack_require__(5);
	const Sent = __webpack_require__(4);
	const Compose = __webpack_require__(6);
	const routes = {
	  inbox: Inbox,
	  sent: Sent,
	  spam: Spam,
	  compose: Compose
	};

	document.addEventListener("DOMContentLoaded", () => {
	  let contentNode = document.querySelector('.content');
	  let router = new Router(contentNode, routes);
	  router.start();

	  let navLiArr = Array.from(document.querySelectorAll('.sidebar-nav li'));

	  navLiArr.forEach((li) => {
	    li.addEventListener("click",
	      (e) => {
	        window.location.hash = e.currentTarget.innerText.toLowerCase();
	      });
	  });


	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	class Router {
	  constructor (node, routes) {
	    this.node = node;
	    this.routes = routes;
	  }

	  start () {
	    this.render();
	    window.addEventListener("hashchange", () => {
	      this.render();
	    });
	  }

	  render () {
	    this.node.innerHTML = '';
	    let component = this.activeRoute();
	    if (!component){
	      this.node.innerHTML = "";
	    } else{
	      this.node.innerHTML = "";
	      let el = component.render();
	      this.node.appendChild(el);
	    }
	  }

	  activeRoute() {
	    if (window.location.hash === "") {
	      return "";
	    } else {
	      return this.routes[window.location.hash.slice(1)];
	    }
	  }
	}

	module.exports = Router;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const MessageStore = __webpack_require__(3);

	let Inbox = {
	  render: function() {
	    let ul = document.createElement('ul');
	    ul.className = "messages";
	    let messages = MessageStore.getInboxMessages();

	    messages.forEach((msg) => {
	      let msgNode = this.renderMessage(msg);
	      ul.appendChild(msgNode);
	    });

	    return ul;
	  },

	  renderMessage: function(msg) {
	    let li = document.createElement('li');
	    li.className = "message";
	    li.innerHTML = `<span class='from'>${msg.from}</span>
	      <span class='subject'>${msg.subject}</span>
	      <span class='body'>${msg.body}</span>
	    `;
	    return li;
	  }

	};

	module.exports = Inbox;


/***/ },
/* 3 */
/***/ function(module, exports) {

	class Message {
	  constructor(options = {}) {
	    this.from = options.from || '';
	    this.to = options.to || '';
	    this.subject = options.subject || '';
	    this.body = options.body || '';
	  }
	}

	let messages = {
	  sent: [
	    {to: "friend@mail.com", subject: "Check this out", body: "It's so cool"},
	    {to: "person@mail.com", subject: "zzz", body: "so booring"}
	  ],
	  inbox: [
	    {from: "grandma@mail.com", subject: "Fwd: Fwd: Fwd: Check this out", body:
	    "Stay at home mom discovers cure for leg cramps. Doctors hate her"},
	    {from: "person@mail.com", subject: "Questionnaire", body: "Take this free quiz win $1000 dollars"}
	  ],
	  spam: [
	    {from: 'porn@porn.porn', subject: 'get ur fix ', body: 'u have a problem. u need help'},
	    {from: 'nigerian@nigeria.gov', subject: 'this is not a scam', body: 'jk.'}
	  ]
	};

	let MessageStore = {
	  getInboxMessages: function() {
	    return messages.inbox;
	  },
	  getSentMessages: function() {
	    return messages.sent;
	  },
	  getSpamMessages: function() {
	    return messages.spam;
	  },
	  getMessageDraft: function() {
	    return this.messageDraft;
	  },
	  messageDraft: new Message(),
	  updateDraftField: function(field, val) {
	    this.messageDraft[field] = val;
	  },
	  sendDraft: function() {
	    this.getSentMessages().push(this.messageDraft);
	    this.messageDraft = new Message();
	  }

	};



	module.exports = MessageStore;


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const MessageStore = __webpack_require__(3);

	let Sent = {
	  render: function() {
	    let ul = document.createElement('ul');
	    ul.className = "messages";
	    let messages = MessageStore.getSentMessages();

	    messages.forEach((msg) => {
	      let msgNode = this.renderMessage(msg);
	      ul.appendChild(msgNode);
	    });

	    return ul;
	  },

	  renderMessage: function(msg) {
	    let li = document.createElement('li');
	    li.className = "message";
	    li.innerHTML = `<span class='to'>${msg.to}</span>
	      <span class='subject'>${msg.subject}</span>
	      <span class='body'>${msg.body}</span>
	    `;
	    return li;
	  }

	};

	module.exports = Sent;


/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	const MessageStore = __webpack_require__(3);

	let Spam = {
	  render: function() {
	    let ul = document.createElement('ul');
	    ul.className = "messages";
	    let messages = MessageStore.getSpamMessages();

	    messages.forEach((msg) => {
	      let msgNode = this.renderMessage(msg);
	      ul.appendChild(msgNode);
	    });

	    return ul;
	  },

	  renderMessage: function(msg) {
	    let li = document.createElement('li');
	    li.className = "message";
	    li.innerHTML = `<span class='from'>${msg.from}</span>
	      <span class='subject'>${msg.subject}</span>
	      <span class='body'>${msg.body}</span>
	    `;
	    return li;
	  }

	};

	module.exports = Spam;


/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

	const MessageStore = __webpack_require__(3);

	let Compose = {
	  render: function() {
	    let div = document.createElement('div');
	    div.className = 'new-message';
	    div.innerHTML = this.renderForm();
	  },
	  renderForm: function() {
	    let draft = MessageStore.getMessageDraft();
	    let content = `<p class ='new-message-header'>New Message</p>
	      <form class = 'compose-form>
	        <input placeholder = 'Recipient' name = 'to' type = 'text' value = '${draft.to}'</input>
	        <input paceholer = 'Subject' name = 'subject' type = 'text' value = ${draft.subject}</input>
	        <textarea name='body' rows = '20'>${draft.body}</textarea>
	        <button type = 'submit' class = 'btn btn-primart submit-message'>Send</button>
	      </form>'`;
	    return content;
	  }
	};

	module.exports = Compose;


/***/ }
/******/ ]);