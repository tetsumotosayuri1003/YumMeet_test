# 使いたいバージョンを決めて{{}}をruby:tag名の形で置き換えてください
# 例: ARG RUBY_VERSION=ruby:3.2.2
ARG RUBY_VERSION=ruby:3.2.2
# {{}}を丸ごと使いたいnodeのversionに置き換えてください、小数点以下はいれないでください
# 例: ARG NODE_VERSION=19
ARG NODE_VERSION=21

FROM $RUBY_VERSION
ARG RUBY_VERSION
ARG NODE_VERSION
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential nodejs yarn
RUN mkdir /app
WORKDIR /app
RUN gem install bundler
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY yarn.lock /app/yarn.lock
RUN bundle install
RUN yarn install
COPY . /app

# 本環境でプリコンパイルするためのコマンド
# 下記エラー対策
# ActionView::Template::Error (The asset "application.css" is not present in the asset pipeline.
RUN /app/bin/rails assets:precompile

# railsサーバー起動コマンド
CMD ["rails", "server", "-b", "0.0.0.0"]
