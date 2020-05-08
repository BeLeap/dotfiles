FROM ubuntu:20.04

RUN sed -i 's/archive.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install tzdata
RUN ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt upgrade -y

RUN apt install sudo git python3 fish -y

RUN useradd test
RUN echo 'test:test' | chpasswd
RUN usermod -aG sudo test
RUN mkdir /home/test
RUN chown test /home/test

USER test

COPY / /home/test/dotfiles

ENTRYPOINT  [ "/usr/bin/fish" ]
