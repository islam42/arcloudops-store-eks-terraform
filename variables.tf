variable "region" {
  description = "The AWS region to deploy resources."
}

variable "vpc_cidr_block" {
  type        = map(string)
  description = "The CIDR block for the VPC."
}

variable "vpc_subnet_count" {
  description = "The number of subnets to create in the VPC."
}

variable "vpc_subnet_mask" {
  description = "The mask for the VPC subnets."
}

variable "eks_version" {
  description = "The version of EKS to use"
}

variable "aws_instance_type" {
  description = "The instance type for the EKS nodes."

}

variable "node_desired_capacity" {
  description = "The desired capacity for the EKS nodes."
}

variable "node_maximum_capacity" {
  description = "The maximum capacity for the EKS nodes."
}

variable "node_minumum_capacity" {
  description = "The minimum capacity for the EKS nodes."
}

variable "billing_code" {
  description = "The billing code for the resources."

}

variable "project" {
  description = "The project name for the resources."

}

variable "company" {
  description = "The company name for the resources."

}