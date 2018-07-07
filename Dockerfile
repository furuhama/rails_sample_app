FROM ruby:2.5.1

ENV APP_ROOT /sample_app

WORKDIR $APP_ROOT

RUN apt-get update && \
    apt-get install -y nodejs \
                       mysql-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod ugo+r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install --path=/vendor/bundle && \
  rm -rf ~/.gem

COPY . $APP_ROOT

EXPOSE  3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
