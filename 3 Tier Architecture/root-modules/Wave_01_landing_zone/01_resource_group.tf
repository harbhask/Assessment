variable "resource_group_names" {
    type = list(object({
        names                               = list(string)
        location                            = string
        tags                                = map(string)
    }))
}

locals {
    resource_group_names = flatten([
                            for rgs in toset( var.resource_group_names ) : [
                            for name in rgs.names : {
                                name        = name
                                location    = rgs.location
                                tags        = rgs.tags
                            }]
                        ])
}

module "resource_group" {
    source                                  = "../../modules/azurerm_resource_group"
    for_each                                = { for rg in toset( local.resource_group_names ): rg.name => rg }
        name                                = each.key
        location                            = each.value.location
        tags                                = merge(var.overall_tags, each.value.tags)
}
