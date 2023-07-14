variable "dbs_data_disk_size" {
  type = number
  description = "Size of the Data Disk"
  default = 20
}

variable "dbs_subnet" {
  type = any
  description = "Subnet where to create the instance in"
  nullable = false
}

variable "dbs_keypair" {
  type = any
  description = "Key Pair to use for the instance"
  nullable = false
}

variable "dbs_type" {
  type = string
  description = "Instance Type of the Database Server"
  default = "t3.nano"
}

variable "dbs_ami" {
    type = string
    description = "The AMI to use for instance"
    default = "ami-0c956e207f9d113d5"
}

variable "dbs_tags" {
    type = map
    description = "Resource Tags"
    default = {
      created_by = "Terraform"
    }
}