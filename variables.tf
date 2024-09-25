# Provider identity parameters - Replace these values from API Key Values from OCI User

variable "api_fingerprint" {
  description = "Fingerprint of OCI API private key for Requestor Tenancy"
  type        = string
  default     = ""
}

variable "api_private_key_path" {
  description = "Path to OCI API private key used for Requestor Tenancy"
  type        = string
  default     = ""
}

variable "tenancy_id" {
  description = "Tenancy ID where to create resources for Requestor Tenancy"
  type        = string
  default     = ""
}

variable "user_id" {
  description = "User ID that Terraform will use to create resources for Requestor Tenancy"
  type        = string
  default     = ""
}

variable "region" {
  description = "OCI region where resources will be created for Requestor Tenancy"
  type        = string
  default     = "us-ashburn-1"  # example value
  # check this document, if you want to use different region - https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm#About
}

# compartment OCID - Replace these values

variable "compartment_id" {
  description = "Compartment ID where to create resources for Requestor Tenancy"
  type        = string
}

variable "db_system_db_version" {
  description = "Version"
  type = number
  default = 14
}

variable "db_system_display_name" {
  description = "postgress db service name"
  type = string
  default = "psqlfromterraform" # example value
}


variable "db_system_shape" {
    description = "shape"
    type = string
    default = "PostgreSQL.VM.Standard.E4.Flex.4.64GB"  # example value
    #change the shape value as per your requirements
}

variable "db_system_instance_count" {
  description = "instance count"
  type = number
  default = 3  # example value
}

variable "db_system_instance_memory_size_in_gbs" {
  description = "RAM"
  type = number
  default = 64  # example value
}

variable "db_system_instance_ocpu_count" {
  description = "OCPU count"
  type = number
  default = 4  # example value
}

variable "db_system_storage_details_is_regionally_durable" {
  description = "regional"
  type = bool
  default = true
}
variable "db_system_credentials_password_details_password_type" {
    description = "type"
    type = string
    default = "PLAIN_TEXT"

}

variable "db_system_credentials_password_details_password" {
  description = "password"
  type = string

}

variable "db_system_credentials_username" {
  description = "username"
  type = string
  default = "admin" # example value
}

variable "db_system_storage_details_system_type" {
  description = "type"
  type = string
  default = "OCI_OPTIMIZED_STORAGE"
}



# OCI VCN parameters - psql instance deployed on this

variable "vcn_cidr_block" {
  description = "vcn cidr"
  type = string
  default = "172.16.0.0/16" # example value
}

variable "vcn_display_name" {
  description = "vcn name"
  type = string
  default = "vcn-from-tf-psql" # example value
}

variable "public_subnet_cidr_block" {
    description = "subnet cidr range"
    type = string
    default = "172.16.1.0/24" # example value
}

variable "private_subnet_cidr_block" {
    description = "subnet cidr range"
    type = string
    default = "172.16.2.0/24" # example value
}

variable "public_subnet_display_name" {
  description = "public subnet name"
  type = string
  default = "public-subnet" # example value

}

variable "private_subnet_display_name" {
  description = "public subnet name"
  type = string
  default = "private-subnet" # example value

}

variable "internet_gateway_name" {
  description = "internet gateway name"
  type = string
  default = "internetgateway" # example value
}

variable "service_gateway_displayname" {
  description = "Service Gateway Display Name"
  type = string
  default = "servicegateway" # example value
}

variable "public_subnet_security_list_display_name" {
  description = "Public Subnet Security List Display Name"
  type = string
  default = "public_subnet_security_list" # example value
}

variable "private_subnet_security_list_display_name" {
  description = "Public Subnet Security List Display Name"
  type = string
  default = "public_subnet_security_list" # example value
}

variable "public_subnet_route_table_display_name" {
  description = "Public Subnet Route table Display Name"
  type = string
  default = "public_subnet_route_table" # example value
}

variable "private_subnet_route_table_display_name" {
  description = "Public Subnet Route table Display Name"
  type = string
  default = "private_subnet_route_table" # example value
}


# OCI Compute Instance parameters - We will use this instance to connect postgreSQL db instance

variable "compute_shape" {
  type    = string
  default = "VM.Standard.E4.Flex" # example value
}

variable "compute_cpus" {
  type    = string
  default = "1" # example value
}

variable "compute_memory_in_gbs" {
  type    = string
  default = "1" # example value
}

variable "compute_ssh_authorized_keys" {
  type = string
  default = "./certificate/id_rsa.pub"
}

variable "api_private_key_for_ssh" {
  type = string
  default = "./certificate/id_rsa"
}

variable "source_operating_system_image_id" {
  description = "Oracle Linux 8 image ocid"
  type = string
  default = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa5ww2sv5lpmouczvhp3e3udhrpngoribmotinvw734lti2avkktwa" # example value
  # if you change the region , then change the default value from the region you have selected from this document -https://docs.oracle.com/en-us/iaas/images/image/998f1273-d4fd-4e16-8673-dd2517ddd724/
}

variable "compute_instance_display_name" {
  description = "display name of the compute name"
  type = string
  default = ""
}


variable "private_subnet_security_list_disply_name" {
  description = "private_subnet_security_list_disply_name"
  type = string
  default = "Private Subnet"
}
