pipeline {
  environment {
    registry = "eyal309/flask_test"
    registryCredential = 'dockerhub'
    dockerImage = ''
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
            dockerImage.push("latest")
            dockerImage.push("${env.BUILD_NUMBER}")
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
        sh "docker rmi $registry:latest"
      }
    }
    stage('Update Kube Config'){
      steps {
        withAWS(region:'us-east-1',credentials:'aws') {
          sh 'aws eks --region us-east-1 update-kubeconfig --name education-eks-0QZdN0Ge'
        }
      }
    }
    stage('Deploy Updated Image to Cluster'){
      steps {
        sh '''
            export IMAGE="$registry:$BUILD_NUMBER"
            sed -ie "s~IMAGE~$IMAGE~g" manifest.yml
            .kubectl apply -f manifest.yml
        '''
      }
    }
  }
}