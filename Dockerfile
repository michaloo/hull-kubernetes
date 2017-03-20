FROM ruby:2.2.5

# docker image convention
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y nodejs

COPY . /usr/src/app/

RUN bundle install
RUN bundle exec rake RAILS_ENV=production assets:precompile

ENV RAILS_ENV production
ENV RACK_ENV production
ENV UNICORN_WORKERS 4
ENV UNICORN_TIMEOUT 30
ENV ENFORCE_SSL false

ENV HULL_MONGO_URL mongodb://mongo:27017/hull_dev
# ENV HULL_DOMAIN
# ENV HULL_DASHBOARD_URL
#ENV AWS_ACCESS_KEY
#ENV AWS_SECRET_KEY
#ENV AWS_S3_BUCKET_NAME
ENV REDIS_URL redis://redis:6379/
ENV ELASTICSEARCH_URL http://elasticsearch:9200
# MOSQL_POSTGRES_URL="postgres://postgres:boom@localhost:5432/


ENTRYPOINT /usr/local/bin/bundle exec unicorn -p 3000 -c ./config/unicorn.rb --no-default-middleware
