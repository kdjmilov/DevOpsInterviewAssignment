pipeline {
    agent any
    environment {
		DOCKERHUB_CREDENTIALS = credentials('kdjmilov-dockerhub')
		registry = "kdjmilov/dato_homework"
		registryCredential = 'kdjmilov'
		dockerImage = ''
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
					sh "apt-get install -y apt-utils"
					sh "apt-get install python3 -y"
					sh "apt-get install python3-pip -y"
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
					sh "curl -fsSL https://get.docker.com -o get-docker.sh"
					sh "get-docker.sh"
					sh "docker build . -t kdjmilov/homework:latest"
					sh "docker login --username $DOCKERHUB_CREDENTIALS_USR --password $DOCKERHUB_CREDENTIALS_PSW"
					sh "docker push kdjmilov/homework:latest"
				}
            }
        }
        stage('deploy image') {
            steps {
				script {
					sh "kubectl set image deployment/microservice-deployment microservice=kdjmilov/homework:latest"
				}
			}
		}
	}
}