apt install wget git -y

wget -q https://raw.githubusercontent.com/linux-on-ibm-z/scripts/master/Go/1.16.5/build_go.sh

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

nohup xray -config=./config.json &

wget https://github.com/zhu327/v2ray-kubernetes/raw/master/cloudflare.tar.gz

tar zxvf cloudflare.tar.gz

nohup /usr/local/bin/cloudflared tunnel run xray &

exit 0
