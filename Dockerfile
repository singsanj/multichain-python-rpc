FROM debian:jessie

RUN apt-get update && apt-get install -y \
    git \
    libxml2-dev \
    python \
    build-essential \
    make \
    gcc \
    python-dev \
    locales \
    python-pip \
    wget

RUN apt-get update && pip install python-bitcoinrpc
RUN apt-get update && pip install flask
RUN apt-get update && pip install flask-restful

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

RUN (wget -O /tmp/multichain-1.0-alpha-24.tar.gz http://www.multichain.com/download/multichain-1.0-alpha-24.tar.gz && \
cd /tmp && \
tar -xvzf multichain-1.0-alpha-24.tar.gz && \
cd multichain-1.0-alpha-24 && \
mv multichaind multichain-cli multichain-util /usr/local/bin && \
rm -rf /tmp/multichain-1.0-alpha-24*)

ADD app /usr/local/bin/
ADD run.py /usr/local/bin/

ENV LC_ALL C.UTF-8

EXPOSE 8080 9080 5000 80 8081
