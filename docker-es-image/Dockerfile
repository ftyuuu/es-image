FROM debian:9.1 AS builder
LABEL maintainer="futengyu@corp.netease.com" 

ENV PATH=/usr/share/elasticsearch/bin:$PATH
ENV JAVA_HOME=/usr/share/jdk-13+33
ENV PATH=$JAVA_HOME/bin:$PATH

RUN cd /usr/share/ \
    && mkdir elasticsearch \
    && apt-get update \
    && apt-get -y install curl \
    && curl -L --retry 8 -s https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13%2B33/OpenJDK13U-jdk_x64_linux_hotspot_13_33.tar.gz | tar -C /usr/share -zxf -
RUN java -version
RUN groupadd -g 1000 elasticsearch && useradd -u 1000 -g 1000 -d /usr/share/elasticsearch elasticsearch 
RUN cd /usr/share/elasticsearch \
    && curl --retry 8 -s -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-6.8.4.tar.gz \
    && tar zxf elasticsearch-oss-6.8.4.tar.gz --strip-components=1 \
    && rm elasticsearch-oss-6.8.4.tar.gz \
    && mkdir data

COPY config/elasticsearch.yml config/jvm.options /usr/share/elasticsearch/config/
RUN chmod 0775 -R /usr/share/elasticsearch \
    && chgrp -R elasticsearch /usr/share/elasticsearch/ \
    && chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/

RUN echo "root   -     nofile   100000" >> /etc/security/limits.conf
RUN echo "*      -     nofile   100000" >> /etc/security/limits.conf
RUN echo "root   -     memlock  unlimited" >> /etc/security/limits.conf
RUN echo "*      -     memlock  unlimited" >> /etc/security/limits.conf
RUN echo "root   -     nproc    10000" >> /etc/security/limits.conf
RUN echo "*      -     nproc    10000" >> /etc/security/limits.conf
RUN echo "elasticsearch soft memlock unlimited" >> /etc/security/limits.conf
RUN echo "elasticsearch hard memlock unlimited" >> /etc/security/limits.conf


ENV CLUSTER_NAME="elasticsearch-cluster"
ENV NODE_MASTER=true
ENV NODE_DATA=true
ENV CLUSTER_REMOTE_CONNECT=true
ENV NETWORK_HOST="_local_"
ENV TRANSPORT_TCP_PORT=9300
ENV HTTP_PORT=9200
ENV MEMORY_LOCK=false
ENV PATH_DATA="/usr/share/elasticsearch/data"
ENV PATH_LOGS="/usr/share/elasticsearch/logs"
ENV DISCOVERY_SERVICE=""
ENV MINIMUM_MASTER_NODES=1
ENV ES_JAVA_OPTS="-Xms256m -Xmx256m"
ENV NODE_NAME=$hostname

EXPOSE 9200 9300

LABEL org.label-schema.name="netease.com/nes/elasticsearch" \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vendor="netease.com/nes/elasticsearch" \
  org.label-schema.version="6.8.4" \
  org.opencontainers.image.title="netease.com/nes/elasticsearch" \
  org.opencontainers.image.vendor="netease.com/nes/elasticsearch" \
  org.opencontainers.image.version="6.8.4"


WORKDIR /usr/share/elasticsearch
USER elasticsearch:elasticsearch

CMD ["elasticsearch"]
