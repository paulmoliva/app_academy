# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  validates :name, :color, :birth_date, :description, presence: true
  validates :sex, presence: true, length: { maximum: 1 }, inclusion: { in: %w(M F) }

  def age
    current_date = Time.now.year
    age = current_date - self.birth_date.year
  end

  has_many :cat_rental_requests, :dependent => :destroy

end
