PUB_IP=`aws ec2 describe-instances --filters Name=tag:Name,Values=tf-instance --region ap-southeast-1 | grep 'PublicIpAddress' | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])'`
echo $PUB_IP
cat <<EOF > ../ansible-plays/inventory.ini
[all:vars]
ansible_ssh_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/spring-petclinic.pem
ansible_connection=ssh
ansible_user=ubuntu
ansible_sudo=true
ansible_become=true

[docker]
$PUB_IP
EOF
