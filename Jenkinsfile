pipeline{
    agent {
        node{
            label 'AGENT-1'
        }
    }

    environment{
        COURSE = "Jenkinsfile"
        appVersion = ""
        ACC_ID = "042357172666"
        PROJECT = "roboshop"
        COMPONENT = "catalogue"

    }

    stages {
        stage('Read Version'){
            steps{
                script{
                    def packageJSON = readJSON file: 'package.json'
                    appVersion = packageJSON.Version
                    echo "app version : ${appVersion}"
                }
            }
        }
        stage('Install Dependencies'){
            steps{
                script{
                    sh """
                        npm install
                    """
                }
            }
        }
        stage('Build Image'){
            steps{
                script{
                    withAWS(region:'us-east-1',credentials:'aws-creds') {
                        sh """
                        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com
                        docker build ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion} .
                        docker images
                        docker push ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion}
                        """
                }
            }
        }
            
    }
}

}

