const MessageStore = require('./message_store.js');

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
