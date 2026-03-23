Format: AI Interview + Coding Exercise
Estimated duration: up to 53 minutes
Focus areas: Docker containerization & container lifecycle management, Container orchestration for scalable workloads (Kubernetes / Docker Swarm), CI/CD pipelines (DevOps tooling & methodologies), AI/ML training workflow enablement via containerization (MLOps exposure), Cloud integration for containerized deployments (AWS / GCP / Azure)
Last date to complete: Mar 23, 2026 07:26 am

---

You will be interviewed on these topics

- Docker containerization & container lifecycle management
- Container orchestration for scalable workloads (Kubernetes / Docker Swarm)
- CI/CD pipelines (DevOps tooling & methodologies)
- AI/ML training workflow enablement via containerization (MLOps exposure)
- Cloud integration for containerized deployments (AWS / GCP / Azure)


# Area 1: Docker Containerization & Container Lifecycle Management

## Q1. What is the difference between a Docker image and a container?

**Answer:**
A Docker image is a read-only template that contains the application code, dependencies, and OS libraries. It's like a blueprint. A container is a running instance of that image — it's the actual process executing in an isolated environment.

You can create multiple containers from a single image. Images are built with `docker build` and stored in registries. Containers are created with `docker run` and have their own writable layer on top of the image.

## Q2. Explain the Docker container lifecycle.

**Answer:**
A container goes through these states:

1. **Created** — `docker create` allocates the container but doesn't start it
2. **Running** — `docker start` or `docker run` starts the process
3. **Paused** — `docker pause` freezes the process (stays in memory)
4. **Stopped** — `docker stop` sends SIGTERM, waits 10 seconds, then SIGKILL
5. **Removed** — `docker rm` deletes the container and its writable layer

Best practice: containers should be **ephemeral** — designed to be stopped and replaced, not patched in place. This is called **immutable infrastructure**.

## Q3. What is the difference between CMD and ENTRYPOINT?

**Answer:**
- **CMD** — default command that can be overridden at runtime. If user passes arguments to `docker run`, CMD is replaced entirely.
- **ENTRYPOINT** — fixed command that always runs. Arguments from `docker run` are appended to it.

Example:
```dockerfile
ENTRYPOINT ["python3"]
CMD ["app.py"]
# docker run myapp         → runs "python3 app.py"
# docker run myapp test.py → runs "python3 test.py" (CMD overridden)
```

Always use **exec form** (JSON array), not shell form, so the process runs as PID 1 and receives signals properly.

## Q4. How do you reduce Docker image size?

**Answer:**
Six techniques:
1. Use **slim or alpine** base images (`python:3.11-slim` instead of `python:3.11`)
2. **Multi-stage builds** — compile in one stage, copy only artifacts to a minimal runtime stage
3. Use **.dockerignore** to exclude `.git/`, `node_modules/`, `__pycache__/`
4. `--no-install-recommends` with apt-get to skip optional packages
5. `--no-cache-dir` with pip to avoid storing download cache
6. Clean apt cache: `rm -rf /var/lib/apt/lists/*` in the same RUN layer

## Q5. What is the difference between COPY and ADD?

**Answer:**
- **COPY** — simply copies files from host to container. Straightforward and predictable.
- **ADD** — does everything COPY does, plus it can download from URLs and auto-extract tar archives.

Best practice: **always use COPY** unless you specifically need URL download or tar extraction. COPY is more transparent and easier to understand.

## Q6. How does Docker layer caching work and how do you optimize it?

**Answer:**
Each Dockerfile instruction creates a layer. Docker caches layers and reuses them if nothing changed. But if one layer changes, all subsequent layers are rebuilt.

Optimization strategy: put things that change **rarely** at the top, things that change **frequently** at the bottom.

```dockerfile
COPY requirements.txt .        # rarely changes → cached
RUN pip install -r requirements.txt  # cached if requirements.txt unchanged
COPY . .                       # source code changes often → last
```

