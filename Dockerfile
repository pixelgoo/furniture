FROM ruby:2.5 
LABEL maintainer="pixelgoo@gmail.com"

RUN apt-get update && apt-get install -y \
  curl \
  build-essential

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8

RUN mkdir -p /woodmister 
WORKDIR /woodmister

COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000
