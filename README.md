# Terraform-oci-ansible-userdata
Building an ansible env using terraform on OCI

> Before you begin
> 
> Prepare
> 
> Excute install script

## Diagram

![Architect](https://user-images.githubusercontent.com/85214181/201561979-843e88d9-3e28-44f4-88f9-04be9932b143.png)

## Before you begin

* <span style="background:white"><span style="color:black">All of the terraform process is based on [THIS](https://github.com/ZConverter-samples/terraform-oci-create-instnace-modules)</span></span>

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
  
   **12. Copy your ```public/private key pair``` onto the notepad**
   
   * For access your ansible server, Copy key pair onto the notepad.

   ------
   <span style="color:red">(Optional)</span> Create ```public/private key pair``` for create and access server instance**
   
   * It is not necessary to generate it because you already have a key pair (```test_key, test_key.ppk, test_key.pub```).

   Generate the key pair with command below.
   
   ```
   ssh-keygen -t rsa
   ```

   <img width="679" alt="ssh-keygen" src="https://user-images.githubusercontent.com/85214181/201563824-15f3dd21-4fa0-4a94-8584-f4f39d4f3b6d.png">

   Key pair list

   <img width="426" alt="ssh-key-list" src="https://user-images.githubusercontent.com/85214181/201571892-50cb5c39-840a-47a0-80f2-f1f48f115118.png">

   ------
   <space></space>

   ```Example private key```
   ```
   $ cat test_key
   ```
   ```
   -----BEGIN OPENSSH PRIVATE KEY-----
   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
   -----END OPENSSH PRIVATE KEY-----
   ```
   ```Example public key```
   ```
   $ cat test_key.pub
   ```
   ```
   ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDyw+yd7PsHIEKB5Bnr2J8NQBPzJtLTnEsU3TE4sfN7gFbZFRJA3bxLssmCgheqNdrguV4lc5nW4t1H42h8g+APYgBjLzXZ9tUt5J3eY8jg4NgHEt7tsx8wTXZ8FGQfjeUpJOurpy+fyWCOYw1FDhK3GMXzjB4POIzuaNHnFMuIfs6bIkJHi/PAEZVjE6nVEcR1KJLoPj056V7RAw4e0DPrk2QeVsLG7qY1hroo6ZYZF21j5M2tVGtoEXWzk+45BDFnBWrgCeKkw411NpYJ05rcRnIQLSwWZ+mi7B+8MXTaq5G81t2t7pQfX0FmTnHfd7hh02bXR21ccCwb7jz2SISynYoNKe8jd2P8/OBqAggZvC7X16DQJ5lJRbkQ/j9bpNRxfWyF+j9yzeopZ224eiptTP4vxWwUP3HYCHtDqvt7OeyUkeKvoo7R2SL2OCHZ+BSsa3QUc/BJLNkNzKYF/J0atzVKdCZmlGOJ6QrW4ND5hKOLwpBLKufZbwUuptFVnnk= jaeseong@sinjaescBookPro
   ```

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

* In order to run the script, you must enter a command withn the ```terraform-oci-ansible-userdata``` directory.
* The installation script is for Windows ```.ps1(powershell)``` and for Linux ```.sh```.

# Windows

* <span style="background:white"><span style="color:black">The terraform.exe file is required in the directory ```terraform-oci-ansible-userdata``` You can download this file from the tab [here](https://www.terraform.io/downloads).</span></span>

# **Create instance**

Powershell script execution command.

```
powershell.exe -ExecutionPolicy ByPass -File .\install.ps1 apply -Verbose
```

![ps1_install ps1](https://user-images.githubusercontent.com/85214181/201580456-18238d4f-4490-48d3-9737-784b2c5fe559.png)

Enter credentials after selection 4 for initial setup.

* ***Must add "" (big quotation marks) when typing.***
* For ```private_key_path```, enter private key path used to generate my oci api key.

![initial_setup](https://user-images.githubusercontent.com/85214181/201580738-d5beab80-92dc-44f3-b683-84183a4416fe.png)

Create a server instance after initial.

![apply_server](https://user-images.githubusercontent.com/85214181/201580772-91f65278-7c81-44fd-8b48-9a37f31d6740.png)

Copy public_ip output after instance creation.

![Apply_Complete_server](https://user-images.githubusercontent.com/85214181/201580904-534e4dcc-be4e-417f-9423-f5ced92e6d53.png)

Installing client instances (Windows, Linux courses are the same).

* Enter the copied ```public_ip``` value after installing the server.

![apply_client_linux](https://user-images.githubusercontent.com/85214181/201580967-3d2b0505-dfc4-40f5-ad9b-c6e191f99412.png)

![apply_client_windows](https://user-images.githubusercontent.com/85214181/201580982-1d07d098-25f0-41ee-b779-9b1bc82dc839.png)

Connecting instances that you create.

* Access is possible with a private_key pair that matches the entered ```public_key```.
* Connect to the server using putty.

![putty_connection](https://user-images.githubusercontent.com/85214181/201581700-5f35fcea-406e-43ba-9b7a-5b1e2c83b551.png)

![putty_auth_1](https://user-images.githubusercontent.com/85214181/201581705-2c10ad7f-852e-4b78-9e7d-157c027fb073.png)

![putty_auth_2](https://user-images.githubusercontent.com/85214181/201581710-c3276943-27fb-4389-b319-b0ab16ab15f8.png)

![putty_connection _end](https://user-images.githubusercontent.com/85214181/201581760-24147a18-94b9-4085-93a9-ad809b227e0d.png)

![Connection_server](https://user-images.githubusercontent.com/85214181/201581711-7137b56c-07ac-421f-aab5-8ae3380caf2e.png)

Ansible host file is located in the path below.

```
/tmp/hosts/
```

![hosts_list](https://user-images.githubusercontent.com/85214181/201581847-07c51cdf-61e2-485e-b17a-b5c9171ba934.png)

<space></space>

# **Check connection with client**

## Connect linux client using ansible

```
ansible all -m ping -i /tmp/hosts/linux.yaml
```
![ansible_lin](https://user-images.githubusercontent.com/85214181/201581885-0ea4caf6-da82-49ac-bb8b-e64f60b14369.png)

## connect windows client using ansible

```
ansible all -m win_ping -i /tmp/hosts/windows.yaml
```
![ansible_win](https://user-images.githubusercontent.com/85214181/201581891-f05a5881-fb08-49e1-bf5f-a86c5c651b82.png)

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