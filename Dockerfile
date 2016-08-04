FROM parana/jshell:latest
#
# parana/jshell usa a versão 8 do Debian de codinome Jessie
#
MAINTAINER João Antonio Ferreira "joao.parana@gmail.com"

ENV REFRESHED_AT 2016-08-04

# RUN apt-get update && apt-get install -y vim && apt-get clean
COPY install /tmp/
# RUN find /tmp -type d | sort 

WORKDIR /tmp
RUN cd maven3 && \
    tar xzf apache-maven-3.3.9-bin.tar.gz && \
    chown root:root -R apache-maven-3.3.9 && \
    mv apache-maven-3.3.9 /usr/local/maven3 && \
    rm -rf apache-maven-3.3.9-bin.tar.gz

ENV PATH /usr/local/maven3/bin:${PATH}

RUN mkdir -p /desenv/java && mvn -v
#
ADD my-spark-app /desenv/java
WORKDIR /desenv/java

VOLUME /shared-with-host

# VOLUME /root/.m2/repository
COPY m2-repo /root/.m2/repository
RUN cd myspark && mvn clean compile test package install

CMD ["/bin/bash"]
