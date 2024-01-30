pipeline {
    agent any

    stages {
        stage('SCM') {
            steps {
                git branch: 'dev',
                url: 'https://github.com/shashikamle99/scenario-1-cicd.git'
            }
        }
        stage('build') {
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
                    goals: 'mvn install'
                )
                rtPublishBuildInfo (
                    serverId: "jfrog-artifactory"
                )
            }
        }

        // stage('Deploy') {
        //     steps {
        //         sh "cp ./target/hello-world-1.0.war /etc/tomcat/webapps/"
        //     }
        // }
    }
}