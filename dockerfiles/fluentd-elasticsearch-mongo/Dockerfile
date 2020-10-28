FROM gcr.io/google-containers/fluentd-elasticsearch:v2.4.0 AS builder

RUN apt update -y && \
	apt install gcc make ruby2.3-dev -y \
	&& gem install fluent-plugin-mongo

FROM gcr.io/google-containers/fluentd-elasticsearch:v2.4.0 AS image

COPY --from=builder /var/lib/gems/ /var/lib/gems/
COPY --from=builder /usr/lib/ruby/2.3.0/ /usr/lib/ruby/2.3.0/

ENTRYPOINT /run.sh
