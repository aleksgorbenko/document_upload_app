# README

Simple application that allows admin users to upload documents and simple users look at these documents and download them

## Tech used

Gems:

* devise - for user login/authentication
* carrrierwave, fog and figaro - for file upload via AWS S3
* Rspec and factorygirl_rails - test suite
* rubocop - for enforced ruby style guide

Database adapter used: PostGreSQL.

## To use

1. Download the repo.
2. Run the `bundle install` command to install all the gems.
3. Start the server with `rails server command`.