FROM ruby:2.3-alpine
MAINTAINER leifcr@gmail.com

ENV APP_HOME /app

# update/upgrade everything
RUN apk update && apk upgrade

# Install needed packages

# For staging and production env, duck-cli must be installed to be able to download refile assets

# When newer alpine is released (3.5 or 3.6), change imagemagick to graphicsmagick
RUN apk add --no-cache \
  bash \
  build-base \
  bzip2 \
  bzip2-dev \
  curl \
  curl-dev \
  db-dev \
  file \
  fontconfig \
  geoip-dev \
  git \
  glib-dev \
  gnupg \
  imagemagick \
  imagemagick-dev \
  jpeg-dev \
  libevent-dev \
  libffi-dev \
  libpng-dev \
  libtool \
  libxml2-dev \
  libxslt-dev \
  linux-headers \
  mariadb-client \
  mariadb-dev \
  ncurses-dev \
  nodejs \
  openssl \
  openssl-dev \
  readline-dev \
  sqlite-dev \
  tzdata \
  xz \
  xz-dev \
  yaml-dev \
  zlib-dev

# Install phantomjs
RUN mkdir -p /usr/share && \
  cd /usr/share \
  && curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj \
  && ln -s /usr/share/phantomjs/phantomjs /usr/bin/phantomjs \
  && phantomjs --version

# Create application folder and ssh-agent folder
# Setup rails user group and rails user
# Set rails:rails as user on app and ssh-agent folder
RUN mkdir $APP_HOME && \
    mkdir /ssh-agent && \
    groupadd -g 1000 rails && \
    useradd -s /bin/bash -m -d /home/rails -g rails rails && \
    chown rails:rails /app && \
    chown rails:rails /ssh-agent

# Copy docker entry point
COPY docker-entrypoint.sh /usr/local/bin/

# Make entrypoint executable when building on Windows
# And backwards compatible entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && ln -s /usr/local/bin/docker-entrypoint.sh /docker-entrypoint.sh

# Continue as rails user
USER rails

# Set workdir to /app, so COPY, ADD, RUN and ENTRYPOINT is run within folder
WORKDIR $APP_HOME

# Add Gemfile
COPY Gemfile Gemfile.lock ./
# Install gems
RUN gem install bundler && bundle install --jobs 20 --retry 5
# Disable skylight dev warning
RUN skylight disable_dev_warning

# Set entry point to bundle exec, as all cmd's with rails should be prepended
ENTRYPOINT ["docker-entrypoint.sh"]
