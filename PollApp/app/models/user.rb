class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

  def completed_polls
    Poll
      .joins('JOIN questions ON questions.poll_id = polls.id')
      .joins('JOIN answer_choices ON questions.id = answer_choices.id')
      .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
      .group('polls.id')
      .count(:question_id)
      # .having("COUNT(DISTINCT(questions.id)) = COUNT(responses.user_id = ?)", self.id)
  end

  def uncompleted_polls
    Poll
      .joins('JOIN questions ON questions.poll_id = polls.id')
      .joins('JOIN answer_choices ON questions.id = answer_choices.id')
      .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
      .group('polls.id')
      .having("COUNT(DISTINCT(questions.id)) > COUNT(responses.user_id = ?)", self.id)
  end


end
