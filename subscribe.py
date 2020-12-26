import base64
import json


config = {
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
}

print base64.urlsafe_b64encode(
    "vmess://" + base64.urlsafe_b64encode(json.dumps(config).encode()).decode()
).decode()
