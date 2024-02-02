pipeline {
    agent any
    // triggers {
    //     pollSCM ('* * * * *')
    // }

    stages {
        stage('SCM') {
            steps {
                git branch: 'dev',
                url: 'https://github.com/shashikamle99/scenario-1-cicd.git'
            }
        }
        stage('SonarQube Analysis') {
          steps {
              withSonarQubeEnv('SONAR_CLOUD') {
                sh "mvn sonar:sonar -Dsonar.projectKey=java-project-demo -Dsonar.organization=java-project-demo -Dsonar.token=f240b887c2046b6180d38e174df58002e2bfa54d"
                }
            } 
        }    
        
        stage('Build and Artifactory') {
            steps{
                rtMavenDeployer (
                    id: "JAVA-DEPLOYER",
                    serverId: "jfrog-artifactory",
                    releaseRepo: 'java-app-libs-release-local',
                    snapshotRepo: 'java-app-libs-release-local'
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
        
        stage('Junit Reports') {
            steps {
                junit '**/target/surefire-reports/TEST-*.xml'
            }
        }

        stage('Deploy') {
            steps {
                deploy adapters: [tomcat9(url: 'http://172.31.18.83:8080', 
                              credentialsId: 'Tomcat_Cred')], 
                     war: '**/*.war'
                    //  contextPath: 'app'
            }
        }
    }
}
