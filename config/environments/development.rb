Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send. Avant c'etaait false, on a changé par true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # On va Speciefier le URI pour Action Cable
  config.action_cable.url = "ws://localhost:3000/cable"

  # Ajouter la definition de URL options lors de l'instalation de devise
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # On va rajouter quelquer paramètres pour le smtp

  config.action_mailer.delivery_method = :smtp

  # Configurations pour envoyer email avec gmail
  # config.action_mailer.smtp_settings = {
  #   address: 'smtp.gmail.com',  
  #   port: 587,
  #   enable_starttls_auto: true,
  #   authentication: 'plain',
  #   user_name: 'kinywa.paris@gmail.com',
  #   password: 'Fabrice2017'
  # }

  # Configurations pour envoyer e-mail avec Mailgun
  config.action_mailer.smtp_settings = {
      address: 'smtp.mailgun.org',
      port: 587,
      domain: 'sandbox410428bd8cdb465993954e0214b239ba.mailgun.org',  
      #enable_starttls_auto: true,
      authentication: 'plain',
      user_name: 'postmaster@sandbox410428bd8cdb465993954e0214b239ba.mailgun.org',
      password: '3b4c8f695015c85781955edc1a600370'
  }

  # Configuration for amazon Web Services
  config.paperclip_defaults = {
    storage: :s3,
    path: 'class/:attachment/:id/:style/:filename',
    s3_host_name: 's3-eu-west-2.amazonaws.com',
    s3_credentials: {
      bucket: 'kinywa2',
      access_key_id: 'AKIAJKLZN7ZVYXSK44DA ',
      secret_access_key: '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',
      s3_region: 'eu-west-2'
    } 

  }
  
end
