const Router = require('./router.js');
const Inbox = require('./inbox');
const Spam = require('./spam');
const Sent = require('./sent');
const Compose = require('./compose');
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
