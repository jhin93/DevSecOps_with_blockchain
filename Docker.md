# Docker Developer AI Interview Cheatsheet

## Docker Commands & Flags

```bash
docker build -t name:tag .          # Build image with a name and tag. Without -t, the image has no name
docker run --gpus all image cmd     # Run container with GPU access (for AI training)
docker run -e API_KEY=$KEY image    # Inject env vars at runtime, NEVER hardcode secrets in Dockerfile
docker stop <id>                    # Sends SIGTERM → graceful shutdown (waits 10s, then SIGKILL)
docker kill <id>                    # Sends SIGKILL → immediate forced termination, no cleanup
docker exec -it <id> bash           # Open a shell inside a running container for debugging
docker logs <id>                    # View stdout/stderr output from a container
docker ps                           # List running containers (-a to include stopped ones)
docker images                       # List all local images
docker system prune                 # Remove unused containers, networks, images to free disk space
```

## Dockerfile Keywords

```dockerfile
FROM image:version              # Base image. ALWAYS pin version (e.g., python:3.11-slim). NEVER use "latest"
WORKDIR /app                    # Set working directory inside container. All subsequent commands run here
COPY src dest                   # Copy files from host to container. "COPY . ." copies everything to WORKDIR
ADD src dest                    # Like COPY but can download URLs and extract archives. Prefer COPY for simplicity
RUN command                     # Execute command during image build (install packages, compile code, etc.)
CMD ["python3", "app.py"]       # Default command when container starts. Use exec form (JSON array), NOT shell form
ENTRYPOINT ["python3"]          # Fixed command that cannot be overridden. CMD args are appended to ENTRYPOINT
EXPOSE 8000                     # Document which port the app listens on. Does NOT actually publish the port
ENV KEY=value                   # Set environment variable. Avoid for secrets (visible in image history)
ARG KEY=value                   # Build-time variable only. Not available at runtime unlike ENV
USER nonroot                    # Run container as non-root user for security. Always create user first with RUN
HEALTHCHECK CMD curl -f url     # Docker periodically runs this to check if the container is healthy
VOLUME /data                    # Declare a mount point for persistent data
```

## Image Optimization (6 Techniques)

```dockerfile
# 1. Use slim/alpine base images — dramatically reduces image size
#    python:3.11 (900MB) vs python:3.11-slim (150MB) vs python:3.11-alpine (50MB)
FROM python:3.11-slim

# 2. Multi-stage build — separate build tools from runtime, final image is much smaller
FROM node:18 AS builder
RUN npm run build
FROM node:18-slim
COPY --from=builder /app/dist .

# 3. .dockerignore — exclude unnecessary files from build context
#    Add: node_modules/, .git/, __pycache__/, *.md, .env

# 4. --no-install-recommends — skip optional apt packages that bloat the image
RUN apt-get update && apt-get install -y --no-install-recommends python3

# 5. --no-cache-dir — prevent pip from storing download cache in the image
RUN pip install --no-cache-dir -r requirements.txt

# 6. Clean up apt cache — remove package lists after install to save space
RUN apt-get update && apt-get install -y --no-install-recommends python3 \
    && rm -rf /var/lib/apt/lists/*
```

## Layer Caching Order (MUST memorize)

```dockerfile
# Dependencies change rarely → copy and install FIRST (cached layer reused)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Source code changes frequently → copy LAST (only this layer rebuilds)
COPY . .
```

## Security Best Practices (3 Rules)

```dockerfile
# 1. NEVER put secrets in Dockerfile — they are visible in image history and layers
#    BAD:  ENV API_KEY=sk-abc123
#    GOOD: docker run -e API_KEY=$API_KEY myapp  (inject at runtime)

# 2. Run as non-root user — prevents privilege escalation attacks
RUN useradd -m appuser
USER appuser

# 3. Pin image versions — "latest" can change anytime, breaking reproducibility
#    BAD:  FROM ubuntu:latest
#    GOOD: FROM ubuntu:22.04
```

## Docker Compose Structure

```yaml
version: '3.8'                  # Compose file format version
services:                        # All services must be at the SAME level (no nesting)
  app:
    build: .                     # Build from Dockerfile in current directory
    image: myapp:latest          # Or use a pre-built image instead of build
    ports:
      - "8080:8000"              # "host_port:container_port"
    environment:
      - DATABASE_URL=postgres://db:5432/mydb
    depends_on:
      - db                       # Start db service before app
    volumes:
      - ./src:/app/src           # Bind mount: host path → container path (for development)

  db:
    image: postgres:15
    volumes:
      - db_data:/var/lib/postgresql/data    # Named volume: data persists after container deletion
    environment:
      - POSTGRES_PASSWORD=pass

volumes:
  db_data:                       # MUST declare named volumes at top level, otherwise they won't be created
```

