require 'pry'

Unit.create name: "182 AW/Peoria"

User.create unit_id: 1, first_name: "Rene", last_name: "Duquesnoy", email_address: "rene.p.duquesnoy.mil@mail.mil", admin: true


puts("Adding users...")
25.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create!(
      unit_id: 1,
      first_name: first_name,
      last_name: last_name,
      email_address: "#{first_name}.#{last_name}.mil@mail.mil".downcase
    )
  end
