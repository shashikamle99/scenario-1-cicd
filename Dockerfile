FROM tomcat:9-jdk11-openjdk-slim
MAINTAINER kamle
COPY java-app/target/hello-world-1.0.war /etc/tomcat/webapps/
EXPOSE 8080