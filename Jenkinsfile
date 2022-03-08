pipeline {
    agent any
    environment {
        registry = "oekstein/DevOpsInterviewAssignment"
        registryCredential = 'docker_hub'
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '20', daysToKeepStr: '5' ))
    }
    stages {
        stage('Pull Code') {
            steps {
                script {
                    checkout scm
                }
            }
        }
        stage('run tests') {
            steps {
                script {
					sh "sudo apt-get update"
					sh "apt-get install python3"
					sh "python3 -m virtualenv venv"
					sh "pip install -r requirements.txt"
                    sh "python3 -m unittest microservice/tests/test_service.py"
                }
            }
        }
        stage('build and push image') {
            steps {
                script {
                    sh 'build and push image to hub'
                }
            }
        }
        stage('deploy image') {
            steps {
                script {
                    sh 'build docker image'
                }
            }
        }
    }
}