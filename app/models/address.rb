# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  kind       :string
#  name       :string
#  student_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_addresses_on_student_id  (student_id)
#

class Address < ApplicationRecord
  # validations
  validates :kind, presence: true
  validates :name, presence: true

  # associations
  belongs_to :student
end
