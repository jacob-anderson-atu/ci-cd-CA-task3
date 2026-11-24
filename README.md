# DevOps Mini-Pipeline

This project is a small Flask web application that I used to build a complete CI/CD pipeline.

The application itself is deliberately simple. The main focus is the pipeline around it, including automated testing, security scanning, containerisation, AWS deployment, and monitoring.

## Pipeline Overview

The pipeline is built with GitHub Actions and is split into three jobs:

1. **Quality and testing**
   - Ruff
   - Bandit
   - pytest

2. **Container build and security**
   - Docker
   - Trivy
   - GitHub Container Registry

3. **Infrastructure and deployment**
   - Terraform
   - AWS EC2
   - AWS Systems Manager
   - Docker Compose
   - Deployment health checks

Pull requests run the tests, security checks, Docker build, and Terraform plan.

When a pull request is merged into `main`, the pipeline pushes the validated Docker image to GitHub Container Registry, applies the Terraform configuration, and deploys the application automatically to AWS.

## Deployment Design

Terraform creates the EC2 environment and stores its state remotely in an S3 bucket.

GitHub Actions authenticates to AWS using OIDC instead of stored AWS access keys. The application is deployed through AWS Systems Manager rather than GitHub connecting directly to the server with SSH.

The application image is tagged with the Git commit SHA, so the version deployed to EC2 is the same version that passed the pipeline checks.

The EC2 instance runs three containers through Docker Compose:

- Flask application
- Prometheus
- Grafana

## Monitoring

The Flask application exposes metrics through a `/metrics` endpoint.

Prometheus collects those metrics, and Grafana displays them in a provisioned dashboard. The dashboard includes:

- Request rate
- Average response time
- Total HTTP requests
- HTTP 5xx error ratio

## Main Tools

- Git and GitHub
- GitHub Actions
- Python and Flask
- pytest, Ruff, and Bandit
- Docker and Docker Compose
- Trivy
- Terraform
- AWS EC2, S3, IAM, OIDC, and Systems Manager
- GitHub Container Registry
- Prometheus and Grafana

## Project Structure

```text
app/             Flask application
tests/           Automated tests
terraform/       AWS infrastructure
monitoring/      Prometheus and Grafana configuration
scripts/         EC2 deployment script
.github/         GitHub Actions workflow
compose.yaml     Application and monitoring stack
Dockerfile       Application container image
```
