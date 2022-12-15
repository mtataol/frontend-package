pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        metadata: 
          name: kube-pod
        spec:
          containers:
          - name: docker
            image: docker:latest
            command:
            - cat
            tty: true
            securityContext:
              privileged: true
              runAsUser: 0
            volumeMounts:
            - mountPath: /var/run/docker.sock
              name: docker-sock
          volumes:
          - name: docker-sock
            hostPath:
              path: /var/run/docker.sock    
        '''
    }
  }
  stages {
    stage('Clone') {
      steps {
        container('frontend') {
          git branch: 'main', changelog: false, poll: false, url: 'git@github.com:mtataol/frontend-package.git'
        }
      }
    }  
    stage('Build-Docker-Image') {
      steps {
        container('docker') {
          sh 'docker build -t robolaunchio/frontend-first:latest .'
        }
      }
    }
    stage('Login-Into-Docker') {
      steps {
        container('docker') {
          sh 'docker login -u robolaunchio -p ProvEdge_CP2021#'
        }
      }
    }
     stage('Push-Images-Docker-to-DockerHub') {
      steps {
        container('docker') {
          sh 'docker push robolaunchio/frontend-first:latest'
        }
      }
     }
  }
    post {
      always {
        container('docker') {
          sh 'docker logout'
        }
      }
    }
}