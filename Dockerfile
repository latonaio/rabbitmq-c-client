# syntax = docker/dockerfile:experimental
# Build Container
FROM alpine:3 as base1

RUN apk update && \
    apk add cmake clang git alpine-sdk libressl-dev openssh boost-dev

RUN mkdir -p /run/sshd && \
    ssh-keygen -A

COPY .key/id_rsa /root/.ssh/id_rsa

WORKDIR /builds
RUN git clone https://github.com/alanxz/rabbitmq-c.git && \
    git clone https://github.com/alanxz/SimpleAmqpClient.git && \
    mkdir rabbitmq-c/build && \
    mkdir SimpleAmqpClient/build

WORKDIR /builds/rabbitmq-c/build
RUN cmake .. && \
    cmake --build . --target install

WORKDIR /builds/SimpleAmqpClient/build
RUN cmake .. && \
    cmake --build . --target install

WORKDIR /rabbitmq-cpp-client