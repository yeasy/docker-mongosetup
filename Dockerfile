# This image initializes a MongoDB replica set member.

FROM mongo:8.2
LABEL maintainer="yeasy@github"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

COPY docker-entrypoint.sh /tmp/docker-entrypoint.sh
RUN chmod +x /tmp/docker-entrypoint.sh

ENTRYPOINT ["/bin/bash", "/tmp/docker-entrypoint.sh"]