## Q7. What is the difference between docker stop and docker kill?

**Answer:**
- `docker stop` sends **SIGTERM** first, giving the process time to clean up (save state, close connections). After 10 seconds, it sends SIGKILL.
- `docker kill` sends **SIGKILL** immediately — no cleanup, instant termination.

Use `docker stop` in production for graceful shutdown. Use `docker kill` only when a container is unresponsive and must be forced down.

---

# Area 2: Container Orchestration (Kubernetes / Docker Swarm)

## Q1. What is container orchestration and why do we need it?

**Answer:**
Container orchestration automates the deployment, scaling, networking, and management of containerized applications across multiple hosts.

Without orchestration, you'd have to manually start containers on each server, handle failures, load balance traffic, and manage updates. Orchestration tools like Kubernetes handle all of this automatically.

Key capabilities:
- **Auto-scaling** — add/remove containers based on load
- **Self-healing** — restart failed containers automatically
- **Load balancing** — distribute traffic across healthy containers
- **Rolling updates** — deploy new versions with zero downtime

## Q2. Explain the core Kubernetes architecture.

**Answer:**
Kubernetes has two planes:

**Control Plane (Master):**
- **API Server** — all communication goes through this (kubectl talks to it)
- **etcd** — key-value store for all cluster state
- **Scheduler** — decides which node runs a new Pod
- **Controller Manager** — ensures desired state matches actual state

**Data Plane (Worker Nodes):**
- **kubelet** — agent on each node that manages Pods
- **kube-proxy** — handles networking and load balancing
- **Container Runtime** — Docker or containerd, actually runs containers

## Q3. What is a Pod, and why not just run containers directly?

**Answer:**
A Pod is the smallest deployable unit in Kubernetes. It wraps one or more containers that share the same network namespace and storage volumes.

Why Pods instead of bare containers:
- Containers in a Pod share `localhost` — they can communicate without networking overhead
- They share volumes — a sidecar container can read logs from the main app
- Kubernetes manages Pods, not individual containers — it schedules, scales, and restarts at the Pod level

In practice, most Pods contain a single container. Multi-container Pods are used for sidecar patterns (logging, monitoring, proxies).

## Q4. What is the difference between a Deployment and a StatefulSet?

**Answer:**
- **Deployment** — for stateless applications (web servers, API servers). Pods are interchangeable, can be replaced freely, and don't need stable network identities.
- **StatefulSet** — for stateful applications (databases, message queues). Each Pod gets a stable hostname (e.g., `db-0`, `db-1`), persistent storage, and ordered startup/shutdown.

Use Deployment for most workloads. Use StatefulSet only when your application needs stable identity or persistent storage per Pod.

## Q5. How does Kubernetes handle service discovery and load balancing?

**Answer:**
Through **Services**:
- **ClusterIP** (default) — internal-only IP, other Pods access it by service name (DNS)
- **NodePort** — exposes the service on each node's IP at a static port (30000-32767)
- **LoadBalancer** — provisions an external cloud load balancer (AWS ELB, GCP LB)

Example: if you have 3 replicas of a web app behind a Service called `web`, any Pod in the cluster can reach it at `http://web:8080`. Kubernetes automatically load-balances across the 3 replicas.

## Q6. Docker Swarm vs Kubernetes — when would you choose each?

**Answer:**
**Docker Swarm:**
- Built into Docker, zero extra installation
- Simpler to set up and learn
- Good for small teams and simple deployments
- Limited ecosystem and community

**Kubernetes:**
- Industry standard for production workloads
- Massive ecosystem (Helm, Istio, ArgoCD, Prometheus)
- More complex but far more powerful
- Auto-scaling, RBAC, custom resources, extensible

In interviews: "Kubernetes is the industry standard. I would choose Swarm only for very small projects where simplicity outweighs the need for advanced features."

## Q7. What is a Kubernetes Namespace and why use it?

