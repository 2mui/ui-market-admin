redis_host_url = nil

if Rails.env.production?
  redis_host_url = 'redis://redis:6379/0'
else
  redis_host_url = 'redis://127.0.0.1:6379/0'
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_host_url }
  schedule_file = "config/schedule.yml"
  if File.exists?(schedule_file) 
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_host_url }
end
