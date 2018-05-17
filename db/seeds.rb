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
      unit_id: i,
      first_name: first_name,
      last_name: last_name,
      email_address: "#{first_name}.#{last_name}.mil@mail.mil".downcase
    )
  end
end

1.times do
  day_of_timecard = Time.now()
  Timecard.create!(
    user_id:      rand(1..250),
    start_date:   day_of_timecard - rand(10000..20000),
    end_time:     day_of_timecard
  )
end
