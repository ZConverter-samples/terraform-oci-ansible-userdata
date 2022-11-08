#!/bin/bash
if [ "$1" == "destroy" ]; then
    echo "Destroy instance
    ---------------------------------------
    1. Server
    2. Linux client
    3. Windows client
    ---------------------------------------"
    read -p "Select number: " num
    if [ $num -eq 1 ]; then
        terraform -chdir=oci-test-ansible-server/ destroy -var-file=oci_terraform_ansible_server.json -auto-approve
    elif [ $num -eq 2 ]; then
        terraform -chdir=oci-test-ansible-client-centos/ destroy -var-file=oci_terraform_ansible_client_CentOS.json -auto-approve
    elif [ $num -eq 3 ]; then
        terraform -chdir=oci-test-ansible-client-windows/ destroy -var-file=oci_terraform_ansible_client_Windows.json -auto-approve
    else
        echo "Wrong number"
    fi

elif [ "$1" == "apply" ]; then
    echo "Apply instance
    ---------------------------------------
    1. Server
    2. Linux client
    3. Windows client
    ---------------------------------------"
    read -p "Select number: " num

    if [ $num -eq 1 ]; then
        terraform -chdir=oci-test-ansible-server/ init
        terraform -chdir=oci-test-ansible-server/ apply -var-file=oci_terraform_ansible_server.json -auto-approve
    elif [ $num -eq 2 ]; then
        read -p "Enter the server ip: " ip
        sed -r 's/((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])/$ip/g ./oci-test-ansible-client-centos/linux_client_setup.sh'
        terraform -chdir=oci-test-ansible-client-centos/ init
        terraform -chdir=oci-test-ansible-client-centos/ apply -var-file=oci_terraform_ansible_client_CentOS.json -auto-approve
    elif [ $num -eq 3 ]; then
        read -p "Enter the server ip: " ip
        sed -r 's/((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])/$ip/g ./oci-test-ansible-client-windows/windows_client_setup.ps1'
        terraform -chdir=oci-test-ansible-client-windows/ init
        terraform -chdir=oci-test-ansible-client-windows/ apply -var-file=oci_terraform_ansible_client_Windows.json -auto-approve
    else
        echo "Wrong number"
    fi
else
    echo "Wrong option entered. Try like 'install.sh (apply/destroy)'"
fi