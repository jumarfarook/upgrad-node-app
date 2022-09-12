#!/usr/bin/env groovy

pipeline {
    agent any
    environment {
	region = "us-east-1"  
	docker_repo_uri = "075059366645.dkr.ecr.us-east-1.amazonaws.com/upgrad-repo"
        container_name = "upgrad-node-app"
    }

    stages {
        stage('Build') {
             steps {
                // Get SHA1 of current commit
                script {
                    commit_id = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
		    image_id = sh(script: "echo ${docker_repo_uri}:${commit_id}", returnStdout: true).trim()
			
                }
		// Get Docker login credentials for ECR
                sh "aws ecr get-login --no-include-email --region ${region} | sh"
		// Build the Docker image
                sh "docker build -t ${docker_repo_uri}:latest ."
                // Push Docker image
                sh "docker push ${docker_repo_uri}:latest"
            }
         }
        stage('Deploy') {
            steps {
                script {
                    sshagent(credentials : ['jenkins-ssh-app']) {
			    sh """
				sudo ssh -tt ubuntu@54.165.226.254 -o StrictHostKeyChecking=no << EOF 
				sudo docker rm $(docker stop $(docker ps -a -q --filter name=${container_name} --format="{{.ID}}")>/dev/null 2>&1)>/dev/null 2>&1;
				sudo docker run -d --name=${container_name} -p 8090:8090 ${docker_repo_uri}:latest;
				exit 0;
				EOF"""
                    }
                }
            }
        }
    }
}