**Answer:**
A Namespace is a logical partition within a cluster. It provides isolation for resources, access control, and resource quotas.

Use cases:
- Separate environments: `dev`, `staging`, `production`
- Team isolation: `team-ml`, `team-backend`
- Resource limits: set CPU/memory quotas per namespace

```bash
kubectl get pods -n production    # list pods in production namespace
kubectl create namespace staging  # create new namespace
```

---

# Area 3: CI/CD Pipelines (DevOps Tooling & Methodologies)

## Q1. What is CI/CD and why is it important?

**Answer:**
- **CI (Continuous Integration)** — developers merge code to the main branch frequently. Each merge triggers automated builds and tests. Catches bugs early.
- **CD (Continuous Delivery)** — code is always in a deployable state. After CI passes, it can be released to production with one click.
- **CD (Continuous Deployment)** — fully automated. Every passing commit goes straight to production without manual intervention.

Why important: faster feedback loops, fewer bugs in production, consistent and repeatable deployments, reduced human error.

## Q2. Describe a typical Docker-based CI/CD pipeline.

**Answer:**
```
Code Push → Build Image → Run Tests → Scan Image → Push to Registry → Deploy
```

1. **Code Push** — developer pushes to main branch, triggers pipeline
2. **Build** — `docker build -t myapp:$COMMIT_SHA .` (tag with commit hash for traceability)
3. **Test** — `docker run myapp:$COMMIT_SHA pytest` (run tests inside the container)
4. **Security Scan** — scan image for vulnerabilities (Trivy, Snyk)
5. **Push** — tag and push to container registry (ECR, GCR, Docker Hub)
6. **Deploy** — update Kubernetes Deployment with new image tag

## Q3. What is the difference between GitHub Actions, Jenkins, and GitLab CI?

**Answer:**
- **GitHub Actions** — built into GitHub, YAML-based, great for GitHub-hosted repos. Free tier available. Uses hosted runners.
- **Jenkins** — self-hosted, highly customizable with plugins. More maintenance overhead but full control. Best for complex enterprise pipelines.
- **GitLab CI** — built into GitLab, YAML-based (`.gitlab-ci.yml`). Tight integration with GitLab features. Strong for monorepos.

All three can build Docker images and deploy to Kubernetes. The choice depends on where your code lives and team preference.

## Q4. How do you handle secrets in CI/CD pipelines?

**Answer:**
Never hardcode secrets in code, Dockerfiles, or pipeline files.

Best practices:
1. **CI/CD Secrets** — store in GitHub Actions Secrets, Jenkins Credentials, or GitLab CI Variables (masked)
2. **Runtime injection** — pass as environment variables: `docker run -e API_KEY=$SECRET myapp`
3. **Secret managers** — AWS Secrets Manager, HashiCorp Vault, GCP Secret Manager for production
4. **Docker BuildKit secrets** — `docker build --secret id=mysecret,src=./secret.txt .` (never baked into image layers)

## Q5. What is Infrastructure as Code (IaC) and how does it relate to Docker?

**Answer:**
IaC means managing infrastructure through version-controlled configuration files instead of manual setup.

Docker relates to IaC through:
- **Dockerfile** — defines the application environment as code
- **docker-compose.yml** — defines multi-container setups as code
- **Kubernetes manifests** — define deployment, scaling, networking as code
- **Terraform** — provisions cloud infrastructure (VPCs, EKS clusters, ECR repos) as code

Benefits: reproducible environments, peer-reviewed changes via PRs, rollback by reverting commits, audit trail in git history.

## Q6. What is a rolling update and how does Kubernetes handle it?

**Answer:**
A rolling update gradually replaces old Pods with new ones, ensuring zero downtime.

How it works:
1. Kubernetes creates a new Pod with the updated image
2. Waits for it to pass health checks
3. Removes one old Pod
4. Repeats until all Pods are updated

```yaml
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1        # max 1 extra Pod during update
      maxUnavailable: 0   # always keep all Pods available
```

