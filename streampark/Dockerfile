FROM alpine:3.16 as deps-stage
COPY . /
WORKDIR /
RUN tar zxvf dist/apache-streampark*-*-bin.tar.gz \
&& mv apache-streampark*-*-bin streampark

FROM docker:dind
WORKDIR /streampark
COPY --from=deps-stage /streampark /streampark

ENV NODE_VERSION=16.1.0
ENV NPM_VERSION=7.11.2

RUN apk add openjdk8 \
    && apk add maven \
    && apk add wget \
    && apk add vim \
    && apk add bash \
    && apk add curl

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV MAVEN_HOME=/usr/share/java/maven-3
ENV PATH $JAVA_HOME/bin:$PATH
ENV PATH $MAVEN_HOME/bin:$PATH

RUN wget "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && tar zxvf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs  \
    && curl -O https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN wget -P lib https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.31/mysql-connector-j-8.0.31.jar

RUN mkdir -p ~/.kube


ENTRYPOINT ["/streampark/bin/streampark.sh", "start_docker"]

EXPOSE 10000
EXPOSE 10030
