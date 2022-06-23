pipeline {
    agent any
    stages 
    {
        stage('Pull') 
        {
            steps {
                echo 'Pulling Code...'
                echo "Running ${env.BUILD_ID} ${env.BUILD_DISPLAY_NAME} on ${env.NODE_NAME} and JOB ${env.JOB_NAME}"
                git branch: 'main', url: 'https://github.com/BeingBright/zolder-app-frontend.git'
            }
        }
        stage('Build') 
        {
            steps {
                echo 'Cleaning...'
                sh "flutter clean"
                echo 'Building...'
                sh "flutter build web"
            }
        }
        stage('Deploy')
        {
            steps {
                echo 'Deploy...'
                echo 'Stopping current container...'
                sh 'docker stop --time=1 zolder-app-frontend-container || true'

                echo 'Removing current container...'
                sh 'docker rm zolder-app-frontend-container || true'

                echo 'Removing current image...'
                sh 'docker rmi http:zolder-app-frontend || true'

                echo 'Rebuilding image...'
                sh 'docker build -t http:zolder-app-frontend -f Dockerfile .'

                echo 'Running container...'
                sh 'docker run -p 80:80 -d --name=zolder-app-frontend-container http:zolder-app-frontend'

            }
        }
       
    }

} 