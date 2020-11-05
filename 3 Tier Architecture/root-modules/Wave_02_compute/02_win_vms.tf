variable "win_vms" {
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
            enable_automatic_updates                = bool
            sql_vm                                  = bool
            license_type                            = string
            os_disk_caching                         = string
            os_disk_storage_account_type            = string
            provision_vm_agent                      = bool
            size                                    = string
            timezone                                = string
            vm_os_offer                             = string
            vm_os_publisher                         = string
            vm_os_sku                               = string
            vm_os_version                           = string
        })
        

        sql_vm = object({
            license_type                            = string
            r_services_enabled                      = bool
            connectivity_port                       = number
            connectivity_type                       = string
            connectivity_password                   = string
            connectivity_username                   = string
            patchingday                             = string
            patching_maintenance_minutes            = number
            patching_maintenance_start_hour         = number
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

module "win_vms" {
    source                                          = "../../modules/azurerm_windows_virtual_machine"
    for_each                                        = { for vm in toset( var.win_vms ): vm.hostname => vm }
        hostname                                    = each.key
        resource_group_name                         = each.value.resource_group_name
        vnet                                        = each.value.vnet
        keyvault                                    = each.value.keyvault
        vm_data                                     = each.value.vm_data
        av_set                                      = each.value.av_set
        nic                                         = each.value.nic
        sqlvm                                       = each.value.sql_vm
        tags                                        = merge(var.overall_tags, each.value.tags)
}

 