#!/bin/bash

# Wait for Kafka to be ready
echo "Waiting for Kafka to be ready..."
c=0
while ! kafka-topics.sh --bootstrap-server localhost:9092 --list; do
  sleep 2
  c=$((c+1))
  if [ $c -gt 30 ]; then
    echo "Timeout waiting for Kafka"
    exit 1
  fi
done

# Create topics
echo "Creating topics..."
kafka-topics.sh --create --if-not-exists --bootstrap-server localhost:9092 \
  --topic blood-request-created \
  --partitions 3 \
  --replication-factor 1

kafka-topics.sh --create --if-not-exists --bootstrap-server localhost:9092 \
  --topic donors-pledges \
  --partitions 3 \
  --replication-factor 1

echo "Topics created:"
kafka-topics.sh --list --bootstrap-server localhost:9092