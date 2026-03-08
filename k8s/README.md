# K8s baseline

These files are the baseline for `infra-k8s` integration.

## Included

- `base/namespace.yaml`: Namespace `messaging`
- `helm/redpanda-values.yaml`: Baseline values for the Redpanda Helm chart
- `base/topic-init-job.yaml`: Initial topic setup (`focus.events`)

## Deployment flow in `infra-k8s`

1. Apply namespace
2. Deploy Redpanda Helm release with `helm/redpanda-values.yaml`
3. Apply topic init job

`focus` and `analytics` should then use this broker endpoint:

`redpanda.messaging.svc.cluster.local:9092`
