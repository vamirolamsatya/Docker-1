# Docker
Various Docker-related content such as shellscripts, Dockerfiles and the like. Not necessarily up-to-date or even working. Use at your own risk, apply some common sense.

Most of this is somehow tailored to be run on a Raspberry Pi or Asus Tinkerboard. Heres a cheatsheet to install Docker on linux, on these devices: 

```
# echo "deb [arch=armhf] https://download.docker.com/linux/debian $(lsb_release -cs) stable" |\
  sudo tee /etc/apt/sources.list.d/docker.list
# curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
# sudo apt update
# sudo apt -y install docker-ce
```
