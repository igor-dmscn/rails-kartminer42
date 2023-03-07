require 'rails_helper'

RSpec.describe Race, type: :model do
  describe 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :place }
  end

  describe 'associations' do
    it { should belong_to :tournament }

    it { should have_many :placements }
  end
end
