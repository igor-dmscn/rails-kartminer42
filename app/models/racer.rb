class Racer < ApplicationRecord

  MIN_AGE = 18

  validates :name, presence: true
  validates :born_at, presence: true, comparison: { less_than_or_equal_to: MIN_AGE.years.ago, message: "must be at least #{MIN_AGE} years old" }
  validates :image_url, format: { with: URI::DEFAULT_PARSER.make_regexp }

  has_many :placements
end
