## Setup
This app utilizes Ruby 2.5.0 and Rails 5.

```bash
RAILS_ENV=development bundle exec rake db:drop
RAILS_ENV=development bundle exec rake db:create
RAILS_ENV=development bundle exec rake db:schema:load
RAILS_ENV=development bundle exec rake db:migrate
RAILS_ENV=development bundle exec rake db:seed
TEST_USER_OVERRIDE=rduquesnoy bundle exec rails server
```

From there, you can visit [localhost:3000](http://localhost:3000) to try the site as a regular user. If you want to test admin functionality, visit the [/admin](http://localhost:3000/admin) namespaced section.

