# SOBE Books App

## How to configure project for development <br>(Without Docker - in Rails way)
This application requires:

- **Ruby 2.2.2**
- **Rails 4.2.5**

Run the following commands in your **terminal / console**:

- **git clone** `git@github.com:osvaldomeirino/sobeBooks.git`
- **cd** `sobeBooks`

- `Run the instructions below if you didn't had ruby-2.2.2 installed.`
- **rvm install ruby-2.2.2**
- **rvm use ruby-2.2.2**
- **rvm gemset create sobebooks_app**
- **rvm gemset use sobebooks_app**
- `End instructions`

- **bundle install**
- **gem install bundler** `[Run this if there is an error on 'bundle install' command]`
- Rename `config/application.example.yml` to `config/application.yml` and set all the required variable values (`admin user info and database username/password etc`).
- Rename `config/database.example.yml` to `config/database.yml`
- **Run postgres server** `(Ubuntu: sudo service postgres start)`
- **rake db:create**
- **rake db:migrate**
- **rake db:seed** `[A dummy user will be created using data added in` **config/application.yml**` file above]`
- **Start server** `rails server`
- **Web App will be available on** `http://localhost:3000`

## How to configure project for development <br>(Using Docker)
Run the following commands in your **terminal / console**:

- Skip **step#1** and **step#2** if you already have these packages. 
- 1.Docker-compose ex: **yum install docker-compose**  `ref: https://docs.docker.com/compose/install/#alternative-install-options` 
- 2.Docker ex: **yum install docker** `ref: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-centos-7`

- Check the below version on which application is deployed successfully by below commands: 
- $ **docker-compose -version**
- **Output: docker-compose version 1.9.0, build 2585387

- $ **docker -v**
- **Output Docker version 1.12.6, build 1398f24/1.12.6

- Clone codebase on your machine
- **git clone https://github.com/sobehub/SobeBooks_rb.git** 

- Move to project directory
- **cd SobeBooks_rb**

- Rename `config/application.example.yml` to `config/application.yml` and set all the required variable values (`admin user info and database username/password etc`).
- Please make sure you have `db_host` should be set to **db**. `(please read the instructions in` **application.yml**`)`
- Rename `config/database.example.yml` to `config/database.yml`

- To build and up the docker-container execute below commands.
- **docker-compose up -d**   `cmd:[To build the container and bring up the container]`
- **docker-compose logs -f** `cmd:[To check the logs ]`
- **docker-compose ps**  `[To check the process of container]` 
- Reference url for docker-compose `cmds : ref:https://docs.docker.com/compose/reference/` 
- **Web App will be available on** `http://localhost:3000`