resource "aws_vpc" "workshop_vpc" {
  cidr_block = var.vpc_cidr_range
  tags = {
    Owner = var.user_identifier
    Name  = "vpc-ak"
  }
}

resource "aws_subnet" "workshop_subnet" {
  cidr_block = cidrsubnet(aws_vpc.workshop_vpc.cidr_block, 3, 0)
  vpc_id     = aws_vpc.workshop_vpc.id
  tags = {
    Owner = var.user_identifier
    Name  = "subnet-ak"
  }
}

resource "aws_network_interface" "workshop_nic" {
  for_each = var.instance_map 
  subnet_id = aws_subnet.workshop_subnet.id
  tags = {
    owner = "${var.user_identifier}-${each.value.owner}" 
    Name = "eni-instance-${var.user_identifier}-${each.key}" 
  }
}

resource "tls_private_key" "workshop_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "workshop_keypair" {
  public_key = tls_private_key.workshop_key.public_key_openssh
  tags = {
    Owner = "ak"
    Name  = "key-ak"
  }
}

resource "aws_instance" "workshop_instance" {
  for_each = var.instance_map 
  ami = "ami-0c956e207f9d113d5"
  instance_type = each.value.type 
  key_name = aws_key_pair.workshop_keypair.key_name
  network_interface {
    network_interface_id = aws_network_interface.workshop_nic[each.key].id 
    device_index         = 0
  }
  tags = { 
    owner = "${var.user_identifier}-${each.value.owner}"
    Name = "ec2-instance-${var.user_identifier}-${each.key}"
  }
}

resource "aws_s3_bucket" "workshop_bucket" {
  bucket = local.final_bucket_name
  tags = {
    owner = var.user_identifier
  }
}

resource "aws_s3_object" "workshop_file" {
  bucket = aws_s3_bucket.workshop_bucket.bucket
  key = "file.txt"
  source = "./file.txt"

  etag = filemd5("./file.txt")
}

module "database_server" {
    source = "./db-instance"
    dbs_subnet = aws_subnet.workshop_subnet
    dbs_keypair = aws_key_pair.workshop_keypair
    dbs_data_disk_size = 40
    dbs_tags = {
      Name = "db_server"
    }
}