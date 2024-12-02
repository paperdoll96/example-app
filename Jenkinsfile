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
                withCredentials([usernamePassword(credentialsId: 'github-password', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        git config user.name "paperdoll96"
                        git config user.email "your-email@example.com"
                        git remote set-url origin https://paperdoll96:$PASSWORD@github.com/paperdoll96/example-app.git
                        echo "Automated update" >> README.md
                        git add .
                        git commit -m "Automated update" || true
                        git push origin main
                    '''
                }
            }
        }
    }
}
