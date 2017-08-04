# == Schema Information
#
# Table name: students
#
#  id          :integer          not null, primary key
#  first_name  :string
#  last_name   :string
#  country     :string
#  experiences :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Student < ApplicationRecord
  # validations
  validates :first_name, presence: true
  validates :country, presence: true

  # associations
  has_many :addresses
  has_many :contacts
end
