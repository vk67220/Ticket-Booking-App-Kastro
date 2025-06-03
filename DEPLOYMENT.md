# Movie Ticket Booking Application Deployment Guide

This guide provides step-by-step instructions for deploying the Movie Ticket Booking microservices application using either Docker Compose (for local development) or Jenkins CI/CD with AWS EKS (for production).

## Option 1: Docker Compose Deployment

### Prerequisites
- Docker and Docker Compose installed
- Git

### Steps

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd movie-ticket-booking
   ```

2. Start the application:
   ```bash
   docker-compose up -d
   ```

3. Access the services:
   - Frontend: http://localhost
   - Admin Dashboard: http://localhost:8999
   - API Gateway: http://localhost:80
   - User Service: http://localhost:81
   - Movie Service: http://localhost:82
   - Booking Service: http://localhost:83
   - Payment Service: http://localhost:84

4. To stop the application:
   ```bash
   docker-compose down
   ```

5. To access the MySQL database:
   ```bash
   docker exec -it movie-db mysql -u root -p
   ```
   Enter the password: `rootpassword`

## Option 2: Jenkins CI/CD with AWS EKS Deployment

### Prerequisites
- Jenkins server with necessary plugins
- Docker and Kubernetes plugins for Jenkins
- AWS EKS cluster
- Docker registry (e.g., ECR, DockerHub)
- AWS CLI and kubectl configured

### Setup Jenkins

1. Install required plugins:
   - Docker Pipeline
   - Kubernetes CLI
   - AWS Credentials

2. Configure credentials in Jenkins:
   - Add Docker registry credentials with ID: `docker-credentials`
   - Add AWS credentials with ID: `aws-credentials`
   - Add Kubeconfig with ID: `kubeconfig`

3. Create a Jenkins pipeline job:
   - Select "Pipeline from SCM"
   - Specify your repository URL
   - Set the script path to `Jenkinsfile`

### Deploy to AWS EKS

1. Create the Kubernetes namespace:
   ```bash
   kubectl apply -f kubernetes/namespace.yaml
   ```

2. Create MySQL secrets:
   ```bash
   kubectl apply -f kubernetes/mysql-secrets.yaml
   ```

3. Create MySQL persistent volume claim:
   ```bash
   kubectl apply -f kubernetes/mysql-pvc.yaml
   ```

4. Run the Jenkins pipeline:
   - Navigate to your Jenkins job
   - Click "Build with Parameters"
   - Select service to build (or "all")
   - Choose "kubernetes" as deployment type
   - Enter version number
   - Click "Build"

5. Access the application:
   - Find the load balancer URLs:
     ```bash
     kubectl get svc -n movie-booking
     ```
   - Access the frontend using the URL for the frontend service
   - Access the admin dashboard using the URL for the admin service

### Monitoring

1. Check pod status:
   ```bash
   kubectl get pods -n movie-booking
   ```

2. View logs:
   ```bash
   kubectl logs -f deployment/[service-name] -n movie-booking
   ```

3. Check services:
   ```bash
   kubectl get svc -n movie-booking
   ```

## Database Access

### Local Docker Compose

```bash
docker exec -it movie-db mysql -u root -p
```
Enter password: `rootpassword`

### Kubernetes

```bash
kubectl exec -it $(kubectl get pods -n movie-booking -l app=mysql -o jsonpath='{.items[0].metadata.name}') -n movie-booking -- mysql -u root -p
```
Enter password: `rootpassword`

## Common MySQL Commands

```sql
-- Show databases
SHOW DATABASES;

-- Select a database
USE user_db;  -- or movie_db, booking_db, payment_db, admin_db

-- Show tables
SHOW TABLES;

-- Query data
SELECT * FROM users;
SELECT * FROM movies;
SELECT * FROM bookings;
```

## Troubleshooting

### Docker Compose
- Check container logs: `docker-compose logs [service-name]`
- Restart services: `docker-compose restart [service-name]`
- Rebuild services: `docker-compose up -d --build [service-name]`

### Kubernetes
- Check pod status: `kubectl describe pod [pod-name] -n movie-booking`
- Restart deployment: `kubectl rollout restart deployment [deployment-name] -n movie-booking`
- Check configmaps: `kubectl get configmaps -n movie-booking`
- Check secrets: `kubectl get secrets -n movie-booking`