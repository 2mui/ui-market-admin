FROM ruby:3.0.0

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# RUN gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ && gem install bundler:2.2.6
RUN gem install bundler:2.2.6 && bundle config mirror.https://rubygems.org https://gems.ruby-china.com
ADD Gemfile* $APP_HOME/
RUN bundle install


ADD . $APP_HOME
RUN yarn install --check-files

ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=818eab1662e8d33cfe4a2c55016e836ff1da6613b215e4ad30935fa3dc5517433c0e53236d8898e41b643e932dc892f75e39edd247569c418a574232579449c5

# RUN RAILS_ENV=production bundle exec rails db:setup
RUN RAILS_ENV=production bundle exec rake assets:precompile
CMD ["rails","server","-b","0.0.0.0", "-e", "production"]
