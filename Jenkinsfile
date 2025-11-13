pipeline {
  agent {
    label 'k8s-slave'
  }
  environment {
    APPLICATION_NAME = "eureka"
    POM_VERSION = readMavenPom().getVersion()
    POM_PACKAGING = readMavenPom().getPackaging()
    DOCKER_HUB = "docker.io/dravikumar442277"
    DOCKER_CREDS = credentials('dravikumar442277_docker_creds')

  }
  tools {
    maven  'Maven3.8.8'
    jdk 'java17'
  }
  stages {
    stage ('Building the application') {
        steps {
            echo "this is ${env.APPLICATION_NAME} application"
            sh "mvn clean package -DskipTests=True"
        } 
    }
    stage ('Unit test cases') {
      steps {
        echo "Performing Unit test cases for ${env.APPLICATION_NAME} application"
        sh "mvn test"  
      }
      post {
        always {
          junit 'target/surefire-reports/*.xml'
          echo "testing unit tests"
        }
      }  
    }
    stage ('Docker && Custom Format') {
      steps {
        echo "actual format: ${env.APPLICATION_NAME}-${env.POM_VERSION}-${env.POM_PACKAGING}"
        echo "custm app: ${env.APPLICATION_NAME}-${currentBuild.number}-${BRANCH_NAME}-${env.POM_PACKAGING}"
      }
    }
    stage ('Docker Build') {
      steps {
        sh """
        ls -la 
        ls -la .
        cp ${workspace}/target/${env.APPLICATION_NAME}-${env.POM_VERSION}.${env.POM_PACKAGING}  .
        ls -la ./.cicd
        echo ************docker build now working********
        docker build  --force-rm --no-cache --pull --rm=true --build-arg JAR_SOURCE=${env.APPLICATION_NAME}-${env.POM_VERSION}.${env.POM_PACKAGING}  -t ${env.DOCKER_HUB}/${env.APPLICATION_NAME}:${GIT_COMMIT}  .
        docker images
        echo ************docker login now ********
        docker login  -u ${DOCKER_CREDS_USR} -p ${DOCKER_CREDS_PSW}
        docker push ${env.DOCKER_HUB}/${env.APPLICATION_NAME}:${GIT_COMMIT}
        """
      }
    }
  }
}
