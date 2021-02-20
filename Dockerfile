FROM ruby:3.0.0

RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install --no-install-recommends -y ca-certificates build-essential libpq-dev nodejs yarn imagemagick && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY package.json yarn.lock $APP_HOME/
RUN yarn install

# RUN gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ && gem install bundler:2.2.6
RUN gem install bundler:2.2.11 && bundle config mirror.https://rubygems.org https://gems.ruby-china.com
ADD Gemfile* $APP_HOME/
RUN bundle install

ADD package.json yarn.lock  $APP_HOME/
RUN yarn install --check-files

ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=818eab1662e8d33cfe4a2c55016e836ff1da6613b215e4ad30935fa3dc5517433c0e53236d8898e41b643e932dc892f75e39edd247569c418a574232579449c5

ADD . $APP_HOME
# RUN RAILS_ENV=production bundle exec rails db:setup
RUN RAILS_ENV=production bundle exec rake assets:precompile
CMD ["rails","server","-b","0.0.0.0", "-e", "production"]
