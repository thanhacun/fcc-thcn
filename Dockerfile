#FROM debian:jessie
FROM node:4

RUN apt-get -yq update && \
    apt-get -yq install git curl net-tools sudo bzip2 libpng-dev locales-all libfontconfig-dev build-essential

#RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash - && \
#    apt-get -yq install nodejs

# Heroku Toolbelt
RUN apt-get -yq install openssh-client ruby
RUN curl https://toolbelt.heroku.com/install.sh | sh
ENV PATH $PATH:/usr/local/heroku/bin

RUN npm install -g npm
RUN npm install -g yo bower grunt-cli
RUN npm install -g generator-angular-fullstack

# Some other global dependencies
# For virtualbox: npm install --no-bin-links
# May need npm install grunt-contrib-imagemin --save-dev && npm install --save-dev
# grunt build --force && heroku login
# cd dist && heroku apps:create NAME --region us
# For after running yo angular-fullstack:heroku; running grunt --force && grunt buildcontrol:heroku

RUN adduser --disabled-password --gecos "" devuser && \
    echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV HOME /home/devuser

RUN mkdir /app && chown devuser:devuser /app
WORKDIR /app

RUN git config --global user.name "thanhacun"
RUN git config --global user.email "thanhacun@gmail.com"

USER devuser
CMD grunt serve
