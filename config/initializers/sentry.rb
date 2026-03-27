Sentry.init do |config|
  config.dsn = 'https://example@sentry.io/12345' 
  config.breadcrumbs_logger = [:active_support_logger]
  config.traces_sample_rate = 1.0
end