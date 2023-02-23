require 'rails_helper'

RSpec.describe Race, type: :model do
  describe 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :place }
  end
end