variable "compartment_id" {
  description = "The OCID of the compartment where the resources will be created."
  type        = string
}

variable "public_subnet_id" {
  type        = string
}

variable "compute_shape" {
  description = "The shape of the compute instance (e.g., VM.Standard2.1)."
  type        = string
}

variable "source_operating_system_image_id" {
  description = "The OCID of the operating system image to be used for the compute instance."
  type        = string
}

variable "compute_instance_display_name" {
  description = "The display name for the compute instance."
  type        = string
}

variable "compute_cpus" {
  description = "The number of OCPUs to allocate for the compute instance."
  type        = number
  default     = 1
}

variable "compute_memory_in_gbs" {
  description = "The amount of memory (in GBs) to allocate for the compute instance."
  type        = number
  default     = 8
}

variable "compute_ssh_authorized_keys" {
  description = "Path to the SSH public key file to be used for authentication on the compute instance."
  type        = string
}

variable "api_private_key_for_ssh" {
  description = "Path to the private key file to be used for SSH access to the compute instance."
  type        = string
}
