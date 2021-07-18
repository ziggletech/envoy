FROM envoyproxy/envoy:v1.19.0

ENV DNS_NAME=""
ENV APP_PORT=""

RUN apt-get update && apt-get -q install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

ADD start_envoy.sh /start_envoy.sh
ADD envoy.yaml /etc/envoy.yaml

RUN chmod +x /start_envoy.sh

EXPOSE 443

ENTRYPOINT ["/bin/sh"]
CMD ["start_envoy.sh"]
