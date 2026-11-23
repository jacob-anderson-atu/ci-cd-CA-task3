Task 3 CA CI/CD pipeline ATU PgDip DevOps

# DevOps CI/CD Pipeline

A lightweight end-to-end DevOps pipeline demonstrating automated testing, static analysis, security scanning, containerisation, cloud deployment, and application monitoring.

The project uses a small Python Flask application as the workload, with the primary focus on the CI/CD pipeline and supporting DevOps practices.

## Planned Pipeline

```text
Developer
    |
    v
Git + GitHub
    |
    v
GitHub Actions
    |
    +--> Automated Testing (pytest)
    |
    +--> Static Analysis (Ruff)
    |
    +--> Security Analysis (Bandit)
    |
    +--> Docker Build
    |
    +--> Container Vulnerability Scan (Trivy)
    |
    v
AWS EC2 Deployment
    |
    v
Docker Compose
    |
    +--> Flask Application
    +--> Prometheus
    +--> Grafana
```

## Technology Stack

- **Python / Flask** - Sample web application
- **Git / GitHub** - Source code management
- **GitHub Actions** - CI/CD automation
- **pytest** - Automated application testing
- **Ruff** - Python static analysis and linting
- **Bandit** - Python security analysis
- **Trivy** - Container vulnerability scanning
- **Docker** - Application containerisation
- **Docker Compose** - Container orchestration
- **AWS EC2** - Cloud deployment environment
- **Prometheus** - Application metrics collection
- **Grafana** - Metrics visualisation and monitoring

## Pipeline Stages

The pipeline is designed to execute the following stages automatically:

1. Checkout application source code.
2. Install application dependencies.
3. Run static code analysis.
4. Run security analysis.
5. Execute automated tests.
6. Build the Docker image.
7. Scan the container image for vulnerabilities.
8. Deploy the validated application to AWS EC2.
9. Monitor the deployed application using Prometheus and Grafana.

A failure in a required validation stage will prevent the application from progressing to deployment.

## Application

The project uses a deliberately small Flask web application so that the focus remains on the software delivery pipeline rather than application complexity.

Initial endpoints include:

- `/` - Application information and version
- `/health` - Application health status

Additional metrics will be exposed for Prometheus as monitoring is implemented.

## Deployment

Development is performed in an Ubuntu Linux virtual machine.

The completed pipeline will automatically deploy the containerised application to an AWS EC2 instance. Docker Compose will manage the application and monitoring services on the deployment host.

## Repository Structure

```text
.
├── .github/
│   └── workflows/
├── app/
├── tests/
├── monitoring/
├── docs/
├── Dockerfile
├── compose.yaml
├── requirements.txt
└── README.md
```

The repository structure will be expanded as each pipeline stage is implemented.

## Project Goals

The project is intended to demonstrate:

- Continuous Integration and Continuous Deployment
- Automated software testing
- Automated security and quality checks
- Containerised application delivery
- Cloud deployment
- Infrastructure monitoring and observability
- Reproducible DevOps workflows
- Secure handling of deployment credentials and secrets

## Status

**In Development**

Current implementation:

- [x] Development environment configured
- [x] Flask and pytest dependencies installed
- [x] Flask application
- [x] Automated tests
- [x] Static analysis
- [x] Security analysis
- [x] Docker containerisation
- [ ] GitHub Actions CI pipeline
- [ ] Trivy vulnerability scanning
- [ ] AWS EC2 deployment
- [ ] Docker Compose deployment
- [ ] Prometheus monitoring
- [ ] Grafana dashboard
- [ ] Automated end-to-end deployment