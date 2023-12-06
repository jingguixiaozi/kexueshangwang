#! /bin/bash

apt update -y

apt install -y curl wget zip

curl https://get.acme.sh | sh
apt install socat
ln -s  /root/.acme.sh/acme.sh /usr/local/bin/acme.sh
acme.sh --register-account -m jingguixiaozi@gmail.com
ufw allow 80 

read -p "输入域名" yuming

acme.sh  --issue -d $yuming --standalone -k ec-256

mkdir /root/trojan

acme.sh --installcert -d $yuming --ecc  --key-file   /root/trojan/server.key   --fullchain-file /root/trojan/server.crt 

acme.sh --upgrade --auto-upgrade

cd /root/trojan

wget https://github.com/p4gefau1t/trojan-go/releases/download/v0.10.6/trojan-go-linux-amd64.zip

unzip /root/trojan/trojan-go-linux-amd64.zip

cat>/root/trojan/config.json<<EOF
{
    "run_type": "server",
    "local_addr": "[::]",
    "local_port": 443,
    "remote_addr": "192.83.167.78",
    "remote_port": 80,
    "password": [
        "huangle"
    ],
    "ssl": {
        "cert": "/root/trojan/server.crt",
        "key": "/root/trojan/server.key"
    }
}
EOF

nohup ./trojan-go >trojan.log 2>&1 &