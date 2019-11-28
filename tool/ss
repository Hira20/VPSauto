#!/bin/bash
while [[ ! $sqx =~ Y|y|N|n ]]; do
	read -p "Allow anyone to use your squid? : [Y/y] [N/n] " sqx;done
if [[ ! `which docker` ]]; then
apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt-cache policy docker-ce
apt install docker-ce -y; fi
IP=$(wget -qO- ipv4.icanhazip.com)
DNUL="/dev/null"
CONFDIR="/etc/_configs"
GITMINE="https://raw.githubusercontent.com/X-DCB/SmartDNS-one/master"
docker service ls 2> $DNUL || docker swarm init --advertise-addr $IP
docker stack rm dnsx 2> $DNUL
spin='-\|/'
str='Removing possible errors...'
cnl='Cancelled.'
fin='Finished.'
trap 'printf "\b\b$cnl%$(( ${#str}-${#cnl}+1 ))s\n";exit' INT
while [[ `docker network ls | grep dnsx` ]]; do
i=$(( (i+1) %4 ))
printf "\b${str}${spin:$i:1} \r"
sleep .1
done
printf "\b\b$fin%$(( ${#str}-${#fin}+1 ))s\n"
mkdir $CONFDIR 2> $DNUL
wget https://raw.githubusercontent.com/X-DCB/netflix-proxy/master/docker-sniproxy/sniproxy.conf.template -qO $CONFDIR/sniproxy.conf
wget $GITMINE/dnsmasq.conf -qO $CONFDIR/dnsmasq.conf
wget https://raw.githubusercontent.com/Hira20/VPSauto/master/tool/squid.conf -qO $CONFDIR/squid.conf
wget $GITMINE/sni-dns.conf -qO $CONFDIR/sni-dns.conf
service squid stop 2> $DNUL
wget $GITMINE/docker.yaml -qO- | docker stack up -c - dnsx
docker service update $(docker service ls | grep squid | cut -d ' ' -f 1) --args $sqx
clear
echo "Smart DNS Squid successfully installed!"
sleep 2
