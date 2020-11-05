variable "name" {
    type        = string
}

variable "resource_group_name" {
    type        = string
}

variable "location" {
    type        = string
    default     = ""
}

variable "address_space" {
    type        = list(string)
    default     = ["10.0.0.0/16"]
}

variable "dns_servers" {
    description = "If no values specified, this defaults to Azure DNS"
    type        = list(string)
}

variable "subnets" {
    type = list(object({
                            name              = string
                            address_prefixes  = list(string)
                            service_endpoints = list(string)
                        }))
}

variable "tags" {
    type        = map(string)
}
