FROM centos/ruby-22-centos7:latest
USER root
RUN yum update -y
RUN yum install -y \
    git-core \
    curl \
    zlib1g-dev \
    build-essential \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    python-software-properties \
    libffi-dev

ENV NODE_VERSION 0.12.7
ENV NPM_VERSION 2.14.1

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
       && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
       && npm install -g npm@"$NPM_VERSION" \
       && npm cache clear

ENV GEM_HOME /opt/gems                                                                                                                                                                                                                
ENV LD_LIBRARY_PATH /opt/rh/rh-ruby22/root/usr/lib64


RUN mkdir /myapp
RUN /opt/rh/rh-ruby22/root/usr/bin/bundle config git.allow_insecure true
WORKDIR /myapp
ADD ./Gemfile /myapp/Gemfile
ADD ./Gemfile.lock /myapp/Gemfile.lock
ADD . /myapp
#ADD ./config/database.exmaple.yml /myapp/config/database.yml
#ADD ./config/application.exmaple.yml /myapp/config/application.yml
#RUN cp /myapp/config/application.exmaple.yml /myapp/config/application.yml
#RUN cp /myapp/config/database.exmaple.yml /myapp/config/database.yml
RUN /opt/rh/rh-ruby22/root/usr/bin/gem list | grep bundler
RUN /opt/rh/rh-ruby22/root/usr/bin/bundle install

