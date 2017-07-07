FROM ruby:2.3
MAINTAINER leifcr@gmail.com

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_VERSION 8u131
ENV JAVA_DEBIAN_VERSION 8u131-b11-1~bpo8+1
# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20161107~bpo8+1

ENV ELASTICSEARCH_VERSION 2.4.2
ARG ELASTICSEARCH_REPO_BASE=http://packages.elasticsearch.org/elasticsearch/2.x/debian

ARG MYSQL_ROOT_PASSWORD=root

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4

RUN echo "deb $ELASTICSEARCH_REPO_BASE stable main" > /etc/apt/sources.list.d/elasticsearch.list; \
    echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list;\
    echo mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD | debconf-set-selections;\
    echo mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD | debconf-set-selections;

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  libmysqlclient-dev \
  libxml2-dev \
  libxslt1-dev \
  mysql-client \
  wget \
  nodejs \
  mysql-server \
  mysql-client \
  libmysqlclient-dev \
  ca-certificates \
  bzip2 \
  unzip \
  xz-utils \
  memcached \
  openjdk-8-jre-headless="$JAVA_DEBIAN_VERSION" \
  ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" \
  elasticsearch

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8


# BEGIN JAVA SETUP #
# Using openjdk-8 for elasticsearch

# This is directly from the official java docker image
# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre

RUN [ "$JAVA_HOME" = "$(docker-java-home)" ]

# see CA_CERTIFICATES_JAVA_VERSION notes above
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

# END JAVA SETUP

# Install gosu
ENV GOSU_VERSION 1.10
RUN set -x \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

# BEGIN ELASTICSEARCH SETUP

ENV PATH /usr/share/elasticsearch/bin:$PATH

WORKDIR /usr/share/elasticsearch

RUN set -ex \
	&& for path in \
		./data \
		./logs \
		./config \
		./config/scripts \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done

# END ELASTICSEARCH SETUP

# For staging and production env, duck-cli must be installed to be able to download refile assets
ENV APP_HOME /app

# BEGIN APP/RAILS SETUP

# Phantomjs installation
ENV PHANTOMJS_VERSION 2.1.1
# Bitbucket dl (usually has issues)
# Install phantomjs for testing purposes (only used on guard), but easier to add to docker base image
# Install official PhantomJS release
# RUN set -x  \
#  && mkdir /tmp/phantomjs \
#  && cd /tmp/phantomjs \
#  && wget --no-check-certificate https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -O - \
#    | tar -xj --strip-components=1 -C /tmp/phantomjs \
#  && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin

# Github dl as alternative
RUN set -x  \
 && mkdir /tmp/phantomjs \
 && cd /tmp/phantomjs \
 && wget -nv https://github.com/Medium/phantomjs/releases/download/v$PHANTOMJS_VERSION/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -O - \
   | tar -xj --strip-components=1 -C /tmp/phantomjs \
 && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin

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

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
