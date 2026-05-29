# System Architecture — Spring Boot (Backend) + React (Frontend) — AutoWash Pro

## Overview
This architecture targets the AutoWash Pro system using a common stack: Spring Boot microservices (or modular monolith) for backend services, React SPA for frontend, PostgreSQL for primary storage, Redis for caching, and a message broker for async tasks. Designed for cloud-native deployments (Docker + Kubernetes) with CI/CD via GitHub Actions.

## High-level Components
- Frontend: React (Vite) single-page app
  - Route patterns: /, /auth, /booking, /account, /admin, /notifications
  - Auth flow: JWT stored in secure, HttpOnly cookie or memory; refresh tokens via endpoint
  - Component library: shared UI components, design tokens

- Backend: Spring Boot (Java/Kotlin)
  - API Gateway / Ingress: Traefik or AWS ALB
  - Services (modular or microservices): auth, customer, booking, loyalty, admin
  - Shared libs: common-models, security, exceptions, dto-mappers
  - Background workers: Spring @Scheduled / Quartz or a dedicated worker service consuming messages

- Data & Storage
  - Relational DB: PostgreSQL (primary). Use Flyway/Liquibase for migrations.
  - Cache: Redis for session caching, rate-limiting, slot availability caches
  - Message broker: RabbitMQ or Kafka for event-driven flows (booking events, loyalty accrual, analytics)
  - Object storage: S3-compatible (AWS S3, MinIO) for avatars, documents, reports

- Observability & Ops
  - Metrics: Prometheus + Grafana
  - Tracing: OpenTelemetry + Jaeger
  - Logs: Structured JSON logs shipped to centralized system (ELK/Cloud provider)
  - Health checks: /actuator/health, readiness, liveness

## Security
- Transport: HTTPS only, HSTS
- Auth: JWT (access + refresh)
- RBAC: Spring Security with role-based access checks (USER, ADMIN)
- Secrets: store in Vault or Kubernetes Secrets
- Rate limiting: API Gateway or Redis-based leaky-bucket
- Input validation and output sanitization

## Data Flow Examples
- Booking flow (sync + async): Frontend -> POST /api/v1/bookings -> Booking service validates tier windows (cache + DB) -> persist booking -> emit event to message broker -> Loyalty service listens and accrues points after completion -> notifications service sends confirmation

## Resilience & Scaling
- Stateless backend instances behind load balancer; scale horizontally
- Database: primary + read replicas; use connection pooling, prepared statements, and indices for critical queries
- Use Redis for hot-path data (availability) to reduce DB contention (booking slot pre-checks + optimistic locking or DB transactions)
- Use idempotency keys for critical endpoints (booking creation, redemption)

## Deployment & CI/CD
- Build: GitHub Actions – backend (mvn/gradle) -> build Docker image -> push to registry; frontend -> build static assets -> store in CDN
- Deploy: Kubernetes manifests or Helm charts in /infra; use image tags and GitHub Actions to deploy to staging/prod
- Migrations: Run Flyway as pre-deploy job or init container

## Suggested Repository Layout
- /backend/ (Spring Boot modular monolith)
  - /backend/auth, /backend/booking, /backend/loyalty, /backend/common
- /frontend/ (React App)
- /infra/ (k8s manifests, helm charts, terraform)
- /api/ (OpenAPI specs)
- /migrations/ (flyway)
- /docs/

## Dev & Runtime Configuration (env examples)
- SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/app
- SPRING_DATASOURCE_USERNAME=app
- SPRING_DATASOURCE_PASSWORD=secret
- REDIS_URL=redis://redis:6379
- BROKER_URL=amqp://rabbitmq:5672

## Monitoring & Alerts
- Alerts: high error rate, booking failure rate spike, queue backlog growth, DB connections near limit
- Dashboards: Booking throughput, Loyalty redemptions, API latency

## Operational Concerns
- Backups: daily DB dumps + WAL archiving
- Data retention: purge expired loyalty points monthly (batch job)
- Compliance: encrypt PII at rest; redact logs containing PII

## Next steps / Deliverables
1. Convert api-design.md to OpenAPI and publish to /api/openapi.yaml
2. Create Helm charts and sample values for staging
3. Create starter Spring Boot module template and React app scaffold
4. Add GitHub Actions workflows for build/test/deploy

---

Notes: prefer a modular monolith to start (simpler local dev), split into microservices as scale requires.
