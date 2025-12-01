[lamp_servers]
%{ for server in lamp_servers ~}
${server.name} ansible_host=${server.ip} ansible_user=root ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p root@${nat_ip}"'
%{ endfor ~}

[lamp_servers:vars]
nat_ip=${nat_ip}