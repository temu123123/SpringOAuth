pipeline {
    agent any

    environment {
        DOCKER_HUB_USERNAME = credentials('docker-hub-username')  
        DOCKER_HUB_TOKEN = credentials('docker-hub-token')        
        TAG = "${new Date().format('yyyyMMddHHmmss')}"
    }

    triggers {
        pollSCM('H/5 * * * *')  
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', url: 'https://github.com/temu123123/SpringOAuth.git'
            }
        }

        stage('Build & Test') {
            parallel {
                stage('Setup JDK 21') {
                    steps {
                        echo 'Setting up JDK 21...'
                        tool name: 'jdk21', type: 'jdk'
                    }
                }
                stage('Run Tests') {
                    steps {
                        echo 'Running Gradle tests...'
                        sh 'chmod +x ./gradlew'
                        sh './gradlew test'
                    }
                }
                stage('Build Application') {
                    steps {
                        echo 'Building Spring Boot app...'
                        sh './gradlew clean build'
                    }
                }
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                echo 'Building and pushing Docker image...'
                sh """
                    echo $DOCKER_HUB_TOKEN | docker login -u $DOCKER_HUB_USERNAME --password-stdin
                    docker build -t $DOCKER_HUB_USERNAME/spring-boot-for-beginners:$TAG .
                    docker push $DOCKER_HUB_USERNAME/spring-boot-for-beginners:$TAG
                """
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment completed successfully!"
        }
        failure {
            echo "❌ Build failed. Check the logs for details."
        }
    }
}
