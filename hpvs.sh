apt install wget git -y

wget -q https://raw.githubusercontent.com/linux-on-ibm-z/scripts/master/Go/1.17.5/build_go.sh

bash build_go.sh

git clone https://github.com/XTLS/Xray-core.git

cd Xray-core

CGO_ENABLED=0 go build -o xray -trimpath -ldflags "-s -w -buildid=" ./main

mv xray /usr/local/bin/

cd ~

git clone https://github.com/cloudflare/cloudflared.git

cd cloudflared

go build -v -mod=vendor ./cmd/cloudflared

mv cloudflared /usr/local/bin/

cd ~

echo -e '{"log":{"access":"none"},"inbounds":[{"port":8080,"protocol":"vless","settings":{"decryption":"none","clients":[{"id":"18ad2c9c-a88b-48e8-aa64-5dee0045c282"}]},"streamSettings":{"network":"ws","wsSettings":{"path":"ws"}}}],"outbounds":[{"protocol":"freedom","settings":{}}]}' > config.json

cat > /etc/systemd/system/xray.service << EOF
[Unit]
Description=Xray Service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/xray -config=/root/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/cloudflared.service << EOF
[Unit]
Description=Cloudflare Tunnel
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/cloudflared tunnel
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

sysctl -w net.core.rmem_max=2500000

systemctl enable xray
systemctl start xray
systemctl enable cloudflared
systemctl start cloudflared

exit 0
