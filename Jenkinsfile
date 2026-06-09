pipeline {
    agent any
    stages {
        stage('Build')
        {
            steps {
                //Pulls Latest repo
                echo "Building"
                checkout scm
            }    
        }
        stage('Test')
        {
            steps {
                echo "Testing"
            }    
        }
        stage('Deploy')
        {
            steps {
                echo "Deploying"
            }    
        }
    }
}