# README

# Url Shortner Service

# Url Shortner Service
A URL shortening service that can redirect a browser from a shortened link to an expanded URL.

## Available Endpoint Urls
| Feature           | URL                                       |
|-------------------|-------------------------------------------|
| Generate URL      | http://localhost:3000/short_urls/generate |
| Redirect URL      | http://localhost:3000/SHORT_URL           |


## Features Added
- Url Generation 
- URL redirection

## Tech

- [Ruby] - 3.0.0
- [Rails] - 6.1
- [Database] - SQlite

## Installation

Install the dependencies and devDependencies and start the server.

```sh
cd url_service
bundle install
rails db:prepare RAILS_ENV=development
rails s
```

## Run Tests
```sh
cd url_service
bundle install
rails db:prepare RAILS_ENV=test
rspec . OR bundle exec rspec .
```


## API Example

### Generate URL
```sh
curl -i -X POST \
   -H "Content-Type:application/json" \
   -d \
'{
  "url":"https://mail.google.com/mail/u/0/#inbox/FMfcgzGpGTJSgtsjJlBjpwvNzXjWKQCM"
}	' \
 'http://localhost:3000/short_urls/generate'
```

### Visit URL
```sh

curl -i -X GET \
-H "Content-Type:application/json" \
'http://localhost:3000/51348d' // Replace it with actual one
```
