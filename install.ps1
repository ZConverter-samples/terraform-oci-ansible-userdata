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
        .\terraform.exe -chdir=oci-test-ansible-server/ destroy --var-file=oci_terraform_ansible_server.json -auto-approve
    }
    elseif ( $num -eq 2 )
    {
        .\terraform.exe -chdir=oci-test-ansible-client-centos/ destroy --var-file=oci_terraform_ansible_client_CentOS.json -auto-approve
    }
    elseif ( $num -eq 3 )
    {
        .\terraform.exe -chdir=oci-test-ansible-client-windows/ destroy --var-file=oci_terraform_ansible_client_Windows.json -auto-approve
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
    ---------------------------------------"
    $num = Read-Host "Select number: "

    if ( $num -eq 1 )
    {
        .\terraform.exe -chdir=oci-test-ansible-server/ init
        .\terraform.exe -chdir=oci-test-ansible-server/ apply --var-file=oci_terraform_ansible_server.json -auto-approve
    }
    elseif ( $num -eq 2 )
    {
        # Server IP
        $IP = Read-Host "Enter the server ip: "
        (Get-Content .\oci-test-ansible-client-centos\linux_client_setup.sh) | ForEach-Object{$_ -Replace ('(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5]).', $IP)} | Set-Content .\oci-test-ansible-client-centos\linux_client_setup.sh -Encoding ascii
        # Excute
        .\terraform.exe -chdir=oci-test-ansible-client-centos/ init
        .\terraform.exe -chdir=oci-test-ansible-client-centos/ apply --var-file=oci_terraform_ansible_client_CentOS.json -auto-approve
    }
    elseif ( $num -eq 3 )
    {
        # Server IP
        $IP = Read-Host "Enter the server ip: "
        (Get-Content .\oci-test-ansible-client-windows\windows_client_setup.ps1) | ForEach-Object{$_ -Replace ('(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5]).', $IP)} | Set-Content .\oci-test-ansible-client-windows\windows_client_setup.ps1 -Encoding ascii
        # Excute
        .\terraform.exe -chdir=oci-test-ansible-client-windows/ init
        .\terraform.exe -chdir=oci-test-ansible-client-windows/ apply --var-file=oci_terraform_ansible_client_Windows.json -auto-approve
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