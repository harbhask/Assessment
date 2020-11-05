variable "hostname" {
    type        = string
}

variable "resource_group_name" {
    type        = string
}

variable "location" {
    type        = string
    default     = ""
}

variable "tags" {
    type        = map(string)
}

variable "vnet" {
    type        = map(string)
}

variable "vm_data" {
    description = "All parameters to setup the VM."
    type        = object({
        admin_password_secret                       = string
        admin_username_secret                       = string
        allow_extension_operations                  = bool
        availability_zone                           = number
        boot_diagnostics                            = bool
        boot_diagnostics_sa_type                    = string
        enable_automatic_updates                    = bool
        license_type                                = string
        os_disk_caching                             = string
        os_disk_storage_account_type                = string
        provision_vm_agent                          = bool
        sql_vm                                      = bool
        size                                        = string
        timezone                                    = string
        vm_os_offer                                 = string
        vm_os_publisher                             = string
        vm_os_sku                                   = string
        vm_os_version                               = string
        storage_data_disk = list(object({
            caching                                 = string
            managed_disk_type                       = string
            disk_size_gb                            = number
            write_accelerator_enabled               = bool
        }))
    })
}

variable "av_set" {
    description = "All parameters to setup the AV_Set."
    type        = object({
        name                                        = string
        platform_fault_domain_count                 = number
        platform_update_domain_count                = number
        managed                                     = bool
    })
}

variable "nic" {
    description = "All parameters to setup the NIC."
    type        = object({
        app_sec_group                               = string
        enable_accelerated_networking               = bool
        private_ip_address                          = string
    })
}


variable "keyvault" {
    type        = map(string)
}

variable "sqlvm" {
    type        = map(string)
}