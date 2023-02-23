class Race < ApplicationRecord
  validates :date, presence: true
  validates :place, presence: true
end
