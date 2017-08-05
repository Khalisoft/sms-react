class StudentSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :country, :experiences

  has_many :addresses
  has_many :contacts
end
