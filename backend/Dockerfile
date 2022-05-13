FROM ruby:3.0.2 as builder

WORKDIR /usr/src/app

RUN gem install bundler:2.3.3

COPY Gemfile Gemfile.lock ./

RUN bundle install

FROM ruby:3.0.2-slim-bullseye as base

WORKDIR /usr/src/app

RUN apt update && \
    apt install -y default-mysql-client curl

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

# develop
FROM base as dev

WORKDIR /usr/src/app
