require 'pry'

puts("Adding units...")
Unit.create name: "182 AW", city: "Peoria", state:  "IL", phone_number: "309.633.5286"
9.times do | i |
  Unit.create name: "#{rand(100..200)} AW", city: Faker::Address.city, state: Faker::Address.state_abbr, phone_number: Faker::PhoneNumber.phone_number
end

User.create! unit_id: 1, first_name: "Rene", last_name: "Duquesnoy", email: "rene.p.duquesnoy.mil@mail.mil", admin: true, super_admin: true, password: 'abcdef'
User.create! unit_id: 1, first_name: "Tom", last_name: "Duquesnoy", email: "test@mail.mil", admin: false, super_admin: false, password: 'testtest'
User.create! unit_id: 1, first_name: "Admin", last_name: "Duquesnoy", email: "admin@mail.mil", admin: true, super_admin: false, password: 'adminadmin'

puts("Adding users...")
2.times do | i |
  7.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create!(
      unit_id: i+1,
      first_name: first_name,
      last_name: last_name,
      email: "#{first_name}.#{last_name}.mil@mail.mil".downcase,
      password: 'testtest'
    )
  end
end

puts("Adding timecards...")
300.times do
  day_of_timecard = Time.now.utc - (60 * 60 * 24 * rand(1..180))
  Timecard.create!(
    user_id:      rand(1..14),
    start_time:   day_of_timecard - rand(10000..20000),
    hours:        rand(1.01..8.99).round(2)
  )
end

5.times do | i |
  day_of_timecard = Time.now.utc - (60 * 60 * 24 * rand(1..2))
  Timecard.create!(
    user_id:      i+1,
    start_time:   day_of_timecard - rand(1000..2000),
    hours:        0 
  )
end
