resource "aws_network_interface" "network_interface" {
  subnet_id = var.dbs_subnet.id
  tags = var.dbs_tags
}

resource "aws_instance" "virtual_machine" {
  ami = var.dbs_ami
  instance_type = var.dbs_type
  key_name = var.dbs_keypair.key_name
  network_interface {
    network_interface_id = aws_network_interface.network_interface.id
    device_index         = 0
  }
  tags = var.dbs_tags
}

resource "aws_ebs_volume" "data_disk" {
 size = var.dbs_data_disk_size
 availability_zone = var.dbs_subnet.availability_zone
}

resource "aws_volume_attachment" "data_disk_attachment" {
  device_name = "/dev/xvdf"
  volume_id = aws_ebs_volume.data_disk.id
  instance_id = aws_instance.virtual_machine.id
}