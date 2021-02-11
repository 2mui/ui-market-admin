if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://redis:6379/0' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://redis:6379/0' }
  end
else
  # dev. and test settings
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://127.0.0.1:6379/0' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://127.0.0.1:6379/0' }
  end
end
