apt-get update; apt-get -y upgrade; apt-get -y dist-upgrade; apt-get -y autoremove; apt-get -y autoclean
apt-get -y install build-essential ifstat screen htop autoconf automake libjansson-dev libgmp-dev libcurl4-openssl-dev libssl-dev git
git clone https://github.com/magi-project/wolf-m7m-cpuminer-V2.git; cd wolf-m7m-cpuminer-V2
perl -pi -e "s/\-flto//g" *; cd m7; perl -pi -e "s/\-flto//g" *; cd ..
./autogen.sh; ./configure; make
screen
./minerd -a m7mhash -o stratum+tcp://xmg.minerclaim.net:3333 -u 0x03.one -p one
