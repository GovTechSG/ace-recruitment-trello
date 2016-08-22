FROM ruby:2.3
MAINTAINER Jia Rong <jr.loves.maths@gmail.com>

WORKDIR /usr/app

COPY Gemfile Gemfile.lock /usr/app/
RUN bundle install

COPY . /usr/app

ENTRYPOINT ["ruby", "app.rb"]
