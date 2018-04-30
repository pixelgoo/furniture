Rails.application.configure do

  Rails.logger = Logger.new(STDOUT)

  config.webpacker.check_yarn_integrity = false

  config.cache_classes = false
  config.eager_load = false

  config.consider_all_requests_local = true

  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.action_mailer.perform_caching = false
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      user_name:      Rails.application.secrets.mail_username,
      password:       Rails.application.secrets.mail_password,
      domain:         Rails.application.secrets.mail_host,
      address:       'smtp.gmail.com',
      port:          '587',
      authentication: :login,
      enable_starttls_auto: true
  }
  
  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.file_watcher = ActiveSupport::FileUpdateChecker

  config.assets.enabled = true
  config.assets.debug = false
  config.assets.raise_runtime_errors = false

  # Expose localhost to ngrok for liqpay callback testing
  # config.exposed_host = 'http://51b4a7f7.ngrok.io'
end
