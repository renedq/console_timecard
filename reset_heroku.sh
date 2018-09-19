#!/bin/bash
heroku run rake db:migrate --remote uat
heroku run rake db:seed --remote uat
