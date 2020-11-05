output "id" {
    description = "The id of the newly created vNet"
    value       = azurerm_virtual_network.vnet.id
}

output "name" {
    description = "The Name of the newly created vNet"
    value       = azurerm_virtual_network.vnet.name
}

output "subnets" {
    description = "The ids of subnets created inside the newl vNet"
    value       = module.subnet
}

output "subnet_ids" {
    description = "The ids of subnets created inside the newl vNet"
    value       = values(module.subnet)[*].id
}

output "subnet_names" {
    description = "The names of subnets created inside the newl vNet"
    value       = values(module.subnet)[*].name
}
