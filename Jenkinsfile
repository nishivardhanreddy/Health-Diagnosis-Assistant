pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'nishivardhan/disease-predictor'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/nishivardhanreddy/Health-Diagnosis-Assistant.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', 'docker_hub_credentials') {
                        echo 'Logged in to Docker Hub'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'docker_hub_credentials') {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    sh '''
                        docker rm -f disease-predictor-container || true
                        docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
                        docker run -d --name disease-predictor-container -p 8501:8501 ${DOCKER_IMAGE}:${DOCKER_TAG}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image pushed and deployed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
