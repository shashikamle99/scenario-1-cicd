### Jenkins (LTS) install on Ubuntu 22.04
```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```
* Jenkins version check:
```
jenkins --version
```

[Refer here Jenkins official docs](https://www.jenkins.io/doc/book/installing/linux/#debianubuntu)

#### Jenkins add to sudoers group
```
sudo visudo
```
#### For admin persmision add this context to sudoers file
```
For admin persmision add this context to sudoers file
```