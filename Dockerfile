FROM ruby:2.5.1-alpine

ENV APP_ROOT /sample_app

WORKDIR $APP_ROOT

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN apk upgrade --no-cache && \
    apk add --update --no-cache \
      mysql-client \
      nodejs \
      tzdata && \
    apk add --update --no-cache --virtual=build-dependencies \
      build-base \
      curl-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      mysql-dev \
      ruby-dev \
      yaml-dev \
      zlib-dev && \
    gem install bundler && \
    echo 'gem: --no-document' >> ~/.gemrc && \
    cp ~/.gemrc /etc/gemrc && \
    chmod ugo+r /etc/gemrc && \
    bundle config --global build.nokogiri --use-system-libraries && \
    bundle install -j4 --path=vendor/bundle && \
    apk del build-dependencies && \
    rm -rf ~/.gem

COPY . $APP_ROOT

EXPOSE  3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
