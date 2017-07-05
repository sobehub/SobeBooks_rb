# SOBE Books App

## How to configure project for development
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
- Rename `config/database.example.yml` to `config/database.yml`

- To build and up the docker-container execute below commands.
- **docker-compose up -d**   `cmd:[To build the container and bring up the container]`
- **docker-compose logs -f** `cmd:[To check the logs ]`
- **docker-compose ps**  `[To check the process of container]` 
- Reference url for docker-compose `cmds : ref:https://docs.docker.com/compose/reference/` 
- **Web App will be available on** `http://localhost:3000`