If the new version fails health checks, Kubernetes automatically stops the rollout — this is called a **failed rollout**, and you can `kubectl rollout undo` to revert.

---

# Area 4: AI/ML Training Workflow Enablement (MLOps)

## Q1. Why is Docker essential for AI/ML training workflows?

**Answer:**
Four key reasons:

1. **Reproducibility** — lock exact versions of CUDA, PyTorch, TensorFlow, and all dependencies. A training job that works today will produce the same results in 6 months.
2. **Environment isolation** — run different experiments with different framework versions simultaneously without conflicts on the same machine.
3. **GPU access** — NVIDIA Container Toolkit (nvidia-docker) passes GPU hardware into containers. `docker run --gpus all` gives the container full GPU access.
4. **Scalability** — distribute training across multiple GPU nodes using Kubernetes. Each node runs the same Docker image, guaranteeing consistency.

## Q2. How do you set up a Docker container for GPU-based AI training?

**Answer:**
Prerequisites:
- NVIDIA GPU drivers installed on host
- NVIDIA Container Toolkit installed

```dockerfile
FROM nvidia/cuda:12.0-runtime-ubuntu22.04
WORKDIR /training
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "train.py"]
```

Run with:
```bash
docker run --gpus all \
  -v /data/datasets:/training/data \
  -v /data/models:/training/output \
  -e WANDB_API_KEY=$WANDB_KEY \
  my-training-image
```

