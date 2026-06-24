# variables.tf

variable "owner_name" {
description = "Owner name"
type        = string
default     = "sherjeel"
}

variable "aws_region" {
type    = string
default = "us-east-1"
}

variable "instance_type" {
type    = string
default = "t2.micro"
}

variable "key_name" {
description = "AWS-ec2-prod"
type        = string
}
