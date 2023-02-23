class Placement < ApplicationRecord

  MIN_POSITION = 1

  validates :position, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: MIN_POSITION }
  validate :cannot_have_duplicate_position, :cannot_have_duplicate_racer

  belongs_to :racer
  belongs_to :race

  scope :from_race, -> (race_id) { where(race_id: race_id) }
  scope :with_position, -> (position) { where(position: position) }
  scope :with_racer, -> (racer_id) { where(racer_id: racer_id) }

  def cannot_have_duplicate_racer
    if Placement.from_race(race_id).with_racer(racer_id).present?
      errors.add(:racer_id, 'racer is already on the race')
    end
  end

  def cannot_have_duplicate_position
    if Placement.from_race(race_id).with_position(position).present?
      errors.add(:position, 'position is already ocuppied')
    end
  end
end
