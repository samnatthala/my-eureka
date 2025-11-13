pipeline {
    agent{
        label = k8s-slave
    }
    environment {
        APPLICATION_NAME = eureka
    }
    stages{
        stage ('Build '){
        echo "we are building the ${env.APPLICATION_NAME} application..."    
        sh "mvn clean package"

        }
    }
}