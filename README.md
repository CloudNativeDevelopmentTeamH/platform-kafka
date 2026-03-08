# platform-kafka

Central broker baseline for separate integrations in:

- `infra` (Docker Compose)
- `infra-k8s` (Kubernetes)

This repository is the shared source of truth for Kafka/Redpanda standards (topics, base configuration, init jobs).

## Structure

- `compose/docker-compose.redpanda.yml` – local/shared Compose baseline
- `k8s/helm/redpanda-values.yaml` – Helm values baseline
- `k8s/base/topic-init-job.yaml` – declarative topic setup
- `topics/topics.yaml` – topic definitions as source of truth
- `Makefile` – local helper targets

## Local startup (Compose)

```bash
make compose.up
make topic.list
```

Broker endpoints:

- internal in the Compose network: `redpanda:9092`
- from host: `localhost:19092`

Stop:

```bash
make compose.down
```

## Integration into `infra`

Recommended:

1. Include `compose/docker-compose.redpanda.yml` from this repository (submodule or CI sync)
2. Merge services in your shared Compose setup
3. Set application services to `KAFKA_BROKERS=redpanda:9092`

## Integration into `infra-k8s`

Recommended:

1. Apply namespace from `k8s/base/namespace.yaml`
2. Deploy Redpanda via Helm using `k8s/helm/redpanda-values.yaml`
3. Run topic job from `k8s/base/topic-init-job.yaml`

Application services should then use:

`KAFKA_BROKERS=redpanda.messaging.svc.cluster.local:9092`

## Baseline conventions

- Topic: `focus.events`
- Consumer Group (Analytics): `analytics-service`

- Standard environment variables:
	- `KAFKA_BROKERS`
	- `KAFKA_TOPIC`
	- `KAFKA_GROUP_ID`

## Next recommended steps

- Add Helm release / ArgoCD manifest in the `infra-k8s` repository
- Extend topic-init job to handle multiple topics from `topics/topics.yaml`
- Add TLS/SASL and ACLs for stage/production