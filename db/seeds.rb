require 'pry'

puts("Adding units...")
Unit.create name: "182 AW/Peoria, IL"
10.times do | i |
  Unit.create name: "#{rand(100..200)} AW/#{Faker::StarWars.planet}"
end

User.create unit_id: 1, first_name: "Rene", last_name: "Duquesnoy", email_address: "rene.p.duquesnoy.mil@mail.mil", admin: true


puts("Adding users...")
10.times do | i |
  25.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create!(
      unit_id: i+1,
      first_name: first_name,
      last_name: last_name,
      email_address: "#{first_name}.#{last_name}.mil@mail.mil".downcase
    )
  end
end

puts("Adding timecards...")
3000.times do
  day_of_timecard = Time.now.utc - (60 * 60 * 24 * rand(1..180))
  Timecard.create!(
    user_id:      rand(1..250),
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
