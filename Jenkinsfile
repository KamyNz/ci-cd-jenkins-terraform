#!/bin/env/groovy

node ('terraform') {
  err = null
  try{
    stage('Checkout'){
      checkout scmGit(
      branches: [[name: '*/main']], extensions: [],
      userRemoteConfigs: [[credentialsId: 'git-token', url: 'https://github.com/KamyNz/ci-cd-jenkins-terraform.git']])

      sh 'ls -l'
      //bat 'dir' When windows
    }

    withCredentials([[ $class: 'AmazonWebServicesCredentialsBinding',
                      credentialsId : 'aws_credentials',
                      accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                      secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
    ]]) {

      stage('Init'){
        sh 'terraform init'
      }

      stage('Validate'){
        sh '''terraform fmt
            terraform validate'''
      }

      stage('Plan'){
        sh 'terraform plan -out tfplan'
      }

      stage('Apply'){
        sh 'terraform apply tfplan'
      }

    }

  }
  catch(caughtError){
    err = caughtError
  }
  finally{
    cleanWs()
    if(err){
      throw err
    }
  }
}

