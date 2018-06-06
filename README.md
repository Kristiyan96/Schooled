# README

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
*

## Documentation and stuff to know

Getting all schedules with a given group and time period will look like this:

```
Schedule.with_courses_for_period(group, period_start, period_end)
```