Key points:
- `--gpus all` or `--gpus '"device=0,1"'` for specific GPUs
- Mount datasets and output dirs as volumes (don't bake large data into images)
- Inject API keys (W&B, MLflow) at runtime

## Q3. What is MLOps and how does Docker fit into it?

**Answer:**
MLOps is DevOps applied to machine learning. It covers the full lifecycle: data preparation → training → evaluation → deployment → monitoring.

Docker's role in MLOps:
- **Training** — containerized training jobs ensure reproducibility
- **Serving** — model inference runs in containers (TensorFlow Serving, TorchServe, Triton)
- **Pipeline orchestration** — tools like Kubeflow, MLflow, and Airflow run each pipeline step in its own container
- **Experiment tracking** — each experiment is a container with pinned dependencies, fully reproducible

## Q4. How would you handle large datasets in Docker containers?

**Answer:**
Never put datasets inside the Docker image — they make images enormous and slow to build/push.

Solutions:
1. **Volume mounts** — `docker run -v /host/data:/container/data` — data stays on host, container reads it
2. **Cloud storage** — download from S3/GCS at runtime: `aws s3 cp s3://bucket/data ./data/`
3. **Network file systems** — mount NFS or EFS into containers for shared access across nodes
4. **Data versioning** — use DVC (Data Version Control) to track dataset versions alongside code

In Kubernetes:
```yaml
volumes:
  - name: training-data
    persistentVolumeClaim:
      claimName: dataset-pvc    # PVC backed by cloud storage
```

## Q5. How do you deploy a trained ML model using Docker?

**Answer:**
Package the model and inference code into a container:

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY model/ ./model/           # trained model weights
COPY serve.py .
EXPOSE 8000
HEALTHCHECK CMD curl -f http://localhost:8000/health
CMD ["uvicorn", "serve:app", "--host", "0.0.0.0", "--port", "8000"]
```

Deploy options:
- **Single server** — `docker run -p 8000:8000 model-server`
- **Kubernetes** — Deployment with multiple replicas + HPA (Horizontal Pod Autoscaler) for auto-scaling
- **Serverless** — AWS Lambda container images, GCP Cloud Run

Add HEALTHCHECK so orchestrators know when the model is loaded and ready to serve.

---

# Area 5: Cloud Integration for Containerized Deployments (AWS / GCP / Azure)

## Q1. What are the major cloud container services and how do they compare?

**Answer:**

|                           | AWS                  | GCP                | Azure |
|---                        |---                   |---                 |---    |
| **Container Registry**    | ECR                  | Artifact Registry   | ACR |
| **Managed Kubernetes**    | EKS                  | GKE                 | AKS |
| **Serverless Containers** | Fargate / App Runner | Cloud Run           | Container Apps |
| **Container Instances**   | ECS on EC2           | GCE with containers | ACI |

Interview answer: "I build Docker images in CI/CD, push to a container registry like ECR, and deploy to a managed Kubernetes service like EKS for orchestration. For simpler workloads, I use serverless options like Fargate or Cloud Run."

## Q2. Describe the process of deploying a Docker image to AWS ECS/EKS.

**Answer:**
**ECS (Elastic Container Service):**
1. Build image and push to ECR
2. Create a Task Definition (specifies image, CPU, memory, ports)
3. Create a Service (runs tasks, integrates with ALB for load balancing)
4. Service runs on Fargate (serverless) or EC2 instances

**EKS (Elastic Kubernetes Service):**
1. Build image and push to ECR
2. Create EKS cluster (`eksctl create cluster`)
3. Write Kubernetes manifests (Deployment, Service, Ingress)
4. Apply with `kubectl apply -f manifests/`
5. EKS handles the control plane; you manage worker nodes or use Fargate

Key difference: ECS is AWS-native and simpler. EKS is Kubernetes — portable across clouds but more complex.

## Q3. How do you push a Docker image to AWS ECR?

**Answer:**
```bash
# 1. Authenticate Docker to ECR
aws ecr get-login-password --region us-east-1 | \
  docker login --username AWS --password-stdin 123456.dkr.ecr.us-east-1.amazonaws.com

# 2. Build and tag image with full ECR URL
docker build -t myapp:latest .
docker tag myapp:latest 123456.dkr.ecr.us-east-1.amazonaws.com/myapp:latest

# 3. Push
docker push 123456.dkr.ecr.us-east-1.amazonaws.com/myapp:latest
```

Important: you MUST tag the image with the full ECR registry URL before pushing. `docker push myapp:latest` alone will try to push to Docker Hub, not ECR.

## Q4. What is Terraform and how does it work with Docker deployments?

**Answer:**
Terraform is an Infrastructure as Code tool that provisions cloud resources declaratively.

For Docker deployments, Terraform creates:
- VPC, subnets, security groups (networking)
- EKS/ECS cluster (orchestration)
- ECR repository (image storage)
- IAM roles and policies (permissions)
- RDS/ElastiCache (databases, caches)

```hcl
resource "aws_ecs_service" "app" {
  name            = "my-app"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 3
  launch_type     = "FARGATE"
}
```

Workflow: `terraform plan` (preview changes) → `terraform apply` (create resources) → `terraform destroy` (tear down)

## Q5. How do you handle logging and monitoring for containers in the cloud?

**Answer:**
Containers should write logs to **stdout/stderr** — the platform collects them.

**AWS:**
- CloudWatch Logs — ECS/EKS automatically forward container logs
- CloudWatch Container Insights — metrics (CPU, memory, network)
- X-Ray — distributed tracing

**Kubernetes-native:**
- Prometheus + Grafana — metrics collection and dashboards
- EFK stack (Elasticsearch + Fluentd + Kibana) — log aggregation
- Loki — lightweight log aggregation by Grafana Labs

Best practice: structured JSON logging from your app → collected by the platform → queried and alerted on in a centralized dashboard.

## Q6. What is a container registry and why not just use Docker Hub for everything?

**Answer:**
A container registry stores and distributes Docker images. Docker Hub is public by default.

Why use cloud registries (ECR, GCR, ACR):
1. **Private by default** — your proprietary code and models are not exposed
2. **Closer to deployment** — same cloud region = faster pull times
3. **IAM integration** — access controlled by cloud permissions, no separate credentials
4. **Image scanning** — built-in vulnerability scanning on push
5. **Cost** — Docker Hub free tier has rate limits; cloud registries don't (within your account)