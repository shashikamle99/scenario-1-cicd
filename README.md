## Deploy the Application on Tomcat server

### Require installation:

### Install Java 11:

```
sudo apt install openjdk-17-jdk -y
```
* Jave version check
```
java -version
```

### Tomcat Install on Ubuntu steps:

* Download tomcat 
[Refer here for download tomcat](https://tomcat.apache.org/download-90.cgi)
```
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.zip
```

```
sudo unzip apache-tomcat-9.0.85.zip -d /etc/

sudo mv /etc/apache-tomcat-9.0.85/ /etc/tomcat/ 

sudo chmod +x /etc/tomcat/bin/*.sh
```



####  Note: Run the following command and add below file into tomcat.service

```
sudo nano /etc/systemd/system/tomcat.service
```

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

* After adding tomcat.service file then restart the tomcat service
```
sudo systemctl daemon-reload

sudo systemctl start tomcat
```

* Tomcat service enable
```
sudo systemctl enable tomcat
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

* After created folder structure



####  Note: Run the following command and add below file into pom.xm

* Change the directory to /java-app
```
cd /java-app
```


```
sudo nano /pom.xml
```

```
<?xml version = "1.0" encoding = "UTF-8"?>
<project xmlns = "http://maven.apache.org/POM/4.0.0" 
   xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance"

xsi:schemaLocation = "http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
<modelVersion>4.0.0</modelVersion>

   <groupId>com.tutorialspoint</groupId>
   <artifactId>hello-world</artifactId>
   <version>1.0</version>
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

* Change the directory /java-app
```
cd /java-app
```


* Note: Run the following command and add below file App.java

```
sudo nano /src/main/java/com/app/example/App.java
```

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
      return "<center>Hello World Welcome..!!</center>";
   }
}
```

### Build the java application:

```
mvn package
```

### Deploy the Application to application to Tomcat directory:

```
sudo cp java-app/target/hello-world-1.0.war /etc/tomcat/webapps/
```

* Restart tomcat service:
```
sudo systemctl restart tomcat
```

### For access html webpage

```
http://<public-ip-address>:8080/hello-world-1.0
```
```
http:// :8080/hello-world-1.0
```