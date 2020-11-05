# Usage of the module
Author:
* Harshith Bhaskar

Version: 0.13.2

Date:    11.05.2020


## Templates

### terraform .tfvars
```hcl
subnets = [{
    name                                        = "Subnet_01"
    address_prefixes                            = ["a.b.c.d/cidr"]
    service_endpoints                           = null // ["Microsoft.Storage", "Microsoft.Sql"]

 
},
{
    name                                        = "AzureFirewallSubnet"
    address_prefixes                            = ["a.b.c.d/cidr"]
    service_endpoints                           = null // ["Microsoft.Storage", "Microsoft.Sql"]

}]
```

### variable .tf
```hcl
variable "networks" {
    type = list(object({
        name                            = string
        address_prefixes                = list(string)
        service_endpoints               = list(string)
    }))
}
```

### main .tf
```hcl
module "subnet" {
    source                      = "../../../0.13/r/azurerm_subnet"
    for_each                    = { for subnet in toset(var.subnets) : subnet.name => subnet }
        name                    = each.key
        resource_group_name     = data.azurerm_resource_group.rg.name
        virtual_network_name    = azurerm_virtual_network.vnet.name
        address_prefixes        = each.value.address_prefixes
        service_endpoints       = each.value.service_endpoints
}
```

