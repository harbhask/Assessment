# Usage of the module
Author:
* Harshith Bhaskar

Version: 0.13.2

Date:    11.05.2020

## Templates

### terraform .tfvars
```hcl
linux_vms = [{
  hostname                                        = "VM_01"
    tags                                            = null
    resource_group_name                             = "RG_01"
    location                                        = null
    vnet = {
        name                                        = "VNET_01"
        resource_group_name                         = "RG_02"
        subnet_name                                 = "Subnet_01"
    }
    keyvault = {
        name                                        = "KV_01"
        resource_group_name                         = "KV_01_RG_01"
    }
    vm_data = {
        admin_password_secret                       = "secret1"
        admin_username_secret                       = "secret2"
        allow_extension_operations                  = true
        availability_zone                           = null
        boot_diagnostics                            = true
        boot_diagnostics_sa_type                    = "Standard_LRS"
        os_disk_caching                             = "None"
        os_disk_storage_account_type                = "Premium_LRS"
        provision_vm_agent                          = true
        size                                        = "Standard_B2s"
        vm_os_offer                                 = "RHEL"
        vm_os_publisher                             = "RedHat"
        vm_os_sku                                   = "7.4"
        vm_os_version                               = "latest"
        public_key                                  = "ssh-rsa AAAA..."
        password_authentication                     = true
        storage_data_disk = [{
            caching                                 = "None"
            managed_disk_type                       = "StandardSSD_LRS"
            disk_size_gb                            = 32
            write_accelerator_enabled               = false
        }]
    }
    av_set = {
        name                                        = "AV_SET_01"
        platform_fault_domain_count                 = 2
        platform_update_domain_count                = 20
        managed                                     = true
    }
    nic = {
        enable_accelerated_networking               = false
        private_ip_address                          = ""
    }
}]
```

### variable .tf
```hcl
variable "linux_vms" {
    type = list(object({
        hostname                                    = string
        tags                                        = map(string)
        resource_group_name                         = string
        location                                    = string
        vnet = object({
            name                                    = string
            resource_group_name                     = string
            subnet_name                             = string
        })
        keyvault = object({
            name                                    = string
            resource_group_name                     = string
        })
        vm_data = object({
            admin_password_secret                   = string
            admin_username_secret                   = string
            allow_extension_operations              = bool
            availability_zone                       = number
            boot_diagnostics                        = bool
            boot_diagnostics_sa_type                = string
            os_disk_caching                         = string
            os_disk_storage_account_type            = string
            provision_vm_agent                      = bool
            size                                    = string
            vm_os_offer                             = string
            vm_os_publisher                         = string
            vm_os_sku                               = string
            vm_os_version                           = string
            public_key                              = string
            disable_password_authentication         = bool
            storage_data_disk = list(object({
                caching                             = string
                managed_disk_type                   = string
                disk_size_gb                        = number
                write_accelerator_enabled           = bool
            }))
        })
        av_set = object({
            name                                    = string
            platform_fault_domain_count             = number
            platform_update_domain_count            = number
            managed                                 = bool
        })
        nic = object({
            enable_accelerated_networking           = bool
            private_ip_address                      = string
        })
    }))
}
```

### main .tf
```hcl
module "linux_vms" {
    source                                              = "../../modules/0.13/r/azurerm_linux_virtual_machine"
    for_each                                            = { for vm in toset( var.linux_vms ): vm.hostname => vm }
        hostname                                        = each.key
        resource_group_name                             = each.value.resource_group_name
        vnet                                            = each.value.vnet
        keyvault                                        = each.value.keyvault
        vm_data                                         = each.value.vm_data
        av_set                                          = each.value.av_set
        nic                                             = each.value.nic
        tags                                            = merge(var.overall_tags, each.value.tags)
}
```
