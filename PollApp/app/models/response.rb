class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response
  validate :not_poll_author

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question

  def not_duplicate_response
    if respondent_already_answered?
      self.errors[:user] << 'has already responded to question'
    end
  end

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def not_poll_author?
    self.user_id != self.answer_choice.question.poll.author.id
  end

  def not_poll_author
    unless not_poll_author?
      self.errors[:user] << 'cannot respond to own poll'
    end
  end
  
end
