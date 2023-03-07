require 'rails_helper'

RSpec.describe Racer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }

    it { should validate_presence_of :born_at }
    it { should allow_value((Racer::MIN_AGE + 1).years.ago).for :born_at }
    it { should_not allow_value((Racer::MIN_AGE - 1).years.ago).for :born_at }

    it { should allow_value(Faker::Internet.url).for :image_url }
    it { should_not allow_value(Faker::File.file_name).for :image_url }
  end

  describe 'associations' do
    it { should have_many :placements }
  end
end
