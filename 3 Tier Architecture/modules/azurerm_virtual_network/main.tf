data azurerm_resource_group "rg" {
    name = var.resource_group_name
}

resource azurerm_virtual_network "vnet" {
    name                        = var.name
    resource_group_name         =                        data.azurerm_resource_group.rg.name
    location                    = coalesce(var.location, data.azurerm_resource_group.rg.location)
    address_space               = var.address_space
    dns_servers                 = var.dns_servers
    tags                        = var.tags
}

module "subnet" {
    source                      = "../../../0.13/r/azurerm_subnet"
    for_each                    = { for subnet in toset(var.subnets) : subnet.name => subnet }
        name                    = each.key
        resource_group_name     = data.azurerm_resource_group.rg.name
        virtual_network_name    = azurerm_virtual_network.vnet.name
        address_prefixes        = each.value.address_prefixes
        service_endpoints       = each.value.service_endpoints
}
