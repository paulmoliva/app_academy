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
