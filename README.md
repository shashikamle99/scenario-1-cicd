## Deploy the Application on Tomcat server

### Require installation:

### Install Java 11:

```
sudo apt install openjdk-11-jdk -y
```
* Jave version check
```
java -version
```

### Tomcat Install on Ubuntu steps:

```
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.zip

tar -xf apache-tomcat-9.0.85.zip -C /etc/

mv /etc/apache-tomcat-9.0.85/ /etc/tomcat/ 

sudo chmod +x /etc/tomcat/bin/*.sh

sudo systemctl daemon-reload

sudo systemctl start tomcat
```

```
sudo nano /etc/systemd/system/tomcat.service
```

####  Note: add below file into tomcat.service

```
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=root
Group=root

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"

Environment="CATALINA_BASE=/etc/tomcat"
Environment="CATALINA_HOME=/etc/tomcat"
Environment="CATALINA_PID=/etc/tomcat/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/etc/tomcat/bin/startup.sh
ExecStop=/etc/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
```

### Install maven:

```
sudo apt install maven -y
```

* Maven version check
```
mvn -version
```

### Generate java project folder structure:

```
mvn archetype:generate -DgroupId=com.app.example -DartifactId=java-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```

* After creating floder structure

```
sudo nano /java-app/pom.xml
```

####  Note: add below file into pom.xm

```
<?xml version = "1.0" encoding = "UTF-8"?>
<project xmlns = "http://maven.apache.org/POM/4.0.0" 
   xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance"

xsi:schemaLocation = "http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
<modelVersion>4.0.0</modelVersion>

   <groupId>com.tutorialspoint</groupId>
   <artifactId>hello-world</artifactId>
   <version>1</version>
   <packaging>war</packaging>
   
   <parent>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-parent</artifactId>
      <version>2.3.0.RELEASE</version>
      <relativePath/> 
   </parent>

   <properties>
      <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
      <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
      <java.version>1.8</java.version>
      <tomcat.version>9.0.37</tomcat.version>
   </properties>

   <dependencies>
      <dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-web</artifactId>
      </dependency>
      <dependency>  
         <groupId>org.springframework.boot</groupId>  
	 <artifactId>spring-boot-starter-tomcat</artifactId>  
	 <scope>provided</scope>  
      </dependency>   
      <dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-test</artifactId>
         <scope>test</scope>
      </dependency>
   </dependencies>

   <build>
      <plugins>
         <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
         </plugin>
      </plugins>
   </build>
   
</project>
```

## Create the java application: 

```
sudo nano /java-app/src/main/java/com/app/example/App.java
```
* Note: add below file App.java

```
package com.app.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class App extends SpringBootServletInitializer {
   @Override
   protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
      return application.sources(App.class);
   }
   public static void main(String[] args) {
      SpringApplication.run(App.class, args);
   }

   @RequestMapping(value = "/")
   public String hello() {
      return "<center>Hello World Aahhh Mantaapp</center>";
   }
}
```

### Build the java application:

```
mvn package
```

### Deploy the Application to application to Tomcat directory:

```
sudo cp java-app/target/hello-world-1.war /etc/tomcat/webapps/
```

* Restart tomcat service:
```
sudo systemctl restart tomcat
```