variable "user_identifier" {
    type = string
    description = "Name of the Ressource Owner"
}

variable "vpc_cidr_range" {
    type = string
    description = "CIDR Range of the workshop Virtual Private Cloud"
    default = "10.0.0.0/16" 
}

variable "bucket_name" {
    type = string
    description = "The name of our S3 Bucket"
    validation {
    condition = can(regex("^([a-z0-9])[a-z0-9\\-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "The Bucket Name does not follow the AWS Guidelines. https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html"
    }
}

variable "instance_count" {
  type = number 
  description = "Number of Instances to deploy"
  default = 1 
}

variable "instance_map" {
  type        = map 
  description = "Description for all VMs to create"
  default = { 
    web = {
      type = "t3.nano"
      owner = "Webserver Admin"
    }
    database = {
      type = "t3.micro"
      owner = "Database Administrator"
    }
    compute = {
      type = "t3.nano"
      owner = "Frontend Administrator"
    }
  }
}

locals {
  final_bucket_name = "${var.bucket_name}-${var.user_identifier}"
}