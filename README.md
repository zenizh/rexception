# Rexception

Rexception is a Rails plugin that renders error pages dynamically, such as 403, 404, 500, and so on.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rexception'
```

And then execute:

```
$ bundle
```

## Usage

The simplest way, just add `app/views/errors/application.html.erb`.
That's it, and Rails application render it when raise any errors.

If you placed specific views, such as `forbidden.html.erb` or `not_found.html.erb`, Rexception prefers these views to `application.html.erb`.
(File name is see also: [ActionDispatch::ExceptionWrapper.rescue_responses](https://github.com/rails/rails/blob/083f657c0f1990e980d33f89f44d8943a9270475/actionpack/lib/action_dispatch/middleware/exception_wrapper.rb#L9-L19))

And you can specify layout file, errors directory, and custom error handling.
Create `config/initializers/rexception.rb` and add following lines:

```ruby
Rexception.setup do |config|
  # Specify the layout file to use for rendering error page.
  # config.layout = 'application'

  # Specify the directory where you place error pages.
  # config.errors_dir = 'errors'

  # Define which of statuses return against custom exceptions.
  # config.rescue_responses = {
  #   'CustomException' => :not_found
  # }
end
```

In `development` mode, you should add this line to `config/environments/development.rb` to confirm error page:

```ruby
config.consider_all_requests_local = false
```

## Contributing

1. Fork it ( https://github.com/kami30k/rexception/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
