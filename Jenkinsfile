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

                        # 변경 사항이 있는 경우만 실행
                        if ! git diff --quiet; then
                            echo "Automated update" >> README.md
                            git add .

                            # 변경된 파일 목록 가져오기
                            CHANGES=$(git diff --name-only --cached)
                            
                            # 커밋 메시지에 변경된 파일 이름 포함
                            git commit -m "Automated update - Changes: $CHANGES" || true
                            git push origin main
                        else
                            echo "No changes to commit"
                        fi
                    '''
                }
            }
        }
    }
}

