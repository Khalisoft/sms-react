require 'rails_helper'

RSpec.describe Address, type: :model do
  context 'validations' do
    it { should validate_presence_of :kind }
    it { should validate_presence_of :name }
  end

  context 'associations' do
    it { should belong_to :student }
  end
end
