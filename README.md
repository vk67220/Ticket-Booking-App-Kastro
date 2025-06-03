# Movie Ticket Booking Microservices Application

This is a comprehensive movie ticket booking application built with a microservices architecture. The application allows users to browse movies, select showtimes, book seats, and receive tickets with QR codes. Admins can manage movies, theaters, and pricing through a dedicated admin portal.

## Architecture Overview

The application consists of the following microservices:

1. **API Gateway Service** (Port 80) - Entry point for all client requests
2. **User Service** (Port 81) - Handles user authentication and profile management
3. **Movie Service** (Port 82) - Manages movie information and showtimes
4. **Booking Service** (Port 83) - Handles seat selection and ticket booking
5. **Payment Service** (Port 84) - Manages payment processing
6. **Admin Service** (Port 8999) - Provides admin functionality

## Tech Stack

- **Backend**: Java with Spring Boot
- **Frontend**: React with TypeScript
- **Database**: MySQL
- **Containerization**: Docker
- **CI/CD**: Jenkins
- **Orchestration**: Kubernetes (AWS EKS)

## Deployment Options

### Option 1: Docker Compose (Local Development)

```bash
docker-compose up -d
```

### Option 2: Jenkins CI/CD with AWS EKS

Each microservice has its own Jenkinsfile and Kubernetes deployment files.

## Database Access

To access the MySQL database in the Docker container:

```bash
docker exec -it movie-db mysql -u root -p
```

The default password is set in the docker-compose.yml file.