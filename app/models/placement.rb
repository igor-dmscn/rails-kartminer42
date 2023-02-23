class Placement < ApplicationRecord
  validates :position, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
