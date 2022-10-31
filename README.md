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

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
