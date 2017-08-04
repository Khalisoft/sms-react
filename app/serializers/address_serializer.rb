class AddressSerializer < ActiveModel::Serializer
  attributes :id, :kind, :name

  belongs_to :student
end
