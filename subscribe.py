import base64
import json


configs = [{
    "v": "2",
    "ps": "ibm",
    "add": "v2ray_ip",
    "port": "30080",
    "id": "18ad2c9c-a88b-48e8-aa64-5dee0045c282",
    "aid": "0",
    "net": "kcp",
    "type": "wechat-video",
    "host": "",
    "path": "",
    "tls": ""
}, {
    "v": "2",
    "ps": "cf",
    "add": "v2ray_host",
    "port": "443",
    "id": "18ad2c9c-a88b-48e8-aa64-5dee0045c282",
    "aid": "0",
    "net": "ws",
    "type": "none",
    "host": "v2ray_host",
    "path": "ws",
    "tls": "tls"
}]

urls = []

for conf in configs:
    urls.append("vmess://" + base64.urlsafe_b64encode(json.dumps(conf).encode()).decode())

print base64.urlsafe_b64encode("\n".join(urls)).decode()
