pipeline{
    agent any
    stages{
        stage('Build'){
            steps{
                echo "Build has started"
                sh 'docker build -t myapp:latest .'
            }
        }
        stage('Test'){
            steps{
                echo "Test has started"
                sh 'docker run --rm myapp:latest npm test'
            }
        }
        stage('NegativeTesting'){
            steps{
                echo "Negative Testing has started"
            }
        }
        stage('Deploy'){
            steps{
                echo "Deploy has started"
            }
        }
    }
}