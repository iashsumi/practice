FROM ruby:2.5
ENV LANG C.UTF-8
 
ENV APP_ROOT /app
WORKDIR $APP_ROOT
 
RUN apt-get update -qq && apt-get install -y mysql-client
# https://qiita.com/m-dove/items/a60b1a09d32299d215bb
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN bundle install

COPY . $APP_ROOT
 
EXPOSE 3000
 
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]