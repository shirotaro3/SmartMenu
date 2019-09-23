FROM ruby:2.5.5-alpine

ENV LANG C.UTF-8
ENV HOME /myproject

WORKDIR $HOME

COPY Gemfile $HOME
COPY Gemfile.lock $HOME

RUN apk update -qq && apk add --no-cache build-base tzdata libxml2-dev libxslt-dev alpine-sdk postgresql-dev nodejs

RUN gem install bundler
RUN bundle install
