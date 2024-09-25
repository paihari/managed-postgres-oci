variable "compartment_id" {
  description = "The OCID of the compartment where the resources will be created."
  type        = string
}


variable "private_subnet_id" {
  type        = string
}


variable "db_system_db_version" {
  description = "The version of the PostgreSQL DB system."
  type        = string
}

variable "db_system_display_name" {
  description = "The display name for the DB system."
  type        = string
}

variable "db_system_shape" {
  description = "The shape of the DB system (e.g., VM.Standard2.1, VM.Standard2.4)."
  type        = string
}

variable "db_system_storage_details_is_regionally_durable" {
  description = "Indicates whether the storage is regionally durable (true or false)."
  type        = bool
}

variable "db_system_storage_details_system_type" {
  description = "The type of system for storage (e.g., 'BlockStorage')."
  type        = string
}

# Uncomment these if needed based on your optional use case.
# variable "db_system_storage_details_availability_domain" {
#   description = "The availability domain for storage (optional)."
#   type        = string
# }

# variable "db_system_storage_details_iops" {
#   description = "The IOPS (input/output operations per second) for storage (optional)."
#   type        = number
# }

variable "db_system_credentials_password_details_password_type" {
  description = "The password type for the DB system credentials (e.g., ADMIN or APP)."
  type        = string
}

variable "db_system_credentials_password_details_password" {
  description = "The password for the DB system credentials (if specified)."
  type        = string
  sensitive   = true
}

variable "db_system_credentials_username" {
  description = "The username for the DB system credentials."
  type        = string
}

variable "db_system_instance_count" {
  description = "The number of instances in the DB system."
  type        = number
}

variable "db_system_instance_memory_size_in_gbs" {
  description = "The memory size in GBs for the DB system instance."
  type        = number
}

variable "db_system_instance_ocpu_count" {
  description = "The number of OCPUs for the DB system instance."
  type        = number
}
