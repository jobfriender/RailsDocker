FROM heroku/heroku:16-build
MAINTAINER Nathan Sire <nathansire@jobfriender.com>

#RUN apt-get install -y --no-install-recommends apt-utils build-essential
RUN apt-get update
RUN apt-get install -y libpq-dev # for postgres

# Install packages for building ruby
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

# Install Ruby
RUN mkdir -p /app/heroku/ruby/ruby-2.4.5
RUN curl -s --retry 3 -L https://heroku-buildpack-ruby.s3.amazonaws.com/heroku-16/ruby-2.4.5.tgz | tar xz -C /app/heroku/ruby/ruby-2.4.5
ENV PATH /app/heroku/ruby/ruby-2.4.5/bin:$PATH

# ruby source files
#RUN apt-get install -y ruby2.3-dev
# Install rbenv and ruby-build
#RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
#RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
#RUN /root/.rbenv/plugins/ruby-build/install.sh
#ENV PATH /root/.rbenv/bin:$PATH
#RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
#RUN echo 'eval "$(rbenv init -)"' >> .bashrc
#ENV CONFIGURE_OPTS --disable-install-doc
#RUN xargs -L 1 rbenv install 2.4.1
#RUN xargs -L 1 rbenv global 2.4.1

RUN apt-get install -y libxml2-dev libxslt1-dev # for nokogiri
RUN apt-get install -y libqtwebkit4 libqt4-dev xvfb # for capybara-webkit
RUN apt-get install -y nodejs # for a JS runtime
RUN apt-get install -y qt5-default libqt5webkit5-dev # capybara webkit needs this

RUN apt-get install rsync

# https://medium.com/magnetis-backstage/how-to-cache-bundle-install-with-docker-7bed453a5800
# Set an environment variable to store where the app is installed to inside
# of the Docker image.
#ENV APPHOME /var/www
#COPY Gemfile* /tmp/
# cache the gems
#WORKDIR /tmp
#RUN bundle install
#RUN mkdir $APP_HOME
#WORKDIR $APP_HOME
#ADD . $APPHOME

ENV APPHOME /var/www
RUN mkdir $APPHOME
WORKDIR $APPHOME
ENV BUNDLE_PATH /box
ADD . $APPHOME

# rsync
EXPOSE 873
