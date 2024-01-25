#!/bin/env/groovy

node ('terraform') {
  err = null
  try{
    stage('Checkout'){
      echo "${params}"
      gitscmvar=checkout scmGit(
      branches: [[name: params.branch_name]], extensions: [],
      userRemoteConfigs: [[credentialsId: 'git-token', url: 'https://github.com/KamyNz/ci-cd-jenkins-terraform.git']])

      sh 'ls -l'  //bat 'dir' When windows
      echo "${gitscmvar}"
    }
    branch='main'

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
        when(branch == 'main'){
          sh 'terraform apply tfplan'
      }

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

