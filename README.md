# Truffle Ruby, Rails and Docker Starter

#####
 Minimal starter for Truffle Ruby and Rails 6 application with Docker, Postgresql and Redis databases

* **[Truffle Ruby](https://github.com/oracle/truffleruby)**
* **[Rails](https://rubyonrails.org/)**
* **[Docker](https://www.docker.com/)**
* **[Postgresql](https://www.postgresql.org/)**
* **[Redis](https://redis.io/)**

### Up&Running

#### Clone the repository
`git clone git@github.com:mc2dx/truffle-rails-starter.git your-project`

`cd your-project`

#### Generate new Rails application

`docker-compose run web rails new . --database=postgresql`

#### Build a Docker image

`docker-compose build`

#### Copy database configuration below and paste to `config/database.yml` file

```
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: db
  username: postgres
  password:

development:
  <<: *default
  database: myapp_development

test:
  <<: *default
  database: myapp_test

production:
  <<: *default
  database: myapp_production
  username: myapp
  password: <%= ENV['MYAPP_DATABASE_PASSWORD'] %>
```
#### Create databases
`docker-compose run web rake db:create`
#### Run application
`docker-compose up`
#### Open browser and type URL
`http://localhost:8081`
