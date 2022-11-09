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
        terraform -chdir=oci-ansible-server/ destroy -var-file=oci_terraform_ansible_server.json -auto-approve
        rm -rf ./oci-ansible-server/terraform.tfstate
    elif [ $num -eq 2 ]; then
        terraform -chdir=oci-ansible-client-centos/ destroy -var-file=oci_terraform_ansible_client_CentOS.json -auto-approve
        rm -rf ./oci-ansible-client-centos/terraform.tfstate
    elif [ $num -eq 3 ]; then
        terraform -chdir=oci-ansible-client-windows/ destroy -var-file=oci_terraform_ansible_client_Windows.json -auto-approve
        rm -rf ./oci-ansible-client-windows/terraform.tfstate
    else
        echo "Wrong number"
    fi

elif [ "$1" == "apply" ]; then
    echo "Apply instance
    ---------------------------------------
    1. Server
    2. Linux client
    3. Windows client
    4. Initial etup
    ---------------------------------------"
    read -p "Select number: " num

    if [ $num -eq 1 ]; then
        terraform -chdir=oci-ansible-server/ init
        terraform -chdir=oci-ansible-server/ apply -var-file=oci_terraform_ansible_server.json -auto-approve
    elif [ $num -eq 2 ]; then
        read -p "Enter the server ip: " ip
        sed -i -r 's/((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])/'$ip'/g' ./oci-ansible-client-centos/linux_client_setup.sh
        terraform -chdir=oci-ansible-client-centos/ init
        terraform -chdir=oci-ansible-client-centos/ apply -var-file=oci_terraform_ansible_client_CentOS.json -auto-approve
    elif [ $num -eq 3 ]; then
        read -p "Enter the server ip: " ip
        sed -i -r 's/((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])/'$ip'/g' ./oci-ansible-client-windows/windows_client_setup.ps1
        terraform -chdir=oci-ansible-client-windows/ init
        terraform -chdir=oci-ansible-client-windows/ apply -var-file=oci_terraform_ansible_client_Windows.json -auto-approve
    elif [ $num -eq 4 ]; then
        read -p "Enter the tenancy_ocid: " tenancy_ocid
        sed -i -r 's/"tenancy_ocid" : "ocid1.tenancy.oc1..~~~~"/"tenancy_ocid" : '$tenancy_ocid'/g' ./oci-ansible-server/oci_terraform_ansible_server.json
        sed -i -r 's/"tenancy_ocid" : "ocid1.tenancy.oc1..~~~~"/"tenancy_ocid" : '$tenancy_ocid'/g' ./oci-ansible-client-centos/oci_terraform_ansible_client_CentOS.json
        sed -i -r 's/"tenancy_ocid" : "ocid1.tenancy.oc1..~~~~"/"tenancy_ocid" : '$tenancy_ocid'/g' ./oci-ansible-client-windows/oci_terraform_ansible_client_Windows.json
        read -p "Enter the user_ocid: " user_ocid
        sed -i -r 's/"user_ocid" : "ocid1.user.oc1..~~~~"/"user_ocid" : '$user_ocid'/g' ./oci-ansible-server/oci_terraform_ansible_server.json
        sed -i -r 's/"user_ocid" : "ocid1.user.oc1..~~~~"/"user_ocid" : '$user_ocid'/g' ./oci-ansible-client-centos/oci_terraform_ansible_client_CentOS.json
        sed -i -r 's/"user_ocid" : "ocid1.user.oc1..~~~~"/"user_ocid" : '$user_ocid'/g' ./oci-ansible-client-windows/oci_terraform_ansible_client_Windows.json
        read -p "Enter the fingerprint: " fingerprint
        sed -i -r 's/"fingerprint" : "~~~~"/"fingerprint" : '$fingerprint'/g' ./oci-ansible-server/oci_terraform_ansible_server.json
        sed -i -r 's/"fingerprint" : "~~~~"/"fingerprint" : '$fingerprint'/g' ./oci-ansible-client-centos/oci_terraform_ansible_client_CentOS.json
        sed -i -r 's/"fingerprint" : "~~~~"/"fingerprint" : '$fingerprint'/g' ./oci-ansible-client-windows/oci_terraform_ansible_client_Windows.json
        read -p "Enter the region: " region
        sed -i -r 's/"region" : "ap-seoul-1"/"region" : '$region'/g' ./oci-ansible-server/oci_terraform_ansible_server.json
        sed -i -r 's/"region" : "ap-seoul-1"/"region" : '$region'/g' ./oci-ansible-client-centos/oci_terraform_ansible_client_CentOS.json
        sed -i -r 's/"region" : "ap-seoul-1"/"region" : '$region'/g' ./oci-ansible-client-windows/oci_terraform_ansible_client_Windows.json
        read -p "Enter the private_key_path(relative path): " private_key_path
        sed -i -r 's%"private_key_path" : "./~~~~"%"private_key_path" : '$private_key_path'%g' ./oci-ansible-server/oci_terraform_ansible_server.json
        sed -i -r 's%"private_key_path" : "./~~~~"%"private_key_path" : '$private_key_path'%g' ./oci-ansible-client-centos/oci_terraform_ansible_client_CentOS.json
        sed -i -r 's%"private_key_path" : "./~~~~"%"private_key_path" : '$private_key_path'%g' ./oci-ansible-client-windows/oci_terraform_ansible_client_Windows.json
        read -p "Enter the subnet_ocid: " subnet_ocid
        sed -i -r 's/"subnet_ocid" : "ocid1.subnet.oc1.~~~~"/"subnet_ocid" : '$subnet_ocid'/g' ./oci-ansible-server/oci_terraform_ansible_server.json
        sed -i -r 's/"subnet_ocid" : "ocid1.subnet.oc1.~~~~"/"subnet_ocid" : '$subnet_ocid'/g' ./oci-ansible-client-centos/oci_terraform_ansible_client_CentOS.json
        sed -i -r 's/"subnet_ocid" : "ocid1.subnet.oc1.~~~~"/"subnet_ocid" : '$subnet_ocid'/g' ./oci-ansible-client-windows/oci_terraform_ansible_client_Windows.json
    else
        echo "Wrong number"
    fi
else
    echo "Wrong option entered. Try like 'install.sh (apply/destroy)'"
fi