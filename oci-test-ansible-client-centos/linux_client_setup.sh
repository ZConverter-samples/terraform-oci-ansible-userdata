#!/bin/bash
touch /home/opc/test
echo "Enter the Private key" | tee /home/opc/test
chmod 600 /home/opc/test
myip=$(curl ifconfig.me)
sudo systemctl start sshd
scp -o StrictHostKeyChecking=no -i /home/opc/test -r ubuntu@192.168.0.123:/tmp/hosts/linux.yaml /tmp/linux.yaml
sed -i'' -r -e "/"hosts"/a \\                $myip:\n                        ansible_ssh_user: opc\n" /tmp/linux.yaml
scp -o StrictHostKeyChecking=no -i /home/opc/test -r /tmp/linux.yaml ubuntu@192.168.0.123:/tmp/hosts/linux.yaml
rm -f /tmp/linux.yaml
rm -f /home/opc/test