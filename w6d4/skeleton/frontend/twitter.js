const FollowToggle = require("./follow_toggle.js");
const UsersSearch = require("./users_search");
const TweetCompose = require('./tweet_compose');
$(() => {
  let $togClass = $(".follow-toggle");
  $togClass.each((i, el) => {
    new FollowToggle($(el));
  });
  let $searchNav = $(".users-search");
  new UsersSearch($searchNav);
  new TweetCompose($('.tweet-compose'));
});
