require 'rails_helper'

RSpec.describe Contact, type: :model do
  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :phone }
  end

  context 'associations' do
    it { should belong_to :student }
  end
end
