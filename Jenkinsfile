#!/bin/env/groovy

node ('terraform') {
  try{

    checkout scmGit(
      branches: [[name: '*/main']], extensions: [],
      userRemoteConfigs: [[credentialsId: 'git-token', url: 'https://github.com/KamyNz/ci-cd-jenkins-terraform.git']])

    sh 'ls -l'
    //bat 'dir' When windows
  }
  catch(caughtError){
    err = caughtError

  }
  finally{
    //cleanWs()
  }
}

