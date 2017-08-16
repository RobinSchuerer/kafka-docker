FROM anapsix/alpine-java

MAINTAINER Robin Schürer <robin.schuerer@gmail.com>

# Packages
RUN apk add --update unzip wget curl docker jq coreutils

#Download kafka
RUN echo "Downloading Kafka"
RUN echo "wget -q http://ftp.halifax.rwth-aachen.de/apache/kafka/0.10.1.0/kafka_2.11-0.10.1.0.tgz -O /tmp/kafka_2.11-0.10.1.0.tgz"
RUN wget -q http://ftp.halifax.rwth-aachen.de/apache/kafka/0.10.1.0/kafka_2.11-0.10.1.0.tgz -O /tmp/kafka_2.11-0.10.1.0.tgz

RUN echo "Extracting"
RUN echo "tar xfz /tmp/kafka_2.11-0.10.1.0.tgz -C /opt"
RUN tar xfz /tmp/kafka_2.11-0.10.1.0.tgz -C /opt

RUN echo "Creating symlink"
RUN echo "ln -s /opt/kafka_2.11-0.10.1.0 /opt/kafka"
RUN ln -s /opt/kafka_2.11-0.10.1.0 /opt/kafka

VOLUME ["/kafka-logs", "/config"]

ENV PATH ${PATH}:/opt/kafka/bin

CMD kafka-server-start.sh /config/server.properties
