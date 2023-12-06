#! /bin/bash

apt update -y

apt -y install git vim gettext build-essential autoconf libtool libpcre3-dev libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev

cd /usr/local/src

wget https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.3.5/shadowsocks-libev-3.3.5.tar.gz

tar -zxf shadowsocks-libev-3.3.5.tar.gz

cd shadowsocks-libev-3.3.5

./configure --disable-documentation

make

make install

mkdir /etc/shadowsocks-libev && cd /etc/shadowsocks-libev

cat>/etc/shadowsocks-libev/config.json<<EOF
{
    "server":"0.0.0.0",
    "server_port":8388,
    "password":"huangle",
    "timeout":300,
    "method":"aes-256-gcm",
    "nameserver":"8.8.8.8",
    "fast_open":false,
    "mode":"tcp_and_udp"
}
EOF

cd /etc/systemd/system

cat>/etc/systemd/system/shadowsocks-libev.service<<EOF
[Unit]
Description=Shadowsocks-libev
After=network.target

[Service]
Type=simple
User=nobody
ExecStart=/usr/local/bin/ss-server -c /etc/shadowsocks-libev/config.json

[Install]
WantedBy=multi-user.target
EOF
