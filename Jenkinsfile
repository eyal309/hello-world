pipeline {
  environment {
    registry = "eyal309/flask_test"
    registryCredential = 'dockerhub'
    dockerImage = ''
    dockerHome = tool 'Docker'
    env.PATH = "${dockerHome}/bin:${env.PATH}"
    }
  }
  agent any
  stages {
   stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
   stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
   stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}