if ($args[0] -like "destroy")
{
    Write-Output "Destroy instance
    ---------------------------------------
    1. Server
    2. Linux client
    3. Windows client
    ---------------------------------------"
    $num = Read-Host "Select number: "
    if ( $num -eq 1 )
    {
        .\terraform.exe -chdir=oci-ansible-server/ destroy --var-file=oci_terraform_ansible_server.json -auto-approve
        rm -Recurse -Force .\oci-ansible-server/terraform.tfstate
    }
    elseif ( $num -eq 2 )
    {
        .\terraform.exe -chdir=oci-ansible-client-centos/ destroy --var-file=oci_terraform_ansible_client_CentOS.json -auto-approve
        rm -Recurse -Force .\oci-ansible-client-centos/terraform.tfstate
    }
    elseif ( $num -eq 3 )
    {
        .\terraform.exe -chdir=oci-ansible-client-windows/ destroy --var-file=oci_terraform_ansible_client_Windows.json -auto-approve
        rm -Recurse -Force .\oci-ansible-client-windows/terraform.tfstate
    }
    else
    {
        Write-Output "Wrong number"
    }
}
elseif ($args[0] -like "apply")
{    
    Write-Output "Apply instance
    ---------------------------------------
    1. Server
    2. Linux client
    3. Windows client
    4. Initial setup
    ---------------------------------------"
    $num = Read-Host "Select number: "

    if ( $num -eq 1 )
    {
        .\terraform.exe -chdir=oci-ansible-server/ init
        .\terraform.exe -chdir=oci-ansible-server/ apply --var-file=oci_terraform_ansible_server.json -auto-approve
    }
    elseif ( $num -eq 2 )
    {
        # Server IP
        $IP = Read-Host "Enter the server ip: "
        (Get-Content .\oci-ansible-client-centos\linux_client_setup.sh) | ForEach-Object{$_ -Replace ('(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)', $IP)} | Set-Content .\oci-ansible-client-centos\linux_client_setup.sh -Encoding ascii
        # Excute
        .\terraform.exe -chdir=oci-ansible-client-centos/ init
        .\terraform.exe -chdir=oci-ansible-client-centos/ apply --var-file=oci_terraform_ansible_client_CentOS.json -auto-approve
    }
    elseif ( $num -eq 3 )
    {
        # Server IP
        $IP = Read-Host "Enter the server ip: "
        (Get-Content .\oci-ansible-client-windows\windows_client_setup.ps1) | ForEach-Object{$_ -Replace ('(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)', $IP)} | Set-Content .\oci-ansible-client-windows\windows_client_setup.ps1 -Encoding ascii
        # Excute
        .\terraform.exe -chdir=oci-ansible-client-windows/ init
        .\terraform.exe -chdir=oci-ansible-client-windows/ apply --var-file=oci_terraform_ansible_client_Windows.json -auto-approve
    }
    elseif ( $num -eq 4 )
    {
        $tenancy_ocid = Read-Host "Enter the tenancy_ocid "
        (Get-Content .\oci-ansible-server\oci_terraform_ansible_server.json) | ForEach-Object{$_ -Replace ('"tenancy_ocid" : "ocid1.tenancy.oc1..~~~~"', (Write-Output '"tenancy_ocid" : '$tenancy_ocid))} | Set-Content .\oci-ansible-server\oci_terraform_ansible_server.json -Encoding ascii
        (Get-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json) | ForEach-Object{$_ -Replace ('"tenancy_ocid" : "ocid1.tenancy.oc1..~~~~"', (Write-Output '"tenancy_ocid" : '$tenancy_ocid))} | Set-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json -Encoding ascii
        (Get-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json) | ForEach-Object{$_ -Replace ('"tenancy_ocid" : "ocid1.tenancy.oc1..~~~~"', (Write-Output '"tenancy_ocid" : '$tenancy_ocid))} | Set-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json -Encoding ascii
        $user_ocid = Read-Host "Enter the user_ocid "
        (Get-Content .\oci-ansible-server\oci_terraform_ansible_server.json) | ForEach-Object{$_ -Replace ('"user_ocid" : "ocid1.user.oc1..~~~~"', (Write-Output '"user_ocid" : '$user_ocid))} | Set-Content .\oci-ansible-server\oci_terraform_ansible_server.json -Encoding ascii
        (Get-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json) | ForEach-Object{$_ -Replace ('"user_ocid" : "ocid1.user.oc1..~~~~"', (Write-Output '"user_ocid" : '$user_ocid))} | Set-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json -Encoding ascii
        (Get-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json) | ForEach-Object{$_ -Replace ('"user_ocid" : "ocid1.user.oc1..~~~~"', (Write-Output '"user_ocid" : '$user_ocid))} | Set-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json -Encoding ascii
        $fingerprint = Read-Host "Enter the fingerprint "
        (Get-Content .\oci-ansible-server\oci_terraform_ansible_server.json) | ForEach-Object{$_ -Replace ('"fingerprint" : "~~~~"', (Write-Output '"fingerprint" : '$fingerprint))} | Set-Content .\oci-ansible-server\oci_terraform_ansible_server.json -Encoding ascii
        (Get-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json) | ForEach-Object{$_ -Replace ('"fingerprint" : "~~~~"', (Write-Output '"fingerprint" : '$fingerprint))} | Set-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json -Encoding ascii
        (Get-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json) | ForEach-Object{$_ -Replace ('"fingerprint" : "~~~~"', (Write-Output '"fingerprint" : '$fingerprint))}| Set-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json -Encoding ascii
        $region = Read-Host "Enter the region "
        (Get-Content .\oci-ansible-server\oci_terraform_ansible_server.json) | ForEach-Object{$_ -Replace ('"region" : "ap-seoul-1"', (Write-Output '"region" : '$region))} | Set-Content .\oci-ansible-server\oci_terraform_ansible_server.json -Encoding ascii
        (Get-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json) | ForEach-Object{$_ -Replace ('"region" : "ap-seoul-1"', (Write-Output '"region" : '$region))} | Set-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json -Encoding ascii
        (Get-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json) | ForEach-Object{$_ -Replace ('"region" : "ap-seoul-1"', (Write-Output '"region" : '$region))} | Set-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json -Encoding ascii
        $private_key_path = Read-Host "Enter the private_key_path(relative path) " 
        (Get-Content .\oci-ansible-server\oci_terraform_ansible_server.json) | ForEach-Object{$_ -Replace ('"private_key_path" : "./~~~~"', (Write-Output '"private_key_path" : '$private_key_path))} | Set-Content .\oci-ansible-server\oci_terraform_ansible_server.json -Encoding ascii
        (Get-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json) | ForEach-Object{$_ -Replace ('"private_key_path" : "./~~~~"', (Write-Output '"private_key_path" : '$private_key_path))} | Set-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json -Encoding ascii
        (Get-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json) | ForEach-Object{$_ -Replace ('"private_key_path" : "./~~~~"', (Write-Output '"private_key_path" : '$private_key_path))} | Set-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json -Encoding ascii
        $subnet_ocid = Read-Host "Enter the subnet_ocid "
        (Get-Content .\oci-ansible-server\oci_terraform_ansible_server.json) | ForEach-Object{$_ -Replace ('"subnet_ocid" : "ocid1.subnet.oc1.~~~~"', (Write-Output '"subnet_ocid" : '$subnet_ocid))} | Set-Content .\oci-ansible-server\oci_terraform_ansible_server.json -Encoding ascii
        (Get-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json) | ForEach-Object{$_ -Replace ('"subnet_ocid" : "ocid1.subnet.oc1.~~~~"', (Write-Output '"subnet_ocid" : '$subnet_ocid))} | Set-Content .\oci-ansible-client-centos\oci_terraform_ansible_client_CentOS.json -Encoding ascii
        (Get-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json) | ForEach-Object{$_ -Replace ('"subnet_ocid" : "ocid1.subnet.oc1.~~~~"', (Write-Output '"subnet_ocid" : '$subnet_ocid))} | Set-Content .\oci-ansible-client-windows\oci_terraform_ansible_client_Windows.json -Encoding ascii
    }
    else
    {
        Write-Output "Wrong number"
    }
}
else
{
    Write-Output "Wrong option entered. Try like 'install.sh (apply/destroy)'"
}