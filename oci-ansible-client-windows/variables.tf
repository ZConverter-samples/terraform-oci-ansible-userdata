variable "generate" {
  type = object({
    cloud_platform = string
    provider = object({
      #oci
      tenancy_ocid     = optional(string)
      user_ocid        = optional(string)
      fingerprint      = optional(string)
      private_key_path = optional(string)

      #openstack
      auth_url  = optional(string)
      tenant_id = optional(string)
      user_name = optional(string)
      password  = optional(string)

      #aws && ncp
      access_key  = optional(string)
      secret_key  = optional(string)
      support_vpc = optional(string) #only ncp

      #gcp
      credentials = optional(string)
      project     = optional(string)

      #azure
      subscription_id = optional(string)
      tenant_id       = optional(string)
      client_id       = optional(string)
      client_secret   = optional(string)

      #Public use
      region = optional(string)
    })
    vm_info = object({
      vm_name          = string
      compartment_ocid = optional(string)
      network_interface = optional(object({
        network_name               = optional(string)
        create_security_group_name = optional(string)
        subnet_ocid                = optional(string)
        create_security_group_rules = optional(list(object({
          direction        = optional(string)
          ethertype        = optional(string)
          protocol         = optional(string)
          port_range_min   = optional(string)
          port_range_max   = optional(string)
          remote_ip_prefix = optional(string)
          type             = optional(string)
          code             = optional(string)
        })))
      }))
      OS = object({
        OS_name           = string
        OS_version        = string
        custom_image_name = optional(string)
      })
      instance_type = object({
        instance_type_name     = string
        instance_cpus          = optional(number)
        instance_memory_in_gbs = optional(number)
      })
      ssh_public_keys = optional(object({
        key_pair_name        = optional(string)
        create_key_pair_name = optional(string)
        ssh_public_key       = optional(string)
        ssh_public_key_file  = optional(string)
      }))
      user_data_file_path = optional(string)
      additional_volumes  = optional(list(number))
    })
  })
  default = {
    cloud_platform = null
    provider = {
      tenancy_ocid     = null
      user_ocid        = null
      fingerprint      = null
      private_key_path = null
      auth_url         = null
      tenant_id        = null
      user_name        = null
      password         = null
      access_key       = null
      secret_key       = null
      support_vpc      = null
      credentials      = null
      project          = null
      subscription_id  = null
      tenant_id        = null
      client_id        = null
      client_secret    = null
      region           = null
    }
    vm_info = {
      #Public use
      vm_name = null
      OS = {
        OS_name           = null
        OS_version        = null
        custom_image_name = null
      }
      instance_type = {
        instance_cpus          = 1
        instance_memory_in_gbs = 16
        instance_type_name     = null
      }
      ssh_public_keys = {
        key_pair_name        = null
        create_key_pair_name = null
        ssh_public_key       = null
        ssh_public_key_file  = null
      }
      additional_volumes  = []
      user_data_file_path = null

      #oci
      network_interface = {
        network_name                = null
        create_security_group_name  = null
        subnet_ocid                 = null
        create_security_group_rules = null
      }
      compartment_ocid = null
    }
  }
}