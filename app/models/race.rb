class Race < ApplicationRecord
  validates :date, presence: true
  validates :place, presence: true

  belongs_to :tournament

  has_many :placements
end
