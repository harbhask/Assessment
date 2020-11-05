#####################################################################
#                                                                   #
#         Data Sources (resource_group; subnet; keyvault)           #
#                                                                   #
#####################################################################

data "azurerm_resource_group" "rg" {
    name                        = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
    name                        = var.vnet.subnet_name
    virtual_network_name        = var.vnet.name
    resource_group_name         = var.vnet.resource_group_name
}

data "azurerm_key_vault" "kv" {
    name                        = var.keyvault.name
    resource_group_name         = var.keyvault.resource_group_name
}

data "azurerm_key_vault_secret" "kv_username" {
    name                        = var.vm_data.admin_username_secret
    key_vault_id                = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "kv_password" {
    name                        = var.vm_data.admin_password_secret
    key_vault_id                = data.azurerm_key_vault.kv.id
}



#####################################################################
#                                                                   #
#                          Boot Diagnostic                          #
#                                                                   #
#####################################################################

resource "random_id" "vm-sa" {
    keepers = {
    hostname                    = var.hostname
    }

    byte_length                 = 6
}

resource "azurerm_storage_account" "sa" {
    count                       = var.vm_data.boot_diagnostics ? 1 : 0
    name                        = "bootdiag${lower(random_id.vm-sa.hex)}"
    resource_group_name         = data.azurerm_resource_group.rg.name
    location                    = coalesce(var.location, data.azurerm_resource_group.rg.location)
    account_tier                = element(split("_", var.vm_data.boot_diagnostics_sa_type), 0)
    account_replication_type    = element(split("_", var.vm_data.boot_diagnostics_sa_type), 1)
    tags                        = var.tags
}

#####################################################################
#                                                                   #
#                              AV_Set                               #
#                                                                   #
#####################################################################

resource "azurerm_availability_set" "availability_set" {
    resource_group_name                     = data.azurerm_resource_group.rg.name
    location                                = coalesce(var.location, data.azurerm_resource_group.rg.location)

    count                                   = var.av_set.name == "" ? 0 : 1
    name                                    = var.av_set.name
    platform_fault_domain_count             = var.av_set.platform_fault_domain_count
    platform_update_domain_count            = var.av_set.platform_update_domain_count
    managed                                 = var.av_set.managed
}

#####################################################################
#                                                                   #
#                              Virtual_Machine                      #
#                                                                   #
#####################################################################

resource "azurerm_network_interface" "vm_nic" {
    resource_group_name                     = data.azurerm_resource_group.rg.name
    location                                = coalesce(var.location, data.azurerm_resource_group.rg.location)
    name                                    = "${var.hostname}-nic"

    enable_accelerated_networking           = var.nic.enable_accelerated_networking
    tags                                    = var.tags

    ip_configuration {
        subnet_id                           = data.azurerm_subnet.subnet.id
        name                                = "${var.hostname}-nic-ip"
        private_ip_address_allocation       = var.nic.private_ip_address == "" ? "Dynamic" : "Static"
        private_ip_address                  = var.nic.private_ip_address == "" ? null : var.nic.private_ip_address
    }
}

resource "azurerm_linux_virtual_machine" "vm" {
    admin_password                          = var.vm_data.disable_password_authentication ? null : data.azurerm_key_vault_secret.kv_password.value
    admin_username                          = data.azurerm_key_vault_secret.kv_username.value
    location                                = coalesce(var.location, data.azurerm_resource_group.rg.location)
    name                                    = var.hostname
    network_interface_ids                   = [azurerm_network_interface.vm_nic.id]
    os_disk {
        caching                             = var.vm_data.os_disk_caching
        storage_account_type                = var.vm_data.os_disk_storage_account_type
    }
    resource_group_name                     = data.azurerm_resource_group.rg.name
    size                                    = var.vm_data.size
    disable_password_authentication         = var.vm_data.disable_password_authentication
    dynamic "admin_ssh_key"{
        for_each                            = var.vm_data.disable_password_authentication ? [1] : []
        content {
            username   = data.azurerm_key_vault_secret.kv_username.value
            public_key = var.vm_data.public_key
        }

    }
    allow_extension_operations              = var.vm_data.allow_extension_operations
    availability_set_id                     = var.av_set.name == "" ? null : azurerm_availability_set.availability_set[0].id
    dynamic "boot_diagnostics" {
        for_each                            = var.vm_data.boot_diagnostics ? [1] : []
        content {
            storage_account_uri             = azurerm_storage_account.sa[0].primary_blob_endpoint
        }
    }
    provision_vm_agent                      = true
    source_image_reference {
        publisher                           = var.vm_data.vm_os_publisher
        offer                               = var.vm_data.vm_os_offer
        sku                                 = var.vm_data.vm_os_sku
        version                             = var.vm_data.vm_os_version
    }
    tags                                    = var.tags
    zone                                    = var.av_set.name == "" ? var.vm_data.availability_zone : null
}

