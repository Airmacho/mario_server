add comments in (job) migration file, to explain extra columns
add audited gem to implement audit log feature

# README

You need to accomplish following tasks
- Dashboard that shows currently allocated jobs in a date period
    /jobs?query_date=2022-10-31&status=allocated
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

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
