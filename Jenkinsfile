pipeline {
    agent any

    environment {
        // Set up Docker Hub credentials
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')

        // Set up Kubernetes credentials
        KUBE_CONFIG = credentials('kube-config')
    }

    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Pull Alpine Docker image
                    docker.image('alpine:latest').pull()

                    // Install necessary dependencies
                    sh 'apk --no-cache add curl wget'

                    // Build Docker image
                    docker.build("my-application-image:${BUILD_NUMBER}", "-f path/to/Dockerfile .")

                    // Authenticate with Docker Hub
                    docker.withRegistry('https://registry.example.com', DOCKER_HUB_CREDENTIALS) {
                        // Push Docker image to Docker Hub
                        docker.image("my-application-image:${BUILD_NUMBER}").push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Set Kubernetes config
                    withKubeConfig([credentialsId: 'kube-config', serverUrl: 'https://your-kubernetes-api-server']) {
                        // Deploy to Kubernetes
                        sh 'kubectl apply -f path/to/kubernetes-deployment.yaml'
                    }
                }
            }
        }
    }
}

