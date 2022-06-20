pipeline {
    agent any
    stages 
    {
        stage('Pull') 
        {
            steps {
                echo 'Pulling Code...'
                echo "Running ${env.BUILD_ID} ${env.BUILD_DISPLAY_NAME} on ${env.NODE_NAME} and JOB ${env.JOB_NAME}"
              git branch: 'development-better', url: 'https://github.com/BeingBright/zolder-app-backend.git'
            }
        }
        stage('Build') 
        {
            steps {
                echo 'Building...'  
                sh "flutter build web"
            }
        }
        // stage('Saving Results') 
        // {
        //     steps {
        //          junit 'target/surefire-reports/TEST-*.xml'
        //          archiveArtifacts 'target/*.jar'
        //     }
        // }
        // stage('Deploy') 
        // {
        //     steps {
        //         echo 'Deploy...'  
        //         echo 'Stopping current container...'  
        //         sh 'docker stop --time=1 zolder-app-backend-container || true'
        //         echo 'Removing current container...'  
        //         sh 'docker rm zolder-app-backend-container || true'
        //         echo 'Rebuilding container...'  
        //         sh 'docker build -t java:zolder-app-backend -f Dockerfile .'
        //     }
        // }
       
    }

} 