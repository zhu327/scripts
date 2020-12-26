pod_name=$(kubectl get pods|awk 'END{print $1}')

domain=$(kubectl logs $pod_name -c tunnel|grep trycloudflare.com|awk 'END{print $3}'|awk -F/ '{print $3}')

sed -i "s/v2ray_host/$domain/g" ./cf/index.js

ip=$(ibmcloud ks worker ls --cluster $IKS_CLUSTER|awk 'END{print $2}')

echo -e "$ip\n$domain" > ip.txt

config=$(cat <<EOF
{
  "v": "2",
  "ps": "ibm",
  "add": "$ip",
  "port": "30080",
  "id": "18ad2c9c-a88b-48e8-aa64-5dee0045c282",
  "aid": "0",
  "net": "kcp",
  "type": "wechat-video",
  "host": "",
  "path": "",
  "tls": ""
}
EOF
)

if [ -f "subscription.txt" ];then
  rm subscription.txt
fi

echo -e "vmess://$(echo -e "$config" |base64 -w 0)"|base64 -w 0 > subscription.txt

git add subscription.txt
git commit -m "update subscription"