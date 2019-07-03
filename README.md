# Rubytalks
[![CircleCI](https://circleci.com/gh/saintprug/rubytalks.org/tree/master.svg?style=svg)](https://circleci.com/gh/saintprug/rubytalks.org/tree/master)

All Ruby talks in one place.

# Contributing
If you would like to contribute to the project please read the [CONTRIBUTING.md](https://gitlab.com/kova1/rubytalks/blob/master/CONTRIBUTING.md)

## Setup

How to run tests:

```
% bundle exec rake
```

How to run the development console:

```
% bundle exec hanami console
```

How to run the development server:

```
% bundle exec hanami server
```

How to prepare (create and migrate) DB for `development` and `test` environments:

```
% bundle exec hanami db prepare

% HANAMI_ENV=test bundle exec hanami db prepare
```
