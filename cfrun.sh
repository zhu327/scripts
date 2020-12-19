pod_name=$(kubectl get pods|awk 'END{print $1}')

domain=$(kubectl logs $pod_name -c tunnel|grep trycloudflare.com|awk 'END{print $3}'|awk -F/ '{print $3}')

sed -i "s/v2ray_host/$domain/g" index.js
