# Shastic challenge

This is a solution to the [shastic ror coding challenge](https://bitbucket.org/shastic/coding-challenges/src/master/application_challenge/README.md)

## Overview
Simple Ruby project that connects to a fake api, collects statistics of website visits and stores them into a MySQL database

## Architecture
```
├── app
│   ├── models
│   │   ├── application_record.rb
│   │   ├── pageview.rb
│   │   └── view.rb
│   ├── services
│   │   └── web_stats_api_service.rb
│   └── web_stats_handler.rb
├── app.rb
├── db
│   ├── config.yml
│   ├── migrate
│   │   ├── 20201109121857_create_views.rb
│   │   ├── 20201109122059_create_pageviews.rb
│   │   └── 20201109122237_add_relationship.rb
│   └── schema.rb
├── docker
│   ├── app
│   │   ├── docker-entrypoint.sh
│   │   └── Dockerfile
│   └── mysql
│       └── Dockerfile
├── docker-compose.yml
├── Gemfile
├── Gemfile.lock
├── lib
│   └── api_faker
│       ├── api_faker.rb
│       └── public
│           └── sample.json
├── Rakefile
├── README.md
└── spec
    ├── models
    │   ├── pageview_spec.rb
    │   └── view_spec.rb
    ├── services
    │   └── web_stats_api_service_spec.rb
    ├── spec_helper.rb
    └── web_stats_handler_spec.rb
```

## Gems

Explanation of used gems:

* `rspec` Unit testing
* `database_cleaner-active_record` Cleaning test db for ActiveRecord 
* `simplecov` Tracking test coverage %
* `webmock` Used on `ApiFaker` to stub an actual request
* `mysql2` Connection to MySQL db
* `standalone_migrations` Includes tasks to create tables & migrations
* `rake` Used to run `standalone_migrations`
* `activerecord` Used to map `app/models/` to db
* `zeitwerk` Used to autoload files in `app/`, `app/models/`, `app/services` and `lib/`
* `httparty` Used on serice to make HTTP call to `ApiFaker`

## How to run

The application is delivered using `docker-compose`

### Setup

Generate `mysql` and `shastic_challenge` containers:

```console
$ docker-compose build
```

Create and start containers in the background:

```console
$ docker-compose up -d
```

Install gems:

```console
$ docker-compose exec shastic_challenge bundle
```

Create db tables:

```console
$ docker-compose exec shastic_challenge bundle exec rake db:create
```

Run db pending migrations:

```console
$ docker-compose exec shastic_challenge bundle exec rake db:migrate
```

### Run application

```console
$ docker-compose exec shastic_challenge bundle exec -r 'app.rb' -e 'call'
```

### Run tests

```console
$ docker-compose exec shastic_challenge bundle exec rspec
```
