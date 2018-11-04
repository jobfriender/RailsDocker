FROM ruby:2.5
MAINTAINER Nathan Sire <nathansire@jobfriender.com>

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y libpq-dev # for postgres
RUN apt-get install -y nodejs # for a JS runtime

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV APP_HOME /var/www
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

# rsync
EXPOSE 873
