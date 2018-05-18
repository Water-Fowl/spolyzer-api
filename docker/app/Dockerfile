FROM ruby:2.4.3

RUN mkdir /app
ENV APP_ROOT /app
WORKDIR $APP_ROOT
# 必要なものをインストール
RUN apt-get update
RUN apt-get install -y nodejs mysql-client --no-install-recommends
RUN rm -rf /var/lib/apt/lists/*
# ホスト側のGemfileをコピー
ADD Gemfile $APP_ROOT
ADD Gemfile.lock $APP_ROOT

# bundle install
RUN  bundle config --global build.nokogiri --use-system-libraries
RUN  bundle config --global jobs 4
RUN  bundle install

ADD . $APP_ROOT
COPY . $APP_ROOT
