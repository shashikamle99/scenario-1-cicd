### Jenkins (LTS) install on Ubuntu 22.04

#### Jenkins require Java 11/17:

* Insatll java:

```
sudo apt install openjdk-17-jdk -y
```

* Jave version check
```
java -version
```

#### Install jenkins

[Refer here Jenkins official docs](https://www.jenkins.io/doc/book/installing/linux/#debianubuntu)

```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
```

```
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
```

```
sudo apt-get update
```

```
sudo apt-get install jenkins -y
```

* Jenkins version check:
```
jenkins --version
```



#### Jenkins add to sudoers group
```
sudo visudo
```
#### For admin persmision add this context to sudoers file

```
jenkins ALL=(ALL) NOPASSWD: ALL
```