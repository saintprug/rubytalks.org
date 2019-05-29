FROM ruby:2.6.3

RUN apt-get update -qqy && apt-get install  -qqyy postgresql postgresql-contrib libpq-dev cmake

RUN rm -rf /var/lib/apt/lists/*
