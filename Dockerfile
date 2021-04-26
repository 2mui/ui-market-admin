FROM ruby:3.0.0 AS builder

# Build libvps
# https://github.com/CompanyCam/ruby-vips-docker/blob/master/Dockerfile
ENV LIBVIPS_VERSION_MAJOR 8
ENV LIBVIPS_VERSION_MINOR 10
ENV LIBVIPS_VERSION_PATCH 5
ENV LIBVIPS_VERSION $LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR.$LIBVIPS_VERSION_PATCH

RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install --no-install-recommends -y build-essential git libpq-dev nodejs yarn \
  ca-certificates imagemagick apt-utils libxml2-dev \
  libfftw3-dev libmagickwand-dev libopenexr-dev liborc-0.4-0 gobject-introspection \
  libgsf-1-dev libglib2.0-dev liborc-0.4-dev automake libtool swig gtk-doc-tools \
  libgtk2.0-dev flex bison && \
  cd /tmp && \
  curl -OL https://github.com/libvips/libvips/releases/download/v$LIBVIPS_VERSION/vips-$LIBVIPS_VERSION.tar.gz && \
  tar zvxf vips-$LIBVIPS_VERSION.tar.gz && \
  cd /tmp/vips-$LIBVIPS_VERSION && \
  ./configure --enable-debug=no --without-python $1 && \
  make && \
  make install && \
  ldconfig && \
  apt-get remove -y curl automake build-essential && \
  apt-get autoremove -y && \
  apt-get autoclean && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


FROM builder

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY package.json yarn.lock $APP_HOME/
RUN yarn install

# RUN gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ && gem install bundler:2.2.6
RUN gem install bundler:2.2.11 && bundle config mirror.https://rubygems.org https://gems.ruby-china.com
ADD Gemfile* $APP_HOME/
RUN bundle install --without development test

ADD package.json yarn.lock  $APP_HOME/
RUN yarn install --check-files

ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=818eab1662e8d33cfe4a2c55016e836ff1da6613b215e4ad30935fa3dc5517433c0e53236d8898e41b643e932dc892f75e39edd247569c418a574232579449c5

ADD . $APP_HOME
# RUN RAILS_ENV=production bundle exec rails db:setup

# https://github.com/rails/rails/issues/32947
RUN RAILS_MASTER_KEY=83895a737e1c4791e7721bb43e23e9f6 RAILS_ENV=production bundle exec rake assets:precompile

CMD ["rails","server","-b","0.0.0.0", "-e", "production"]
