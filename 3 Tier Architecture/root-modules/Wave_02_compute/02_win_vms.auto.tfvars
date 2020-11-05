win_vms = [{
    hostname                                        = "applnserver"
    tags                                            = null
    resource_group_name                             = "rg1"
    location                                        = null
    vnet = {
        name                                        = "vnet1"
        resource_group_name                         = "vnet-rg"
        subnet_name                                 = "privatesubnet"
    }
    keyvault = {
        name                                        = "keyvault111111111"
        resource_group_name                         = "keyvault-rg"
    }
    vm_data = {
        admin_password_secret                       = "passwordsecret"
        admin_username_secret                       = "usernamesecret"
        allow_extension_operations                  = true
        availability_zone                           = null
        boot_diagnostics                            = true
        boot_diagnostics_sa_type                    = "Standard_LRS"
        enable_automatic_updates                    = false
        sql_vm                                      = false
        license_type                                = "Windows_Server"
        os_disk_caching                             = "None"
        os_disk_storage_account_type                = "Premium_LRS"
        provision_vm_agent                          = true
        size                                        = "Standard_B1s"
        timezone                                    = "GMT Standard Time"
        vm_os_offer                                 = "WindowsServer"
        vm_os_publisher                             = "MicrosoftWindowsServer"
        vm_os_sku                                   = "2016-Datacenter-smalldisk"
        vm_os_version                               = "latest"
    }

    sql_vm = {
        license_type                                = ""
        r_services_enabled                          = true
        connectivity_port                           = 1433
        connectivity_type                           = ""
        connectivity_password                       = ""
        connectivity_username                       = ""
        patchingday                                 = ""
        patching_maintenance_minutes                = 30
        patching_maintenance_start_hour             = 1
    }


    av_set = {
        name                                        = ""
        platform_fault_domain_count                 = 2
        platform_update_domain_count                = 20
        managed                                     = true
    }
    nic = {
        enable_accelerated_networking               = false
        private_ip_address                          = ""
    }
},

{
    hostname                                        = "databaseserver"
    tags                                            = null
    resource_group_name                             = "rg1"
    location                                        = null
    vnet = {
        name                                        = "vnet1"
        resource_group_name                         = "vnet-rg"
        subnet_name                                 = "privatesubnet"
    }
    keyvault = {
        name                                        = "keyvault111111111"
        resource_group_name                         = "keyvault-rg"
    }
    vm_data = {
        admin_password_secret                       = "passwordsecret"
        admin_username_secret                       = "usernamesecret"
        allow_extension_operations                  = true
        availability_zone                           = null
        boot_diagnostics                            = true
        boot_diagnostics_sa_type                    = "Standard_LRS"
        enable_automatic_updates                    = false
        license_type                                = "Windows_Server"
        sql_vm                                      = true
        os_disk_caching                             = "None"
        os_disk_storage_account_type                = "Premium_LRS"
        provision_vm_agent                          = true
        size                                        = "Standard_B2s"
        timezone                                    = "GMT Standard Time"
        vm_os_offer                                 = "SQL2012SP4-WS2012R2"
        vm_os_publisher                             = "MicrosoftSQLServer"
        vm_os_sku                                   = "Web"
        vm_os_version                               = "latest"
    }

    sql_vm = {
        license_type                                = "PAYG"
        r_services_enabled                          = true
        connectivity_port                           = 1433
        connectivity_type                           = "PRIVATE"
        connectivity_password                       = "Admin@123456"
        connectivity_username                       = "sqluser"
        patchingday                                 = "Sunday"
        patching_maintenance_minutes                = 30
        patching_maintenance_start_hour             = 1
    }

    av_set = {
        name                                        = ""
        platform_fault_domain_count                 = 2
        platform_update_domain_count                = 20
        managed                                     = true
    }
    nic = {
        enable_accelerated_networking               = false
        private_ip_address                          = ""
    }
}]
