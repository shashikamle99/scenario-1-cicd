pipeline {
    agent { label 'maven'}

    stages {
        stage('SCM') {
            steps {
                git branch: 'main',
                url: 'https://github.com/shashikamle99/scenario-1-cicd.git'
            }
        }
        stage('Build') {
            steps {
                sh "mvn clean package"
            }
        }
        stage('Deploy') {
            steps {
                sh "sudo cp ./target/hello-world-1.0.war /etc/tomcat/webapps/"
                sh "sudo systemctl restart tomcat"
            }
        }
        stage('Reports') {
            steps {
                junit '**/target/surefire-reports/TEST-*.xml'
            }
        }
        stage('Artifacts') {
            steps {
                archiveArtifacts 'target/*.war'
            }
        }
    }
}