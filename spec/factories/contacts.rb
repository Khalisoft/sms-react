FactoryGirl.define do
  factory :contact do
    email Faker::Internet.email
    phone Faker::PhoneNumber.cell_phone
  end
end
