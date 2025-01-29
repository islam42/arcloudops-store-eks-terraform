variable "aws_access_key" {
  description = "The AWS access key"
}

variable "aws_secret_key" {
  description = "The AWS secret key"
}

variable "region" {
  description = "The AWS region to deploy resources."
  default     = "us-east-1"
}

variable "bucket-name" {
  description = "The name of the S3 bucket to store Terraform state."
  default     = "arcloudops.com"
}

variable "domain-name" {
  description = "The domain name to use for the Route 53 hosted zone."
  default     = "store.arcloudops.com"
}

variable "cluster-name" {
  description = "The name of the EKS cluster."
  default     = "arcloudops-cluster"
}

variable "vpc_cidr_block" {
  type = map(string)
  description = "The CIDR block for the VPC."
}

variable "vpc_subnet_count" {
  description = "The number of subnets to create in the VPC."
  default     = 2
}

variable "vpc_subnet_mask" {
  description = "The mask for the VPC subnets."
  default     = 8
}

variable "eks_version" {
  description = "The version of EKS to use"
  default     = "1.31"
}

variable "instance_type" {
  description = "The instance type for the EKS nodes."
  default     = "t3.micro"

}

variable "desired_capacity" {
  description = "The desired capacity for the EKS nodes."
  default     = 2
}

variable "maximum_capacity" {
  description = "The maximum capacity for the EKS nodes."
  default     = 3
}

variable "minumum_capacity" {
  description = "The minimum capacity for the EKS nodes."
  default     = 1
}


