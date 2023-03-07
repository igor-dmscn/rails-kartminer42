require 'rails_helper'

RSpec.describe Placement, type: :model do
  describe 'validations' do
    it { should validate_presence_of :position }
    it { should validate_numericality_of(:position).only_integer}
    it { should allow_value(1).for :position }
    it { should_not allow_value(0).for :position }
  end

  describe 'associations' do
    it { should belong_to :race }
    it { should belong_to :racer }
  end
end
