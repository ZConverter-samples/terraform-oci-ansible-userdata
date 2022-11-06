#!/bin/bash
touch /home/ubuntu/.ssh/id_rsa
echo "Enter the private-key" | tee /home/ubuntu/.ssh/id_rsa
chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
chmod 600 /home/ubuntu/.ssh/id_rsa
mkdir /tmp/hosts
# Ansible linux hosts file
touch /tmp/hosts/linux.yaml
echo 'linux:
        hosts:' | tee /tmp/hosts/linux.yaml
# Ansible windows hosts file
touch /tmp/hosts/windows.yaml
echo 'windows:
        hosts:' | tee /tmp/hosts/windows.yaml
# Ansible install
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible-3
sudo apt install ansible -y
# Samba install
sudo apt install -y samba && sudo apt install -y python3-winrm
sudo chmod 777 /tmp/hosts
sudo chmod 666 /tmp/hosts/linux.yaml
sudo chmod 666 /tmp/hosts/windows.yaml
echo -e 'Dc7kQy]W2NFo\nDc7kQy]W2NFo' | sudo smbpasswd -a -s ubuntu
echo '[share]
comment = share
path = /tmp/hosts
public = yes
writable = yes
printable = no 
write list = ubuntu
create mask = 0777
directory mask = 0777' | sudo tee -a /etc/samba/smb.conf
sudo systemctl restart smbd
ufw disable
iptables -F