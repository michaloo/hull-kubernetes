FROM ruby:2.2.5

RUN apt-get update && apt-get install -y nodejs

# docker image convention
WORKDIR /usr/src/app

ENV UNICORN_WORKERS 1

#ENV HULL_MONGO_URL mongo
#ENV HULL_DOMAIN
#ENV AWS_ACCESS_KEY
#ENV AWS_SECRET_KEY
#ENV AWS_S3_BUCKET_NAME
#ENV REDIS_URL
#ENV HULL_DASHBOARD_URL

CMD ["bundle exec unicorn -p 3000 -c ./config/unicorn.rb --no-default-middleware"]

COPY . /usr/src/app/

RUN bundle install