output "s3_object_changed_date" {
  value = "The file was last changed ${data.aws_s3_object.workshop_file_data.last_modified}"
}

output "ssh_private_key" {
  value = tls_private_key.workshop_key.private_key_openssh
  sensitive = true 
}

output "db_server_id" {
    value = module.database_server.db_inbstance.id
}