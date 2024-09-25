module "network" {
  source                 = "./network"
  compartment_id       = var.compartment_id
  vcn_cidr_block = var.vcn_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  public_subnet_display_name = var.public_subnet_display_name
  service_gateway_displayname = var.service_gateway_displayname
  private_subnet_security_list_disply_name = var.private_subnet_security_list_disply_name
  public_subnet_route_table_display_name = var.public_subnet_route_table_display_name
  private_subnet_route_table_display_name = var.private_subnet_route_table_display_name
  vcn_display_name = var.vcn_display_name
  private_subnet_cidr_block = var.private_subnet_cidr_block
  private_subnet_display_name = var.private_subnet_display_name
  internet_gateway_name = var.internet_gateway_name
  public_subnet_security_list_display_name = var.public_subnet_security_list_display_name



}

module "instance" {
  source                 = "./instance"
  api_private_key_for_ssh = var.api_private_key_for_ssh
  compute_instance_display_name = var.compute_instance_display_name
  compute_ssh_authorized_keys = var.compute_ssh_authorized_keys
  compartment_id = var.compartment_id
  source_operating_system_image_id = var.source_operating_system_image_id
  compute_shape = var.compute_shape
  public_subnet_id = module.network.public_subnet_id
}

module database {
    source = "./database"
    private_subnet_id = module.network.private_subnet_id
    db_system_credentials_password_details_password = var.db_system_credentials_password_details_password
    db_system_credentials_password_details_password_type = var.db_system_credentials_password_details_password_type
    db_system_credentials_username = var.db_system_credentials_username
    compartment_id = var.compartment_id
    db_system_instance_memory_size_in_gbs = var.db_system_instance_memory_size_in_gbs
    db_system_shape = var.db_system_shape
    db_system_db_version = var.db_system_db_version
    db_system_display_name = var.db_system_display_name
    db_system_instance_count = var.db_system_instance_count
    db_system_instance_ocpu_count = var.db_system_instance_ocpu_count
    db_system_storage_details_is_regionally_durable = var.db_system_storage_details_is_regionally_durable
    db_system_storage_details_system_type = var.db_system_storage_details_system_type
}



