FROM ruby:2.5.3-alpine3.7
MAINTAINER Nathan Sire <nathansire@jobfriender.com>

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                nodejs \
                                tzdata

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV APP_HOME /var/www
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

# rsync
EXPOSE 873
