variable "vpc_network_name" {
  description = "The name of the VPC network to create"
  type       = string
    default    = "custom-vpc-network"
}

variable "subnet_name" {
  description = "The name of the subnet to create"
  type        = string
  default     = "custom-subnet"
}

variable "instance_name" {
  description = "The name of the instance to create"
  type        = string
  default     = "seed-labs-ubuntu-vm"
}