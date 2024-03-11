### Install Docker on Ubuntu 22.04

#### Download the Docker script

```
curl -fsSL https://get.docker.com -o install-docker.sh
```

```
sh install-docker.sh
```

#### We need to add users to the Docker group to grant them appropriate permissions. Run the following commands to add users to the Docker group

```
sudo usermod -aG docker $USER
```

```
sudo usermod -aG docker jenkins
sudo reboot
```