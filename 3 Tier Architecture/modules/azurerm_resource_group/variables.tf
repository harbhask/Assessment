variable "name" {
    type        = string
}

variable "location" {
    type        = string
    default     = ""
}

variable "tags" {
    type        = map(string)
}
