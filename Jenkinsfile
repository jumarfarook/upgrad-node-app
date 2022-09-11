#!/usr/bin/env groovy

pipeline {
    agent any
    
    stages {
        stage('build') {
            steps {
                echo "building the app.."
            }
        }
        stage('pushing to ECR') {
            steps {
                echo "pushing image to ECR..."
            }
        }
    }
}
