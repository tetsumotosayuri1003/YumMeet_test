FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client

# Install yarn
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
  && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn libvips

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]


EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
