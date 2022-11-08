terraform {
  required_version = ">= 1.3.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.96.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.36.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.28.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.41.0"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.48.0"
    }
    ncloud = {
      source  = "NaverCloudPlatform/ncloud"
      version = "2.3.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.3"
    }
  }
}

provider "openstack" {
  auth_url  = var.generate.provider.auth_url
  tenant_id = var.generate.provider.tenant_id
  user_name = var.generate.provider.user_name
  password  = var.generate.provider.password
  region    = var.generate.provider.region
}

provider "ncloud" {
  access_key  = null
  secret_key  = null
  region      = null
  support_vpc = null
}

provider "google" {
  credentials = null
  project     = null
  region      = null
}

provider "azurerm" {
  subscription_id = null
  tenant_id       = null
  client_id       = null
  client_secret   = null
}

provider "aws" {
  access_key = null
  secret_key = null
  region     = null
}

provider "oci" {
  tenancy_ocid     = var.generate.provider.tenancy_ocid
  user_ocid        = var.generate.provider.user_ocid
  fingerprint      = var.generate.provider.fingerprint
  region           = var.generate.provider.region
  private_key_path = var.generate.provider.private_key_path
}

# module "create_nhn_instance" {
#   source  = "./terraform-nhn-create-instance-modules"
#   region  = var.generate.provider.region
#   vm_name = var.generate.vm_info.vm_name

#   OS         = var.generate.vm_info.OS.OS_name
#   OS_version = var.generate.vm_info.OS.OS_version
#   boot_size  = 10

#   flavor_name                = var.generate.vm_info.instance_type.instance_type_name

#   network_name               = var.generate.vm_info.network_interface.network_name
#   create_security_group_name = var.generate.vm_info.network_interface.create_security_group_name
#   create_security_group_rules = var.generate.vm_info.network_interface.create_security_group_rules

#   create_key_pair_name = var.generate.vm_info.ssh_public_keys.create_key_pair_name
#   #ssh_public_key       = var.generate.vm_info.ssh_public_keys.ssh_public_key
#   #ssh_public_key_file = var.generate.vm_info.ssh_public_keys.ssh_public_key_file

#   user_data_file_path = var.generate.vm_info.user_data_file_path
#   additional_volumes  = var.generate.vm_info.additional_volumes
# }


module "create_oci_instance" {
  source           = "./terraform-oci-create-instnace-modules"
  region           = var.generate.provider.region
  vm_name          = var.generate.vm_info.vm_name
  subnet_ocid      = var.generate.vm_info.network_interface.subnet_ocid
  compartment_ocid = var.generate.provider.tenancy_ocid

  OS         = var.generate.vm_info.OS.OS_name
  OS_version = var.generate.vm_info.OS.OS_version

  custom_image_name = var.generate.vm_info.OS.custom_image_name

  instance_type_name     = var.generate.vm_info.instance_type.instance_type_name
  instance_cpus          = var.generate.vm_info.instance_type.instance_cpus
  instance_memory_in_gbs = var.generate.vm_info.instance_type.instance_memory_in_gbs

  security_list  = var.generate.vm_info.network_interface.create_security_group_rules
  ssh_public_key = var.generate.vm_info.ssh_public_keys.ssh_public_key

  user_data_file_path = var.generate.vm_info.user_data_file_path
  additional_volumes = [50]
}

output "result" {
  value = module.create_oci_instance.result
}