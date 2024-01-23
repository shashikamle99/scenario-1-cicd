#!/bin/bash
mvn package
sudo cp /home/ubuntu/java-app/target/hello-world-1.0.war /etc/tomcat/webapps/
sudo systemctl restart tomcat
