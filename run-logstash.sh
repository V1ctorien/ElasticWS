#!/bin/bash
source ~/elastic-tuto/elastic-start-local/.env
docker run -i --rm \
  --network "$ES_LOCAL_DOCKER_NETWORK" \
  -e PIPELINE_ECS_COMPATIBILITY=disabled \
  -e REGION="${REGION:-25}" \
  -e ES_PASSWORD="$ES_LOCAL_PASSWORD" \
  -e ES_HOST="$ES_LOCAL_CONTAINER_NAME" \
  -v ~/elastic-tuto/logstash:/pipeline:ro \
  docker.elastic.co/logstash/logstash:$ES_LOCAL_VERSION \
  -f /pipeline/bano-data.conf 2>/dev/null
