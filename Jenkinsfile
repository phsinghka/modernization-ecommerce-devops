//SAMPLE FILE 


// Jenkinsfile

pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "your_dockerhub_username/microblog"
        DOCKER_CREDENTIALS = credentials('dockerhub_credentials')
        KUBECONFIG_CREDENTIALS = credentials('kubeconfig')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/yourusername/microblog.git'
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
            }
        }
        stage('Test') {
            steps {
                sh 'docker run --rm $DOCKER_IMAGE:$BUILD_NUMBER pytest'
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    sh 'docker push $DOCKER_IMAGE:$BUILD_NUMBER'
                }
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh 'export KUBECONFIG=$KUBECONFIG'
                    sh 'kubectl set image deployment/microblog-deployment microblog=$DOCKER_IMAGE:$BUILD_NUMBER --record'
                }
            }
        }
    }
}
