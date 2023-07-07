variable "environment" {
  type        = string
  description = "Infrastructure environment"
}

variable "role_arn" {
  type        = string
  description = "Role arn"
  default     = "arn:aws:iam::353129431097:role/LabRole"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids"
}

variable "security_group" {
  type        = string
  description = "Security group"
}

variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type"
}