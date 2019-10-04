# V2Ray Kubernetes

## 致敬 & 变化

致敬，bclswl0827

## 概述

用于在 Openshift, IBM Cloud 等云服务上部署 V2Ray Vmess & Websocket。

**Openshift, IBM Cloud 等服务商为我们提供了免费的容器服务进行测试，我们不应该滥用它。正因如此，本项目不宜做为生产环境使用。**

**Openshift 的网络并不稳定，部署前请三思。**

## 镜像

 - DockerHub 的镜像：`infinicken/v2ray.openshift`。
 
## ENV 设定

### CONFIG_JSON

`CONFIG_JSON` > `服务端 Websocket 配置文件`。

## 注意

**出于安全考量，Openshift 配置 V2Ray 成功之后，请在 `Route` 一项中勾选 `Secure Route` 以实现 V2Ray Websocket + TLS。**

设定 ENV CONFIG_JSON 时，务必将配置文件的换行符 `\r\n` 变更为 `\n`，然后填入 ENV 。使用 Linux 的朋友可以忽略这一步。
