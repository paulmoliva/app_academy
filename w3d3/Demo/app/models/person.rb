class Person < ActiveRecord::Base
  validates :house_id, :name, presence: true

  belongs_to(
  :house,
  :foreign_key => :house_id,
  :primary_key => :id
  )

#   belongs_to(
#   :professor,
#   :class_name => "Professor",
#   :foreign_key => :professor_id,
#   :primary_key => :id
# )


end
