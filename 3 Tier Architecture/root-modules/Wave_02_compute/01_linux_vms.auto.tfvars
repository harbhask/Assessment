linux_vms = [{
    hostname                                        = "webserver"
    tags                                            = null
    resource_group_name                             = "rg1"
    location                                        = null
    vnet = {
        name                                        = "vnet1"
        resource_group_name                         = "vnet-rg"
        subnet_name                                 = "publicsubnet"
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
        os_disk_caching                             = "None"
        os_disk_storage_account_type                = "Premium_LRS"
        provision_vm_agent                          = true
        size                                        = "Standard_B1s"
        vm_os_offer                                 = "RHEL"
        vm_os_publisher                             = "RedHat"
        vm_os_sku                                   = "7.4"
        vm_os_version                               = "latest"
        public_key                                  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCoK04py41Qy1V4+eytRt3GvoRpLjGWE6dqU3aqQVuboO9SHHTXeMb9bJN17hY76gIg95JwDUTo5QXZDJ9e/EDVbI4W6zl3kmODL6gqbOMcKuYUUFucxu9mVPIVmDLgcVz89jC6l0TY9YL00EeUSTXiNkte9KAxgcz41BnHaSCZQ14SuXrluBOR6gQt33F2Zz6QD77ep0frrrPoBThFjzx+Rw5arsnVrlN7Dc2msWooEaLtf03Yvq6msDcIeQgxWwtPXmVIEKECmfrklpXAi0wEsTvZGmB9NMKHBCmEdFaM9eYkVC3Jmqkcxa5D5SsMMzIdY5l4x7PC6CkOrJf961az kashi@DESKTOP-6DKK1LI"
        disable_password_authentication             = false
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
