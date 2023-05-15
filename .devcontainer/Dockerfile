# Based on https://evilmartians.com/chronicles/ruby-on-whales-docker-for-ruby-rails-development
# Allow parametrization from outside image
ARG RUBY_VERSION=3.2.2
ARG DISTRO_NAME=bullseye

# Bullseye is codename for Debia 11, current stable distro
# Docker-Slim refers to optimized docker image
# Ex: "3.2.2-slim-bullseye", see here https://hub.docker.com/_/ruby
FROM ruby:$RUBY_VERSION-slim-$DISTRO_NAME

RUN apt-get update && \
    # The DEBIAN_FRONTEND export avoids warnings when you go on to work with your container
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install git wget vim 
    # Install ZSH in docker for less painful experience

# install zsh for a better experience
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t robbyrussell \
    -p git \
    -p ssh-agent \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions
RUN echo "exec zsh" >> $HOME/.bashrc

