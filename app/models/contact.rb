# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  email      :string
#  phone      :string
#  student_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contacts_on_student_id  (student_id)
#

class Contact < ApplicationRecord
  # validations
  validates :email, presence: true
  validates :phone, presence: true

  # associations
  belongs_to :student
end
