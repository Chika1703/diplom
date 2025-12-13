[k8s-master]
nat ansible_host=${nat_public_ip} ansible_user=root ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[k8s-workers]
%{ for server in k8s_workers ~}
${server.name} ansible_host=${server.ip} ansible_user=root ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p root@${nat_public_ip}"'
%{ endfor ~}

[k8s-master:vars]
nat_ip=${nat_private_ip}

[all:vars]
pod_network_cidr=10.244.0.0/16
nat_ip=192.168.0.220
