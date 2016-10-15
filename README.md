# README

*Note: this project was a coding test which was a part of the interview process. Result - test was accepted and I passed to the next interview stage.*

Simple application that allows admin users to upload documents and simple users look at these documents and download them

## Tech used

Gems:

* _devise_ - for user login/authentication
* _carrrierwave, fog_ and _figaro_ - for file upload via AWS S3
* _Rspec_ and _factory-girl-rails_ - test suite
* _rubocop_ - for enforced ruby style guide

Database adapter used: PostGreSQL.

Admin functionality is implemented with boolean value of `admin: true/false` of every user. By default is `false` when user is created. To upgrade user to admin launch `rails console` and run `User.find(:id).update_attributes(admin: true)`.

## To use

1. Download the repo.
2. Run the `bundle install` command to install all the gems.
3. Start the server with `rails server` command.