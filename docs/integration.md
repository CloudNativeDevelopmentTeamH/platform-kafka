# Integration guide

## Goal

A shared broker standard consumed by two infrastructure repositories:

- `infra` consumes Compose artifacts
- `infra-k8s` consumes Kubernetes/Helm artifacts

## Compose (`infra`)

- Import `compose/docker-compose.redpanda.yml`
- Use in application containers:
  - `KAFKA_BROKERS=redpanda:9092`
  - `KAFKA_TOPIC=focus.events`
  - `KAFKA_GROUP_ID=analytics-service`

## Kubernetes (`infra-k8s`)

- Apply namespace: `k8s/base/namespace.yaml`
- Deploy Redpanda via Helm with `k8s/helm/redpanda-values.yaml`
- Run topic init job: `k8s/base/topic-init-job.yaml`
- Use in deployments:
  - `KAFKA_BROKERS=redpanda.messaging.svc.cluster.local:9092`

## Topic source of truth

- `topics/topics.yaml` is the central reference.
- Topic changes should be made in this repository only, then propagated to `infra` and `infra-k8s`.
