pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK'
    }

    environment {
        SPRING_PROFILES_ACTIVE = 'prod'
        SERVER_PORT = '8080'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 40, unit: 'MINUTES')
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh './mvnw -ntp verify'
            }
        }

        stage('Test') {
            steps {
                sh './mvnw -ntp test'
            }
        }

        stage('Package') {
            steps {
                sh './mvnw -ntp -Pprod clean package -DskipTests'
            }
        }

        stage('publish docker') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-login', passwordVariable: 'DOCKER_REGISTRY_PWD', usernameVariable: 'DOCKER_REGISTRY_USER')]) {
                    sh "./mvnw -ntp jib:build"
                }
            }
        }
    }

    post {
        success {
            echo 'Build successful!'
        }
        failure {
            echo 'Build failed!'
        }
        always {
            junit allowEmptyResults: true, testResults: 'target/test-results/**/*.xml'
        }
    }
}

