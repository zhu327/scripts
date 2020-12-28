pod_name=$(kubectl get pods|awk 'END{print $1}')

domain=$(kubectl logs $pod_name -c tunnel|grep trycloudflare.com|awk 'END{print $3}'|awk -F/ '{print $3}')

sed -i "s/v2ray_host/$domain/g" ./cf/index.js

ip=$(ibmcloud ks worker ls --cluster $IKS_CLUSTER|awk 'NR==3{print $2}')

echo -e "$ip\n$domain" > ip.txt

sed -i "s/v2ray_ip/$ip/g" subscribe.py
sed -i "s/v2ray_host/$domain/g" subscribe.py

python2 subscribe.py > subscribe.txt
