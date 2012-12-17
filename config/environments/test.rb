FenixReader::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr
  
  # ActionMailer Config
  config.action_mailer.default_url_options = { :host => 'example.com' }

  # mocks for omniauth
  require 'omniauth'
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = Hashie::Mash.new(
    'provider' => 'twitter',
    'credentials' => {
      'token' => '179383862-hJS4mnfNIG14iReW2zgPTemqoz1ZWrpE1cf8o9zk',
      'secret' => 'U03Wc1ZIhodLeg11TEdtM0ewFO1OV1ebuyY3AF8'
    },
    'extra' => {
      'raw_info' => {
        'id' => '1337',
        'name' => 'Diegote'
      }
    }
  )
  OmniAuth.config.mock_auth[:google_oauth] = Hashie::Mash.new(
    "provider" => "google_oauth",
    "info"=>
      {"email" => "example_user@gmail.com",
       "uid"=> "example_user@gmail.com",
       "name" => "Guido Su"},
    "credentials"=>
      {"token"=>"longlivedtokenforgoogle",
       "secret"=>"thesecretforthetoken"}
    )

end
