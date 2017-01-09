FROM ubuntu:trusty
MAINTAINER Jack Willis-Craig <jackw@fishvision.com>
ENV DEBIAN_FRONTEND noninteractive

# Remove sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install packages
RUN apt-get update
RUN apt-get -y install wget \
    curl \
    git \
    zip \
    unzip \
    libxml2-dev \
    build-essential \
    libssl-dev \
    vim \
    nano \
    openssh-client

# Install PHP
RUN add-apt-repository ppa:ondrej/php5-5.6
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install software-properties-common \
    php5

# Clean apt
RUN apt-get clean

# Install node
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash && \
    export NVM_DIR="/root/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    nvm install 4.6 lts

# Misc
RUN mkdir -p ~/.ssh
RUN [[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
