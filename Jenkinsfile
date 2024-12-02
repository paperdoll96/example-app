pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/paperdoll96/example-app.git'
            }
        }
        stage('Update Code') {
            steps {
                sh 'echo "Automated update" >> README.md'
                sh 'git add .'
                sh 'git commit -m "Automated update" || true'
                sh 'git push origin main'
            }
        }
    }
}

