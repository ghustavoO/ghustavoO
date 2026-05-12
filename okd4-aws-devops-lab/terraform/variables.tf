variable "aws_region" {
  default = "us-east-1"
}

variable "domain_name" {
  default = "devops-labs.io"
}

variable "billing_alert_email" {
  type = string
}

variable "master_instance_type" {
  default = "m7i-flex.large"
}

variable "worker_instance_type" {
  default = "t3.micro"
}

variable "cluster_name" {
  type = string
}