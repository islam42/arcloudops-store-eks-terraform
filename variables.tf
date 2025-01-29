variable "region" {
  type        = string
  description = "The AWS region to deploy resources."
}

variable "vpc_cidr_block" {
  type        = map(string)
  description = "The CIDR block for the VPC."
}

variable "vpc_subnet_count" {
  type        = map(number)
  description = "The number of subnets to create in the VPC."
}

variable "vpc_subnet_mask" {
  type        = map(number)
  description = "The mask for the VPC subnets."
}

variable "eks_version" {
  type        = string
  description = "The version of EKS to use"
}

variable "aws_instance_type" {
  type        = string
  description = "The instance type for the EKS nodes."

}

variable "node_desired_capacity" {
  type        = map(number)
  description = "The desired capacity for the EKS nodes."
}

variable "node_maximum_capacity" {
  type        = map(number)
  description = "The maximum capacity for the EKS nodes."
}

variable "node_minumum_capacity" {
  type        = map(number)
  description = "The minimum capacity for the EKS nodes."
}

variable "billing_code" {
  type        = string
  description = "The billing code for the resources."

}

variable "project" {
  type        = string
  description = "The project name for the resources."

}

variable "company" {
  type        = string
  description = "The company name for the resources."

}