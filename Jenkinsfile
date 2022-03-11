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
					dockerImage = docker.build registry + ":$BUILD_NUMBER"
					}
            }
        }
        stage('deploy image') {
            steps {
				script {
					docker.withRegistry( '', registryCredential ) {
						dockerImage.push()
					}
				}
			}
		}
}