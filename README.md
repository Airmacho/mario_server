# README

You need to accomplish following tasks
- Dashboard that shows currently allocated jobs in a date period
- Admin (manager) user authentication
- Add plumbers
- Add clients
- Add jobs by letting the admin user pair plumbers and clients. A job may link multiple plumbers to one client.
- Add an api endpoint to return jobs assigned to a plumber between a certain time period. This should include client details except private note
- Add an api endpoint allowing plumbers to mark an event done (no authentication required for this exercise)
- Add seed data

Well done
- logic should be safe and sound, add some personal assumption when design the APIs
- test cases covers both happy path and corner cases
- great test fixture setup
- add comments in (job) migration file, to explain extra columns
- add audited gem to implement audit log feature

To improve
- authentication is not implement due to limited time
- some business logic requires further discussion, like if a reserved_hours column in jobs table should be add to mark the estimated finished time, so when creating jobs, check if the plumber is available
- other credits like Vue/CI/cloud deployment is not implemented due to limited time, but deploy via Fly.io should be an easy job

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
* Ruby 3.0 + Rails 7.0.4

* Configuration
currently no further configs

* Database initalize
to simplify the db manipulation, use sqlite3 as persist layer.
rake db:drop db:create db:migrate db:seed

* How to run the test suite
use rspec as the test framework