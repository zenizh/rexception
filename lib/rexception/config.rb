Rexception.configure do |config|
  # Layout file name to use for rendering error page.
  config.layout = 'application'

  # Directory name where you place error pages.
  config.errors_dir = 'errors_dir'

  # Pairs of custom exceptions and statuses.
  config.rescue_responses = {
    'CustomException' => :not_found
  }
end
