experiences = [
  'Web Development, C#, Ruby, ReactJs, ES6, SASS',
  'Desktop App Development, Xamarin',
  'Mobile App Development, React Native'
]

countries = ['China', 'India', 'Nepal', 'USA']

5.times do
  Student.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    experiences: experiences.sample,
    country: countries.sample
  )
end

Student.all.each do |student|
  student.addresses.create([
    {
      kind: 'Home',
      name: Faker::Address.street_address
    },
    {
      kind: 'Office',
      name: Faker::Address.street_address
    }
  ])

  student.contacts.create([
    {
      phone: Faker::PhoneNumber.cell_phone,
      email: Faker::Internet.email
    },
    {
      phone: Faker::PhoneNumber.cell_phone,
      email: Faker::Internet.email
    }
  ])
end
