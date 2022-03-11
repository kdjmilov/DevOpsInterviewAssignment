pipeline {
    agent any
    environment {
		DOCKERHUB_CREDENTIALS = credentials('kdjmilov-dockerhub')
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
				
					sh "apt-get update"
					sh "apt-get install python3 -y"
					sh "apt-get install python3-pip -y"
					sh "apt update"
					sh "apt-get install apt-transport-https ca-certificates curl software-properties-common -y"
					sh "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
					sh "apt-get update"
					sh "apt-get install docker-ce"
					sh "pip install virtualenv"
					sh "python3 -m virtualenv venv"
					sh "pip install -r requirements.txt"
                    sh "python3 -m unittest microservice/tests/test_service.py"
                }
            }
        }
        stage('build and push image') {
            steps {
                script {
                    sh "docker build . -t kdjmilov/homework:test"
                    sh "docker login --username $DOCKERHUB_CREDENTIALS_USR --password $DOCKERHUB_CREDENTIALS_PSW"
                    sh "docker push kdjmilov/homework:test"
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