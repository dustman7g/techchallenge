variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.1.0.0/16"
}

variable "azs" {
  description = "Two availability zones to use (order matters)"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "management_subnet_cidr" {
  description = "Management subnet CIDR (public) - /24"
  type        = string
  default     = "10.1.1.0/24"
}

variable "app_subnet_cidrs" {
  description = "Application subnet CIDRs (private) - provide two to spread across two AZs"
  type        = string
  default     = "10.1.2.0/24"
}

variable "backend_subnet_cidrs" {
  description = "Backend subnet CIDRs (private) - provide two to spread across two AZs"
  type        = string
  default     = "10.1.4.0/24"
}

variable "allowed_mgmt_ip" {
  description = "CIDR allowed to SSH to management instance"
  type        = string
  default     = "203.0.113.5/32" # NEEED TO REPLACE
}

variable "key_name" {
  description = "EC2 Key pair name for SSH access"
  type        = string
  default     = "dustin-key" 
}

variable "asg_min" {
  description = "ASG minimum size"
  type        = number
  default     = 2
}

variable "asg_desired" {
  description = "ASG desired capacity"
  type        = number
  default     = 2
}

variable "asg_max" {
  description = "ASG max size"
  type        = number
  default     = 6
}