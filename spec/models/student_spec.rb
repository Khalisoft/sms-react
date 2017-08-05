require 'rails_helper'

RSpec.describe Student, type: :model do
  context 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :country }
    it { should validate_presence_of :experiences }
  end

  context 'associations' do
    it { should have_many :addresses }
    it { should have_many :contacts }
  end
end
