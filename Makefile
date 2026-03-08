.PHONY: compose.up compose.down compose.logs compose.config topic.create topic.list

COMPOSE_FILE := compose/docker-compose.redpanda.yml
COMPOSE := docker compose -f $(COMPOSE_FILE)

compose.up:
	$(COMPOSE) up -d

compose.down:
	$(COMPOSE) down -v

compose.logs:
	$(COMPOSE) logs -f

compose.config:
	$(COMPOSE) config

topic.create:
	$(COMPOSE) exec redpanda rpk topic create focus.events --partitions 3 --replicas 1 || true

topic.list:
	$(COMPOSE) exec redpanda rpk topic list
