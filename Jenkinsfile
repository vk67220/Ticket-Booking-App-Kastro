pipeline {
    agent any
    
    parameters {
        choice(name: 'SERVICE', choices: ['api-gateway', 'user-service', 'movie-service', 'booking-service', 'payment-service', 'admin-service', 'frontend', 'all'], description: 'Select service to build and deploy')
        choice(name: 'DEPLOYMENT_TYPE', choices: ['docker-compose', 'kubernetes'], description: 'Select deployment type')
        string(name: 'VERSION', defaultValue: '1.0.0', description: 'Version number for the image')
    }
    
    environment {
        DOCKER_REGISTRY = 'your-registry.com'
        DOCKER_CREDENTIALS_ID = 'docker-credentials'
        KUBECONFIG_ID = 'kubeconfig'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Service') {
            when {
                expression { params.SERVICE != 'all' }
            }
            steps {
                script {
                    if (params.SERVICE == 'frontend') {
                        dir('frontend') {
                            sh 'npm install'
                            sh 'npm run build'
                        }
                    } else {
                        dir(params.SERVICE) {
                            sh 'mvn clean package -DskipTests'
                        }
                    }
                }
            }
        }
        
        stage('Build All Services') {
            when {
                expression { params.SERVICE == 'all' }
            }
            steps {
                script {
                    // Build backend services
                    ['api-gateway', 'user-service', 'movie-service', 'booking-service', 'payment-service', 'admin-service'].each { service ->
                        dir(service) {
                            sh 'mvn clean package -DskipTests'
                        }
                    }
                    
                    // Build frontend
                    dir('frontend') {
                        sh 'npm install'
                        sh 'npm run build'
                    }
                }
            }
        }
        
        stage('Build Docker Image') {
            when {
                expression { params.SERVICE != 'all' }
            }
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} ${DOCKER_REGISTRY}"
                        
                        def imageName = "${DOCKER_REGISTRY}/${params.SERVICE}:${params.VERSION}"
                        sh "docker build -t ${imageName} ./${params.SERVICE}"
                        sh "docker push ${imageName}"
                    }
                }
            }
        }
        
        stage('Build All Docker Images') {
            when {
                expression { params.SERVICE == 'all' }
            }
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} ${DOCKER_REGISTRY}"
                        
                        ['api-gateway', 'user-service', 'movie-service', 'booking-service', 'payment-service', 'admin-service', 'frontend'].each { service ->
                            def imageName = "${DOCKER_REGISTRY}/${service}:${params.VERSION}"
                            sh "docker build -t ${imageName} ./${service}"
                            sh "docker push ${imageName}"
                        }
                    }
                }
            }
        }
        
        stage('Deploy with Docker Compose') {
            when {
                expression { params.DEPLOYMENT_TYPE == 'docker-compose' }
            }
            steps {
                sh 'docker-compose down || true'
                sh 'docker-compose up -d'
            }
        }
        
        stage('Deploy to Kubernetes') {
            when {
                expression { params.DEPLOYMENT_TYPE == 'kubernetes' }
            }
            steps {
                script {
                    withCredentials([file(credentialsId: env.KUBECONFIG_ID, variable: 'KUBECONFIG')]) {
                        if (params.SERVICE != 'all') {
                            sh "sed -i 's|{{VERSION}}|${params.VERSION}|g' kubernetes/${params.SERVICE}-deployment.yaml"
                            sh "kubectl apply -f kubernetes/${params.SERVICE}-deployment.yaml"
                            sh "kubectl apply -f kubernetes/${params.SERVICE}-service.yaml"
                        } else {
                            ['api-gateway', 'user-service', 'movie-service', 'booking-service', 'payment-service', 'admin-service', 'frontend'].each { service ->
                                sh "sed -i 's|{{VERSION}}|${params.VERSION}|g' kubernetes/${service}-deployment.yaml"
                                sh "kubectl apply -f kubernetes/${service}-deployment.yaml"
                                sh "kubectl apply -f kubernetes/${service}-service.yaml"
                            }
                        }
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}