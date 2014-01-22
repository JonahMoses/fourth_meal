# FoodFight
## The Best Restaurant Network!

This project was a collaboration between @Agsiegert, @BryanaKnight, and @JonahMoses -
all students of [gSchool](http://gschool.it) under the teaching of @jcasimir.

The project requirements can be found here: [Fourth Meal](http://http://tutorials.jumpstartlab.com/projects/fourth_meal.html).

## To get started:

- clone the project
- bundle
- the app requires redis to upload images (for admins only)

## To set up PG locally

- 'rake db:setup'
- 'rake db:migrate'

## Tests

- rake db:test:prepare will make your test db ready to run tests
- to run tests, run 'rspec'
- To create test files using rspec
  - 'rails g rspec:model'
  - 'rails g rpec:controller'


## Redis
- 'brew install redis'
- 'redis-server' to active a live redis server

*Project built on Rails 4.0.0, and uses Twitter Bootstrap*
