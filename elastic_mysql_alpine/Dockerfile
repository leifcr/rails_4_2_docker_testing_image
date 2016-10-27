FROM ruby:2.3-alpine
MAINTAINER leifcr@gmail.com

ENV ELASTICSEARCH_VERSION 2.4.1
ENV APP_HOME /app
ARG MYSQL_ROOT_PASSWORD=root

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
  ca-certificates \
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
  mariadb \
  mariadb-client \
  mariadb-dev \
  memcached \
  ncurses-dev \
  nodejs \
  openjdk8-jre \
  openssl \
  openssl-dev \
  readline-dev \
  sqlite-dev \
  tzdata \
  xz \
  xz-dev \
  yaml-dev \
  zlib-dev \

# # grab gosu for easy step-down from root
# ENV GOSU_BASE https://github.com/tianon/gosu/releases/download
# ENV GOSU_VERSION 1.10
# RUN set -x \
#     && wget -O /usr/local/bin/gosu "$GOSU_BASE/$GOSU_VERSION/gosu-$(apk --print-arch |sed -e 's/x86_64/amd64/')" \
#     && wget -O /usr/local/bin/gosu.asc "$GOSU_BASE/$GOSU_VERSION/gosu-$(apk --print-arch |sed -e 's/x86_64/amd64/').asc" \
#     && export GNUPGHOME="$(mktemp -d)" \
#     && gpg2 --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
#     && gpg2 --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
#     && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
#     && chmod +x /usr/local/bin/gosu \
#     && gosu nobody true

ENV ELASTICSEARCH_VERSION 2.4.1
ENV ELASTICSEARCH_DOWNLOAD https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch
RUN mkdir -p /opt && adduser -h /opt/elasticsearch -g elasticsearch -s /bin/bash -D elasticsearch

WORKDIR /opt
RUN ln -s elasticsearch elasticsearch-$ELASTICSEARCH_VERSION
RUN set -x \
    && wget -O - "$ELASTICSEARCH_DOWNLOAD/$ELASTICSEARCH_VERSION/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz" | tar zxvf -

ENV PATH /opt/elasticsearch/bin:$PATH

# WORKDIR /opt/elasticsearch
RUN set -ex \
    && for path in \
        /opt/elasticsearch/data \
        /opt/elasticsearch/logs \
        /opt/elasticsearch/config \
        /opt/elasticsearch/config/scripts \
    ; do \
        mkdir -p "$path"; \
        chown -R elasticsearch:elasticsearch "$path"; \
    done

COPY elasticsearch-config /opt/elasticsearch/config

RUN set -x \
  && /usr/bin/mysql_install_db --user=mysql \
  && echo `(mysqld_safe &)` \
  && sleep 10 \
  && /usr/bin/mysqladmin -u root password $MYSQL_ROOT_PASSWORD \
  && /usr/bin/mysqladmin shutdown -u root --password=$MYSQL_ROOT_PASSWORD

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

# Create application folder
RUN mkdir $APP_HOME

# Image is for ci integration, so entrypoint is not used
# Copy docker entry point
# COPY docker-entrypoint.sh /usr/local/bin/

# Set workdir to /app, so COPY, ADD, RUN and ENTRYPOINT is run within folder
WORKDIR $APP_HOME

# Add Gemfile
COPY Gemfile Gemfile.lock ./
# Install gems
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Disable skylight dev warning
RUN skylight disable_dev_warning

RUN apk del gnupg && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*
