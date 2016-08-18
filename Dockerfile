FROM ruby:2.3.1-alpine
MAINTAINER Jia Rong <jr.loves.maths@gmail.com>

# Update and install base packages
RUN apk update \
    && apk upgrade \
    && apk add curl wget bash \
    && apk add ruby ruby-bundler alpine-sdk \
    && rm -rf /var/cache/apk/*

WORKDIR /usr/app

COPY Gemfile Gemfile.lock /usr/app/
RUN bundle install

COPY . /usr/app

ENTRYPOINT ["ruby", "job.rb"]
