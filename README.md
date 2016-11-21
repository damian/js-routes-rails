# Js::Routes::Rails

Generates a JavaScript file containing a predefined set of Rails URL helpers on the client.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'js-routes-rails'
```

And then execute:

    $ bundle

## Set up

Append `export: true` to any route defined in you `config/routes.rb` which declares that resource able to be exported to the client.

```ruby
# config/routes.rb
resources :articles, export: true

resources :comments

resources :publishers, export: true do
  resources :magazines do
    resources :photos
  end
end

match "/about", to: "static#index", via: :get, export: true
```

And then execute:

    $ bundle exec rake js_routes_rails:export

This will generate a JavaScript file in `app/assets/javascripts/js-routes-rails.js`, which you can consume using the Asset Pipeline, for example:


```ruby
<%= javascript_include_tag 'js-routes-rails' %>
```

or in `application.js`

```javascript
//= 'js-routes-rails'
```

## Usage

Once you've brought the exported file in to your project your now able to use the `JsRoutesRails` object which gives you access to all of your Rails URL helpers on the client.

```javascript
JsRoutesRails.new_articles_path() // '/articles/new'
JsRoutesRails.edit_articles_path({ id: 23 }) // '/articles/23/edit'
JsRoutesRails.edit_magazines_path({ publishers_id: 5, id: 9 }) // '/publishers/5/magazines/9/edit'
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/damian/js-routes-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

