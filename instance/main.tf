# data "oci_identity_availability_domains" "ads" {
#   compartment_id = var.compartment_id
# }

resource "oci_core_instance" "tf_compute" {
  # Required
  # availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  availability_domain = "vWQc:EU-FRANKFURT-1-AD-1"
  compartment_id      = var.compartment_id
  shape               = var.compute_shape
  source_details {
    source_id         = var.source_operating_system_image_id
    source_type       = "image"
  }
  display_name        = var.compute_instance_display_name
  shape_config {
    ocpus         = var.compute_cpus
    memory_in_gbs = var.compute_memory_in_gbs
  }
  create_vnic_details {
    subnet_id = var.public_subnet_id
    assign_public_ip  = true
  }
  metadata = {
    ssh_authorized_keys = file(var.compute_ssh_authorized_keys)
    #  ssh_authorized_keys = var.compute_ssh_authorized_keys
  }
  preserve_boot_volume = false
  provisioner "remote-exec" {
    inline = [
      "sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm",
      "sudo dnf -qy module disable postgresql",
      "sudo dnf install -y postgresql16-server",
      "sudo /usr/pgsql-16/bin/postgresql-16-setup initdb",
      "sudo systemctl enable postgresql-16",
      "sudo systemctl start postgresql-16"
    ]
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "opc"
      private_key = file(var.api_private_key_for_ssh)
      # private_key = var.api_private_key_for_ssh   
    }
  }

}

# Outputs
output "compute_id" {
  value = oci_core_instance.tf_compute.id
}

output "compute_state" {
  value = oci_core_instance.tf_compute.state
}

output "compute_public_ip" {
  value = oci_core_instance.tf_compute.public_ip
}


