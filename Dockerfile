FROM fluent/fluentd:latest-onbuild
MAINTAINER Mark Theunissen <mark.theunissen@gmail.com>

USER root
RUN apk add --update \
    postgresql-dev  \
    build-base \
    ruby-dev \
    && rm -rf /var/cache/apk/*

USER fluent
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

RUN gem install fluent-plugin-postgres

EXPOSE 24284

CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
