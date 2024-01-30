pipeline {
    agent any
    triggers {
        pollSCM ('* * * * *')
    }

    stages {
        stage('SCM') {
            steps {
                git branch: 'dev',
                url: 'https://github.com/shashikamle99/scenario-1-cicd.git'
            }
        }
        stage('SonarQube analysis') {
          steps {
              withSonarQubeEnv('SONAR_CLOUD') {
                sh "mvn sonar:sonar -Dsonar.projectKey=java-project-demo -Dsonar.organization=java-project-demo -Dsonar.token=a64e938e4479814e8dd3a080e2b085270f7d884b"
                }
            } 
        }    
        
        stage('build and artifactory') {
            steps{
                rtMavenDeployer (
                    id: "JAVA-DEPLOYER",
                    serverId: "jfrog-artifactory",
                    releaseRepo: 'libs-release-local',
                    snapshotRepo: 'libs-snapshot-local'
                )
                rtMavenRun (
                    deployerId: "JAVA-DEPLOYER",
                    tool: "Maven-3.6.3",
                    pom: 'pom.xml',
                    goals: 'clean install'
                )
                rtPublishBuildInfo (
                    serverId: "jfrog-artifactory"
                )
            }
        }

        stage('Deploy') {
            steps {
                deploy adapters: [tomcat9(url: 'http://13.56.59.186:8080', 
                              credentialsId: 'Tomcat_Cred')], 
                     war: '**/*.war',
                     contextPath: 'app'
            }
        }
    }
}