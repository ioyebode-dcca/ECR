pipeline {
	environment {
	    registry = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
            AWS_ACCOUNT_ID="150685619118"
            AWS_DEFAULT_REGION="us-east-1" 
            IMAGE_REPO_NAME="underwater"
	}
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
         stage('https://github.com/oyebode23/ECR') { 
            steps { 
                script{
                checkout scm
                }
            }
        }

        stage('Build') { 
            steps { 
                script{
                 app = docker.build("underwater")
                }
            }
        }
        stage('Test'){
            steps {
                 echo 'Empty'
		 //sh 'npm install'
		 //sh 'npm test'	 
            }
        }
        stage('Deploy') {
            steps {
                script{
                        docker.withRegistry('https://150685619118.dkr.ecr.us-east-1.amazonaws.com/', 'ecr:us-east-1:aws-credentials') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
                }
            }
        }
        //stage('Cleaning up') { 
          //  steps { 
		//    sh "docker rmi $registry:$BUILD_NUMBER" 
        //} 
      //}
    }
}
