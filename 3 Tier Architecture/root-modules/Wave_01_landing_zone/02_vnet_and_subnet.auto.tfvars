networks = [{
    name                                            = "vnet1"
    resource_group_name                             = "vnet-rg"
    location                                        = null
    address_space                                   = ["10.0.0.0/16"]
    dns_servers                                     = null
    tags                                            = null
    subnets = [{
        name                                        = "publicsubnet"
        address_prefixes                            = ["10.0.1.0/24"]
        service_endpoints                           = null 
    },
    {
        name                                        = "privatesubnet"
        address_prefixes                            = ["10.0.2.0/24"]
        service_endpoints                           = null 
    }]
}}]
