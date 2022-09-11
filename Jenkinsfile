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
        stage('pushing to ECR') {
            steps {
                echo "pushing image to ECR... ${docker_repo_uri}:${commit_id}"
            }
        }
        stage('cleaning up') {
            steps {
                // Clean up
                echo "cleaning up -> docker rmi -f ${docker_repo_uri}:${commit_id}"
            }
        }
    }
}
