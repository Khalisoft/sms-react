FactoryGirl.define do
  factory :student do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    country 'Nepal'
    experiences 'Ruby, Reactjs, es6, sass, html, css, javascript'
  end
end
