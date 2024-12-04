pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/paperdoll96/example-app.git'
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh '''
                        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                        docker build -t paperdoll96/custom-nginx:1.0 .
                        docker push paperdoll96/custom-nginx:1.0
                    '''
                }
            }
        }
        stage('Update Git Repository') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-password', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        git config user.name "paperdoll96"
                        git config user.email "your-email@example.com"
                        git remote set-url origin https://paperdoll96:$PASSWORD@github.com/paperdoll96/example-app.git

                        # 변경 사항이 있는 경우만 실행
                        if ! git diff --quiet; then
                            echo "Automated update" >> README.md
                            git add .

                            # 현재 시간 가져오기
                            TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

                            # 커밋 메시지에 시간 추가
                            git commit -m "Automated update - Timestamp: $TIMESTAMP" || true
                            git push origin main
                        else
                            echo "No changes to commit"
                        fi
                    '''
                }
            }
        }
        stage('Trigger ArgoCD Sync') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'argocd-token', variable: 'ARGOCD_TOKEN')]) {
                        sh '''
                            curl -k -X POST -H "Authorization: Bearer $ARGOCD_TOKEN" \
                            https://211.183.3.100:30867/api/v1/applications/project-app/sync
                        '''
                    }
                }
            }
        }
    }
}
