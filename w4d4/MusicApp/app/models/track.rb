class Track < ActiveRecord::Base
  belongs_to :album
  has_many :notes
end