## Volume vs Bind Mount

```bash
# Volume — managed by Docker, best for persistent data (databases, uploads)
docker run -v db_data:/var/lib/postgresql/data postgres
# Data survives container deletion. Docker handles the storage location.

# Bind Mount — maps host directory directly, best for development (live code reload)
docker run -v ./src:/app/src myapp
# Changes on host instantly reflected in container. NOT for production.
```

## Kubernetes Core Concepts (5 Must-Know)

```yaml
# Pod — smallest deployable unit, contains 1+ containers that share network/storage
# Deployment — declares desired state (e.g., "run 3 replicas of my app"), K8s maintains it
# Service — stable network endpoint for Pods (ClusterIP, NodePort, LoadBalancer)
# Namespace — logical isolation within a cluster (e.g., dev, staging, prod)
# ConfigMap/Secret — inject configuration and sensitive data into Pods without hardcoding

# Example Deployment:
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ml-training
spec:
  replicas: 3                    # Run 3 instances of this Pod
  selector:
    matchLabels:
      app: ml-training
  template:
    spec:
      containers:
      - name: trainer
        image: my-ml-app:latest
        resources:
          limits:
            nvidia.com/gpu: 1    # Allocate 1 GPU per Pod (for AI training)
            memory: "8Gi"
```

## Docker Swarm vs Kubernetes

```
Docker Swarm — simpler setup, built into Docker, good for small-medium scale
Kubernetes  — more complex but far more powerful, industry standard, massive ecosystem
→ In interviews, always say "Kubernetes is the industry standard for production workloads"
```

## CI/CD Pipeline (GitHub Actions)

```yaml
# The standard flow: Build → Test → Tag → Push → Deploy
- name: Build image
  run: docker build -t myapp:${{ github.sha }} .       # Tag with commit SHA for traceability

- name: Run tests
  run: docker run myapp:${{ github.sha }} pytest        # Image name FIRST, then command

- name: Tag for registry
  run: docker tag myapp:${{ github.sha }} 123456.dkr.ecr.us-east-1.amazonaws.com/myapp:latest
  # MUST tag with full registry URL before pushing. Cannot push "myapp:latest" directly to ECR

- name: Push to registry
  run: docker push 123456.dkr.ecr.us-east-1.amazonaws.com/myapp:latest

- name: Deploy to Kubernetes
  run: kubectl set image deployment/myapp myapp=registry/myapp:${{ github.sha }}
```

## Multi-Stage Build (Detailed)

```dockerfile
# Stage 1: BUILD — includes all build tools (heavy, ~900MB)
FROM node:18 AS builder
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build                # Output goes to /app/dist

# Stage 2: RUNTIME — only the compiled output (light, ~150MB)
FROM node:18-slim
WORKDIR /app
COPY --from=builder /app/dist ./dist    # Copy ONLY build artifacts from stage 1
CMD ["node", "dist/index.js"]

# Why: Build tools (gcc, npm, dev dependencies) are NOT in the final image
# Result: Smaller image, faster deployment, better security (less attack surface)
```

## AI/MLOps with Docker

```bash
# Why Docker for AI training:
# 1. Reproducibility — lock CUDA 12.0 + PyTorch 2.0 + exact library versions in image
# 2. GPU passthrough — NVIDIA Container Toolkit (nvidia-docker) exposes GPUs to containers
# 3. Scalability — K8s distributes training jobs across multiple GPU nodes
# 4. Experiment isolation — run different framework versions simultaneously without conflicts

# GPU container example:
docker run --gpus all nvidia/cuda:12.0-runtime-ubuntu22.04 nvidia-smi

# AI Training Dockerfile pattern:
FROM nvidia/cuda:12.0-runtime-ubuntu22.04
RUN pip install torch transformers datasets
COPY train.py /app/
CMD ["python", "/app/train.py"]
```

## Cloud Integration (AWS / GCP / Azure)

```bash
# AWS:  ECR (image registry) → ECS or EKS (container orchestration) → Fargate (serverless)
# GCP:  Artifact Registry → GKE (Google Kubernetes Engine)
# Azure: ACR (Azure Container Registry) → AKS (Azure Kubernetes Service)

# Interview answer pattern:
# "I build Docker images in CI/CD, push to ECR/GCR/ACR,
#  and deploy to EKS/GKE/AKS for orchestration with Kubernetes."
```

## Key Interview Phrases to Memorize

```
"Reproducibility and consistency across environments"
"Isolate dependencies to avoid conflicts"
"Scale horizontally by spinning up more containers"
"Infrastructure as Code — Dockerfile and Compose are version-controlled"
"Shift left on security — scan images in CI/CD before deployment"
"Immutable infrastructure — never modify running containers, deploy new ones"
"Graceful shutdown — SIGTERM allows the process to clean up before termination"
```
