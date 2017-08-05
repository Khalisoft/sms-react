FactoryGirl.define do
  factory :address do
    kind { [:home, :work].sample }
    name { "#{Faker::Address.street_address}, #{Faker::Address.zip}"}
  end
end
