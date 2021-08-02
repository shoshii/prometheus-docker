FROM ubuntu:18.04

RUN groupadd --system prometheus
RUN useradd -s /sbin/nologin --system -g prometheus prometheus

RUN mkdir /var/lib/prometheus
RUN for i in rules rules.d files_sd; do mkdir -p /etc/prometheus/${i}; done

RUN apt update
RUN apt -y install wget curl vim

RUN mkdir -p /tmp/prometheus
WORKDIR /tmp/prometheus
RUN curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -
RUN tar xvf prometheus*.tar.gz
RUN cd prometheus*/ && mv prometheus promtool /usr/local/bin/

