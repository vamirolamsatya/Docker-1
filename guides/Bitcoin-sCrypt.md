# Software-RAID5, Docker, Bitcoin-sCrypt on a Raspberry Pi 3

## Prerequisites




### Building from source

```
apt-get update; apt-get -y upgrade; apt-get -y dist-upgrade
echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections
apt-get -y install ifstat iftop screen htop libboost-all-dev \
           software-properties-common python-software-properties \
           build-essential libssl-dev vim-tiny git aptitude \
           ubuntu-minimal net-tools wget
add-apt-repository -y ppa:bitcoin/bitcoin && apt-get update; apt-get -y install libdb4.8++-dev
useradd -m -d /home/bitcoin-scrypt -s /bin/bash bitcoin-scrypt
su - bitcoin-scrypt
mkdir bin src
cd src/; git clone https://github.com/bitcoin-scrypt/bitcoin-scrypt; cd bitcoin-scrypt/
make -f makefile.unix USE_UPNP=- USE_IPV6=1
cp bitcoin-scryptd ~/bin; strip ~/bin/bitcoin-scryptd
mkdir ~/.bitcoin-scrypt
cat <<EOF > ~/.bitcoin-scrypt/bitcoin-scrypt.conf
rpcuser=bitcoin-scrypt
rpcpassword=jyWn2q2LwBE8Hj19eDQEEwFvr0aPirj0oFxh8LUV30It
addnode=138.201.185.23:30201
addnode=65.102.140.115:30201
EOF
/home/bitcoin-scrypt/bin/bitcoin-scryptd -daemon
exit
aptitude markauto '~i!~nubuntu-minimal'
```


### Binary installation

```
apt-get update; apt-get -y upgrade; apt-get -y dist-upgrade && \
apt-get -y install libboost-system1.58.0 libboost-filesystem1.58.0 libboost-program-options1.58.0 libboost-thread1.58.0 software-properties-common python-software-properties git wget && \
add-apt-repository -y ppa:bitcoin/bitcoin && apt-get update; apt-get -y install libdb4.8++ && \
useradd -m -d /home/bitcoin-scrypt -s /bin/bash bitcoin-scrypt; su - bitcoin-scrypt 
mkdir bin; cd bin; wget -O bitcoin-scryptd https://github.com/BloodyNora/Bitcoin-sCrypt/raw/master/src/bitcoin-scryptd.armv7l; chmod +x bitcoin-scryptd
```
