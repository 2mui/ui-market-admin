source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  # gem 'spring'
end

gem 'sitemap_generator', '~> 6.1', '>= 6.1.2'

gem 'listen', '~> 3.3'

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'devise', '~> 4.7', '>= 4.7.3'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-wechat-oauth2', github: 'yangsr/omniauth-wechat-oauth2'

gem 'friendly_id', '~> 5.4', '>= 5.4.1'

gem 'sidekiq', '~> 6.1', '>= 6.1.2'
gem 'sidekiq-cron', '~> 1.1'
gem 'sidekiq-failures'

gem 'name_of_person', '~> 1.1', '>= 1.1.1'

gem 'administrate', github: 'thoughtbot/administrate'
gem 'activestorage-aliyun'

# https://dreamersoul.github.io/administrate-field-active_storage/
gem 'administrate-field-active_storage'
gem 'administrate-field-boolean_emoji', '~> 0.2.1'

# gem 'administrate-field-jsonb', github: 'codica2/administrate-field-jsonb'
# gem 'administrate-field-jsonb', github: 'kayhide/administrate-field-jsonb'
# gem 'administrate-field-tag', github: 'herregroen/administrate-field-tag'
# gem 'administrate-field-enum'
# gem 'administrate-field-collection_select', github: 'headwayio/administrate-field-collection_select', branch: 'feature/rails-6'

# gem 'administrate-field-jsonb'
gem 'image_processing'
# gem 'activestorage-tencent_cos'
# gem 'activestorage-tencent_cos', github: 'df1228/activestorage-tencent_cos'

gem 'enumerize'
gem 'pundit'

# gem 'multi_json'

# # https://github.com/rswag/rswag
# gem 'rswag-api'
# gem 'rswag-ui'

group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec', require: false
  # gem 'rswag-specs'
end

gem 'airbrake'
# gem 'skylight'
gem 'pghero'

group :development do
  gem 'brakeman'
end

gem 'discard', '~> 1.2'

# https://ruby-china.org/topics/41077
# 0.3.5
gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f'


# invoke scf function in sidekiq worker
gem 'tencentcloud-sdk-common', git: 'https://github.com/TencentCloud/tencentcloud-sdk-ruby', glob: 'tencentcloud-sdk-common/*.gemspec'
gem 'tencentcloud-sdk-scf', git: 'https://github.com/TencentCloud/tencentcloud-sdk-ruby', glob: 'tencentcloud-sdk-scf/*.gemspec'
