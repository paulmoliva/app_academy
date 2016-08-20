const MessageStore = require('./message_store');

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
