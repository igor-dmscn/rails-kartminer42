class Race < ApplicationRecord
  validates :date, presence: true
  validates :place, presence: true

  belongs_to :tournament

  has_many :placements
  has_many :racers, through: :placements, source: :racer

  accepts_nested_attributes_for :placements
  validates_associated :placements
end
