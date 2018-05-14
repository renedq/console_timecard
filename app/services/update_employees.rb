class UpdateEmployees
  def call
    People.all.select {|person| person['status'] == 'Active'}.each do |person|
      domain = person['location_city'] == 'MONTREAL' ? 'vigilantglobal.com' : 'drwholdings.com'
      User.find_or_create_by(
        first_name: person['first_name'],
        last_name: person['last_name'],
        email_address: "#{person['username']}@#{domain}",
        username: person['username']
      )
    end
  end
end