Rails.application.configure do

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.webpacker.check_yarn_integrity = false
  
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  config.action_mailer.default_url_options = { :host => 'woodmister.herokuapp.com' }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      domain: "gmail.com",
      authentication: "login",
      enable_starttls_auto: true,
      openssl_verify_mode: "none",
      user_name:      ENV["MAIL_USERNAME"],
      password:       ENV["MAIL_PASSWORD"],
  }


  config.read_encrypted_secrets = false

  config.secret_key_base = ENV["SECRET_KEY_BASE"]

  config.force_ssl = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.action_controller.asset_host = 'https://d3lbdc0bfetw94.cloudfront.net'

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.active_record.dump_schema_after_migration = false

  config.exposed_host = 'https://woodmister.herokuapp.com'
end
