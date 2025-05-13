# Earnix DevOps Task

This assignment simulates a real-world DevOps tasks that automated deployment flow including infrastructure provisioning, application packaging, deployment automation, and baseline observability practices.

## What Was Built

- AWS EC2 instance provisioned with Terraform.
- Configuration and deployment automated with Ansible.
- A simple Nginx web application serving a static page "Web App".
- CI/CD pipeline using GitHub Actions to build and push the Docker image to DockerHub.
- Kubernetes manifests for production deployment.

## How the Automation Works

1. **Infrastructure Provisioning and Configuration(AWS)**:

Run `terraform apply` in the `terraform/` directory to provision an EC2 instance and security group.
- Note: my_ip is defined as variables and can be overcome through terraform.tfvars or using command
  terraform apply -var "my_ip=your_ip"

Run `ansible-playbook -i inventory.ini playbook.yml` in the `ansible/` directory to install Docker, configure the EC2 instance, pull the latest application image and runs the container with environment variables and logging.
- Note: Replace 'image: myusername/myapp:latest' with the real DockerHub repo.

2. **Application Containerization and CI/CD Pipeline**:

Pushing to the `main` branch triggers the GitHub Actions workflow to build and push the Docker image.
- Note: DOCKERHUB_USERNAME and DOCKERHUB_TOKEN are GitHub secrets

4. **Baseline Observability**:

- **Logging**: Docker uses the `json-file` driver; logs are stored at `/var/lib/docker/containers/[container-id]/[container-id]-json.log` on the EC2 instance with max size of 10MB and up to 3 files.

- **Monitoring (Suggested)**: Use `curl http://localhost` for health checks (the Prometheus node-exporter for metrics does not implemented).

4. **Security Best Practices**:

- SSH access restricted to a specified IP in the security group.
- Only ports 22 (SSH) and 80 (HTTP) are open.

Optional Bonus. **Kubernetes Deployment**:

Deploys the application to Kubernetes with environment variables and health probes, exposed via a LoadBalancer service.


## Application Configuration
- Environment variables (`APP_ENV`, `APP_SECRET`) are injected into the Docker container via Ansible's `docker_container` module.

## Observability suggestion
- Docker logging configured for application logs with max size of 10MB and up to 3 files.
- Monitoring health check through 'curl http://localhost' or/and Prometheus implementation with choosen metrics.

## Key Security Considerations
- Secrets can be passed as environment variables for a Simulation, for Production we should use Ansible Vault or AWS Secrets Manager. 

## Assumptions and Decisions
- Ubuntu 22.04 LTS for region eu-west-1 chosen for the EC2 instance.
- Nginx alpine is using for simplicity and lightweight containerization.
- DockerHub selected as the container registry.
