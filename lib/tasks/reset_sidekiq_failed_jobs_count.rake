namespace :sidekiq do
  desc "This task reset Sidekiq Failed Jobs to zero!"

  task :reset_failed_jobs_count do
    puts "Reset sidekiq failed count!"

    Sidekiq.redis {|c| c.del('stat:failed') }
  end
end
