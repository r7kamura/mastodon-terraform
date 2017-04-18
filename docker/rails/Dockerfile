FROM ruby:2.4.1-alpine

WORKDIR /app

RUN echo "@edge https://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && BUILD_DEPS=" \
    postgresql-dev \
    libxml2-dev \
    libxslt-dev \
    build-base" \
  && apk -U upgrade \
  && apk add \
    $BUILD_DEPS \
    libpq \
    libxml2 \
    libxslt \
    ffmpeg \
    file \
    imagemagick@edge \
  && apk del $BUILD_DEPS \
  && rm -rf /tmp/* /var/cache/apk/*

COPY \
  Gemfile \
  Gemfile.lock \
  /app/
RUN bundle install --jobs=4 --path=/bundle

COPY . /app
