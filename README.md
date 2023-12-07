# kexueshangwang
开启BBR 
apt update -y 
echo net.core.default_qdisc=fq >> /etc/sysctl.conf 
echo net.ipv4.tcp_congestion_control=bbr >> /etc/sysctl.conf 
sysctl -p 

检查是否开启成功 
lsmod | grep bbr 

运行install_trojan.sh之前，先运行下面去除Windows的换行符 
sed -i 's/\r//' install_trojan.sh 

