#!/bin/bash
source ~/elastic-tuto/elastic-start-local/.env
docker run --rm -it \
  --name logstash-enrich \
  --network "$ES_LOCAL_DOCKER_NETWORK" \
  -p 8080:8080 \
  -e PIPELINE_ECS_COMPATIBILITY=disabled \
  -e ES_PASSWORD="$ES_LOCAL_PASSWORD" \
  -e ES_HOST="$ES_LOCAL_CONTAINER_NAME" \
  -v ~/elastic-tuto/logstash:/pipeline:ro \
  docker.elastic.co/logstash/logstash:$ES_LOCAL_VERSION \
  -r -f /pipeline/bano-enrich.conf
