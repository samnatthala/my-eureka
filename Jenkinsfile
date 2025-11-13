pipeline {
    agent{
        label = k8s-slave
    }
    environment {
        APPLICATION_NAME = "eureka"
    }
    tools {
        maven 'maven-3.9.11'
        jdk 'jdk-17'
    }
    stages{
        stage ('Build '){
        echo "we are building the ${env.APPLICATION_NAME} application..."    
        sh "mvn clean package"

        }
    }
}