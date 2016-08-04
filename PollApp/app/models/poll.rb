class Poll < ActiveRecord::Base
  validates :user_id, :title, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :questions,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Question

  has_many :answer_choices,
    through: :questions,
    source: :answer_choices
end
