class Racer < ApplicationRecord

  MIN_AGE = 18

  validates :name, presence: true
  validates :born_at, presence: true, comparison: { less_than_or_equal_to: MIN_AGE.years.ago, message: "must be at least #{MIN_AGE} years old" }
  validates :image_url, allow_blank: true, format: { with: URI::DEFAULT_PARSER.make_regexp }

  has_many :placements

  scope :from_tournament, -> (tournament_id) { joins(placements: [race: [:tournament]]).where(placements: { races: { tournament_id: tournament_id }}) }

  def points_from_tournament(tournament_id)
    Placement.from_tournament(tournament_id).from_racer(id).pluck(:position).reduce(0) do |acc, position|
      points = if position == Placement::FIRST_PLACE
        Placement::FIRST_PLACE_SCORE
      elsif position == Placement::SECOND_PLACE
        Placement::SECOND_PLACE_SCORE
      elsif position == Placement::THIRD_PLACE
        Placement::THIRD_PLACE_SCORE
      else
        Placement::NO_SCORE
      end
      acc + points
    end
  end
end
