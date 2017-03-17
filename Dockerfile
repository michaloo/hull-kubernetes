FROM ruby:2.2.5-onbuild

CMD ["bundle exec unicorn -p 3000 -c ./config/unicorn.rb --no-default-middleware"]
