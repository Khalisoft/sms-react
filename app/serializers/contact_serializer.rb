class ContactSerializer < ActiveModel::Serializer
  attributes :id, :email, :phone

  belongs_to :student
end

