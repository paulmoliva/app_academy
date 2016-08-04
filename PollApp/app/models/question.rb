class Question < ActiveRecord::Base
  validates :poll_id, :body, presence: true

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results_n_plus_1
    result_hash = Hash.new { 0 }
    response_list = self.responses
    response_list.each do |response|
      result_hash[response.answer_choice.body] += 1
    end
    result_hash
  end

  def results_n
    AnswerChoice
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .where("answer_choices.question_id = ?", self.id)
      .group("answer_choices.body")
      .count(:answer_choice_id)
  end

end
