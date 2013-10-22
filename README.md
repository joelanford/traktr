# Traktr

Traktr is a ruby client API for the trakt.tv RESTful web service.  Trakt allows users to:

1. Automatically track what you're watching
2. Track your progress and see what's on tonight
3. Catalog your entire media collection
4. Submit ratings and reviews, follow other members, and make friends
5. Share to your social networks in real time
6. Discover new shows and movies
7. Organize lists of your favorite shows and movies to make sure you don't forget them

This client API supports all non-DEV REST methods.  (If you need the DEV methods, submit a pull request!)

The full API documentation can be found at http://trakt.tv/api-docs

## Installation

Add this line to your application's Gemfile:

    gem 'traktr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install traktr

## Usage

To interface with the Trakt API, you must create a client instance

```ruby
API_KEY       = "abcdefghijklmnopqrstuvwxyz"
USERNAME      = "john_doe"
PASSWORD      = "p@ssw0rd"
SHA1_PASSWORD = "57b2ad99044d337197c0c39fd3823568ff81e48a"

# for non-authenticated methods, you can create an instance without supplying
# username and password
@trakt = Traktr::Client.new(API_KEY)

# if you need to use an authenticated method, you can provide your plaintext
# password
@trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)

# or the SHA1 hash of your password
@trakt = Traktr::Client.new(API_KEY, USERNAME, SHA1_PASSWORD, true)
```

To get summary info about a movie, use the ```movie.summary``` method:

```ruby
# you can use the trakt.tv slug, IMDB ID, or TMDB ID
tdk = @trakt.movie.summary('the-dark-knight-2008')

# tdk is a Mash object that has methods for each field in the summary:
tdk.title
tdk.year
tdk.released
tdk.url
tdk.trailer
tdk.runtime
# etc ...
```

To search for a movie, use the ```search.movies``` method.

```ruby
# returns an array of movie summary results
results = @trakt.search.movies("Dark Knight")
results.each do |r|
  puts r.title
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
