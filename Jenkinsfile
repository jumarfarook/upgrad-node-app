#!/usr/bin/env groovy

pipeline {
    agent any
    environment {
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
                // Push Docker image
                sh "docker push ${docker_repo_uri}:${commit_id}"
            }
         }
        stage('Deploy') {
            steps {
                // Clean up
                echo "docker run -d --name=upgrad-node-app -p 8090:8090 ${docker_repo_uri}:${commit_id}"
		sh '''#!/bin/bash
				date
				ssh -i /var/lib/jenkins/.ssh/id_rsa ubuntu@184.72.120.134 << ENDSSH
			    	date
			    	cd ~
			    	pwd
			ENDSSH
			'''
            }
        }
    }
}
