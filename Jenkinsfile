#!/usr/bin/env groovy

pipeline {
    agent any
    environment {
	    region = "us-east-1"
        docker_repo_uri = "075059366645.dkr.ecr.us-east-1.amazonaws.com/upgrad-repo"
    }
    
    stages {
        stage('Build') {
             steps {
                // Get SHA1 of current commit
                script {
                    commit_id = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                }
                // Build the Docker image
                sh "docker build -t ${docker_repo_uri}:${commit_id} ."
            }
         }
        stage('Push image to AWS ECR') {
            steps {
                // Get Docker login credentials for ECR
                sh "aws ecr get-login --no-include-email --region ${region} | sh"
                // Push Docker image
                sh "docker push ${docker_repo_uri}:${commit_id}"
            }
        }
        stage('Deploy') {
            steps {
                // Clean up
                echo "Deploying -> ${docker_repo_uri}:${commit_id}"
            }
        }
    }
}
