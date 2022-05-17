PUB_IP=`aws ec2 describe-instances --filters Name=tag:Name,Values=tf-instance --region ap-southeast-1 | grep "PublicIpAddress" | awk '{print $2}' | sed 's/"//g' | sed 's/,//g'`
echo $PUB_IP
ANS=/var/lib/jenkins/workspace/terraform-ansible-prov-conf/Deliverables/ansible-plays/
echo 'creating inventory.ini...' > $ANS/inventory.ini
cat <<EOF > $ANS/inventory.ini
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
