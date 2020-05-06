FROM ubuntu:20.04

RUN sed -i 's/archive.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y
RUN apt install tzdata -y
RUN ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt install sudo git python3 -y

RUN useradd test
RUN echo 'test:test' | chpasswd
RUN usermod -aG sudo test
RUN mkdir /home/test
RUN chown test /home/test

USER test

COPY / /home/test/dotfiles

ENTRYPOINT  [ "/bin/bash" ]
