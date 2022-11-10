# Terraform-oci-ansible-userdata
Building an ansible env using terraform on OCI

> Before you begin
> 
> Prepare
> 
> Excute install script

## Before you begin

* <span style="background:white"><span style="color:black">All of the terraform process is carried out referring to [THIS](https://github.com/ZConverter-samples/terraform-oci-create-instnace-modules)</span></span>

## Prepare

Prepare the info needed to run the script.

### Create API-Key
   If you created API keys for the Terraform Set Up Resource Discovery tutorial, then skip this step.

   Create RSA keys for API signing into your **Oracle Cloud Infrastructure account**.

   **1. Log in to the Oracle Cloud site and access the user portal.**

   ![Login](https://raw.githubusercontent.com/ZConverter-samples/terraform-oci-create-instnace-modules/images/images/login.png)  

   **2. Enter the User menu.**

   ![Account User](https://raw.githubusercontent.com/ZConverter-samples/terraform-oci-create-instnace-modules/images/images/user_account.png)  

   **3. Choice User Account Name to use.**

   ![Account Users](https://raw.githubusercontent.com/ZConverter-samples/terraform-oci-create-instnace-modules/images/images/user_account_choice.png)

   **4. Click api-key in the lower left resource and click add api key**

   ![Api-Key](https://raw.githubusercontent.com/ZConverter-samples/terraform-oci-create-instnace-modules/images/images/api_key_add.png)

   **5. Under API Key Pairing, click Download Private Key and Download Public Key, and then click the Add button. If there are more than three API Key, Delete API Key or use another User Account Name.**

   ![Api-Key](https://raw.githubusercontent.com/ZConverter-samples/terraform-oci-create-instnace-modules/images/images/api_key_download_key_file.png)

   **7. Copy the results from Configuration File Preview onto the notepad.**

   ![Configuration](https://raw.githubusercontent.com/ZConverter-samples/terraform-oci-create-instnace-modules/images/images/api_key_copy.png)
   
   **8. Select Networking from the menu, then select Virtual Cloud Networks**

   ![Networking-Virtual Cloud Network](https://raw.githubusercontent.com/ZConverter-samples/terraform-oci-create-instnace-modules/images/images/click_vcn.png)
   
   **9. Choice VCN User Account Name to use**

   ![Select VCM User Account Name](https://raw.githubusercontent.com/zconverter/ZCM-Baisc/master/image/oci_terraform/click_vcn_zcon.png)

   **10. Choice Subnets Name to use**

   ![Select Subnets Name](https://raw.githubusercontent.com/ZConverter-samples/terraform-oci-create-instnace-modules/images/images/click_subnet.png)

   **11. Copy the Subnet OCID onto the notepad**

   ![Subnet OCID](https://raw.githubusercontent.com/ZConverter-samples/terraform-oci-create-instnace-modules/images/images/copy_subnet_ocid.png)
  
   **12. Copy your public/private key pair onto the notepad**
   
   For access your ansible server, Copy key pair onto the notepad.

   **13. Result**

   ![Result](https://user-images.githubusercontent.com/85214181/200978297-2127d0a5-f5a9-4130-a9c6-63e57dce2acb.png)

### Replace your authenticaation info to a Terraform variable file
* The file we need to change is below
* All file paths are relative paths starting with ```terraform-oci-ansible-userdata```.

**1. Server**

   ***[./oci-ansible-server/oci_terraform_ansible_server.json](https://github.com/ZConverter-samples/terraform-oci-ansible-userdata/blob/main/oci-ansible-server/oci_terraform_ansible_server.json)***

   Modify the contents of ```"ssh_public_keys"``` to the value of the ```public_key``` you own.

     {
         "generate" : {
             "cloud_platform" : "oci",
             "provider" : {
     ...
             "vm_info" : {
                 "vm_name" : "ansible-test-server",
                 "compartment_ocid" : null,
                 "OS" : {
                     "OS_name" : "Canonical Ubuntu",
                     "OS_version" : "18.04"
                 },
                 "instance_type" : {
                     "instance_type_name" : "VM.Standard.E4.Flex",
                     "instance_cpus" : 2,
                     "instance_memory_in_gbs" : 4
                 },
                 "ssh_public_keys" : {
                     "ssh_public_key" : "",
                     "ssh_public_key_file" : null
                 },
                 "network_interface" : {
                     "subnet_ocid" : "ocid1.subnet.oc1.~~~~",
                     "create_security_group_rules" : [
     ...
     }
    
   ***[./oci-ansible-server/server_setup.sh](https://github.com/ZConverter-samples/terraform-oci-ansible-userdata/blob/main/oci-ansible-server/server_setup.sh)***
   
   In the code below, type your ```private-key``` in the ```"Enter the private-key"```.

   ```
   #!/bin/bash
   touch /home/ubuntu/.ssh/id_rsa
   echo "Enter the private-key" | tee /home/ubuntu/.ssh/id_rsa
   chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
   chmod 600 /home/ubuntu/.ssh/id_rsa
   mkdir /tmp/hosts
   ...
   ```

**2. Client-linux**
   
   ***[./oci-ansible-client-centos/oci_terraform_ansible_client_CentOS.json](https://github.com/ZConverter-samples/terraform-oci-ansible-userdata/blob/main/oci-ansible-client-centos/oci_terraform_ansible_client_CentOS.json)***

   Modify the content of the syntax ```"ssh_public_keys"``` to its own ```public_key``` value, as in the ```oci_terraform_ansible_server.json``` file on the server.

   ```
   {
      "generate" : {
         "cloud_platform" : "oci",
         "provider" : {
   ...
         "vm_info" : {
               "vm_name" : "ansible-test-client",
               "compartment_ocid" : null,
               "OS" : {
                  "OS_name" : "CentOS",
                  "OS_version" : "7"
               },
               "instance_type" : {
                  "instance_type_name" : "VM.Standard.E4.Flex",
                  "instance_cpus" : 2,
                  "instance_memory_in_gbs" : 4
               },
               "ssh_public_keys" : {
                  "ssh_public_key" : "",
                  "ssh_public_key_file" : null
               },
               "network_interface" : {
                  "subnet_ocid" : "ocid1.subnet.oc1.~~~~",
                  "create_security_group_rules" : [
   ...
   }
   ```

   ***[./oci-ansible-client-centos/linux_client_setup.sh](https://github.com/ZConverter-samples/terraform-oci-ansible-userdata/blob/main/oci-ansible-client-centos/linux_client_setup.sh)***

   Enter your own ```Private-key``` in the ```"Enter the Private key"``` part of the code below.

   ```
   #!/bin/bash
   touch /home/opc/test
   echo "Enter the Private key" | tee /home/opc/test
   chmod 600 /home/opc/test
   myip=$(curl ifconfig.me)
   ...
   ```

**3. Client-windows**

   The Windows client only need to modify the ```.json``` file.

   ***[./oci-ansible-client-windows/oci_terraform_ansible_client_Windows.json](https://github.com/ZConverter-samples/terraform-oci-ansible-userdata/blob/main/oci-ansible-client-windows/oci_terraform_ansible_client_Windows.json)***

   In the code below, modify the ```"ssh_public_keys"``` syntax to its own ```public_key``` value.

   ```
   {
      "generate" : {
         "cloud_platform" : "oci",
         "provider" : {
   ...
         "vm_info" : {
               "vm_name" : "ansible-test-client",
               "compartment_ocid" : null,
               "OS" : {
                  "OS_name" : "Windows",
                  "OS_version" : "Server 2019 Standard"
               },
               "instance_type" : {
                  "instance_type_name" : "VM.Standard.E4.Flex",
                  "instance_cpus" : 2,
                  "instance_memory_in_gbs" : 4
               },
               "ssh_public_keys" : {
                  "ssh_public_key" : "",
                  "ssh_public_key_file" : null
               },
               "network_interface" : {
                  "subnet_ocid" : "ocid1.subnet.oc1.~~~~",
                  "create_security_group_rules" : [
   ...
   }
   ```

## Excute install script

* You must navigate to the directory ```terraform-oci-ansible-userdata``` to run the installation script.
* The installation script is for Windows ```.ps1(powershell)``` and for Linux ```.sh```.

# Windows
* <span style="background:white"><span style="color:black">The terraform.exe file is required in the directory ```terraform-oci-ansible-userdata``` You can download this file from the tab [here](https://www.terraform.io/downloads).</span></span>

# **Create instance**

Powershell script execution command.
```
powershell.exe -ExecutionPolicy ByPass -File .\install.ps1 apply -Verbose
```
![Windows_apply](https://user-images.githubusercontent.com/85214181/200990683-f296452c-8469-4cf9-b42f-472c180965fd.png)

Enter credentials after selection 4 for initial setup.

* ***Must add "" (big quotation marks) when typing.***

![Initial setup](https://user-images.githubusercontent.com/85214181/201005638-9a19c5b9-eed1-4bf4-945d-6042baa7aaa9.png)

Create a server instance after entering credentials.

![Install server](https://user-images.githubusercontent.com/85214181/201006403-78c09744-d0fb-464c-8e0e-0d2ed669306e.png)

Copy public_ip output after instance creation.

![Apply server result](https://user-images.githubusercontent.com/85214181/201011335-4cc6a61f-e736-4e30-968d-dec264e2c544.png)


Installing client instances (Windows, Linux courses are the same).

* Enter the copied public_ip value after installing the server.

![Apply client_instance](https://user-images.githubusercontent.com/85214181/201011449-7d197d75-cf15-40a1-bb50-70f2c4eda781.png)

Connecting instances that you create.

* Access is possible with a private_key pair that matches the entered ```public_key```.

<img width="575" alt="Connect inatnace" src="https://user-images.githubusercontent.com/85214181/201013174-d3d73a8e-6eff-4e2e-9cfd-2098f12b2b83.png">

Ansible host file is located in the path below.
```
/tmp/hosts/
```
<img width="295" alt="Host files" src="https://user-images.githubusercontent.com/85214181/201013696-916a04bc-f9d7-46f6-9a94-dc6198dc442c.png">

<space></space>

# **Delete instance**

```
powershell.exe -ExecutionPolicy ByPass -File .\install.ps1 destroy -Verbose
```
![Destroy instance](https://user-images.githubusercontent.com/85214181/201012588-df2b9305-68f6-4b8c-a5b2-2bc192fc40e9.png)

Enter the instance number you want to delete.

<space></space>

# Linux
* <span style="background:white"><span style="color:black">Terraform installation is required to proceed with this process. Terraform could be installed [here](https://www.terraform.io/downloads).</span></span>

Create instance commands on linux(in the directory ```terraform-oci-ansible-userdata```).
```
./install.sh apply
```
Dreate instance commands on linux(in the directory ```terraform-oci-ansible-userdata```).
```
./install.sh destroy
```
<space></space>

### Subsequent processes are the same as creating a Windows instance.