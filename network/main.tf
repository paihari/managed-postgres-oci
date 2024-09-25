resource oci_core_vcn psql_vcn_tf {
    compartment_id = var.compartment_id

    #Optional
    cidr_block = var.vcn_cidr_block
    display_name = var.vcn_display_name
}

resource oci_core_subnet public_subnet {
    #Required
    cidr_block = var.public_subnet_cidr_block
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.psql_vcn_tf.id

    #Optional
    display_name = var.public_subnet_display_name
    route_table_id = oci_core_route_table.tf_public_route_table.id
}

resource oci_core_subnet private_subnet {
    #Required
    cidr_block = var.private_subnet_cidr_block
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.psql_vcn_tf.id

    display_name = var.private_subnet_display_name
    route_table_id = oci_core_route_table.tf_private_route_table.id
    prohibit_internet_ingress = true
    security_list_ids = [oci_core_security_list.tf_private_security_list.id]
}

resource oci_core_internet_gateway vcntf_igw {
  vcn_id       = oci_core_vcn.psql_vcn_tf.id
  compartment_id = var.compartment_id
  display_name = var.internet_gateway_name
}

resource oci_core_nat_gateway tf_nat_gateway {
  vcn_id       = oci_core_vcn.psql_vcn_tf.id
  compartment_id = var.compartment_id
  display_name = "example-ngw"
  # Add route tables to direct traffic through this NAT gateway
}

data oci_core_services test_services {
}

variable create_service_gateway {
  description = "creates a service gateway."
  default     = true
  type        = bool
}

# data "oci_core_services" "all_oci_services" {
#   filter {
#     name   = "name"
#     values = ["All .* Services In Oracle Services Network"]
#     regex  = true
#   }

#   count = var.create_service_gateway == true ? 1 : 0
# }

data "oci_core_services" "all_services" {
    
}

resource oci_core_service_gateway service_gateway {
  compartment_id = var.compartment_id
  display_name   = var.service_gateway_displayname
  services {
    # service_id = lookup(data.oci_core_services.all_oci_services[0].services[0], id)
    service_id = data.oci_core_services.all_services.services[0].id
  }
  vcn_id = oci_core_vcn.psql_vcn_tf.id
  count = var.create_service_gateway == true ? 1 : 0
}

resource oci_core_security_list tf_public_security_list {
  vcn_id         = oci_core_vcn.psql_vcn_tf.id
  compartment_id = var.compartment_id
  display_name   = var.public_subnet_security_list_display_name

  ingress_security_rules {
    protocol    = 6  # TCP protocol for SSH
    source      = "0.0.0.0/0"  # Allow inbound traffic from all sources
    tcp_options {
            #Optional
            max = 22
            min = 22
        }
    description = "Allow SSH from all sources"
  }
}

resource oci_core_security_list tf_private_security_list {
  vcn_id         = oci_core_vcn.psql_vcn_tf.id
  compartment_id = var.compartment_id
  display_name   = var.private_subnet_security_list_disply_name

  ingress_security_rules {
    protocol    = 6  # TCP protocol to connect Postgress service from compute instance in public subnet
    source      = oci_core_vcn.psql_vcn_tf.cidr_block  # Allow inbound traffic from CIDR Block of VCN sources
    tcp_options {
            #Optional
            max = 5432
            min = 5432
        }
    description = "Allow psql service connections from all ranges cidr vcn"
  }
}

resource oci_core_route_table tf_public_route_table {
  vcn_id     = oci_core_vcn.psql_vcn_tf.id
  compartment_id = var.compartment_id
  display_name = var.public_subnet_route_table_display_name
  route_rules {
    // Define route rules for public subnet
    network_entity_id = oci_core_internet_gateway.vcntf_igw.id
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}

resource oci_core_route_table tf_private_route_table {
  vcn_id     = oci_core_vcn.psql_vcn_tf.id
  compartment_id = var.compartment_id
  display_name = var.private_subnet_route_table_display_name
  route_rules {
    // Define route rules for private subnet
    network_entity_id = oci_core_nat_gateway.tf_nat_gateway.id
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
  route_rules {
    network_entity_id = oci_core_service_gateway.service_gateway.0.id
    destination = "all-fra-services-in-oracle-services-network"
    destination_type  = "SERVICE_CIDR_BLOCK"
  }
  }

resource oci_core_route_table_attachment public_route_table_attachment {
  #Required
  subnet_id = oci_core_subnet.public_subnet.id
  route_table_id =oci_core_route_table.tf_public_route_table.id
}

resource oci_core_route_table_attachment private_route_table_attachment {
  #Required
  subnet_id = oci_core_subnet.private_subnet.id
  route_table_id =oci_core_route_table.tf_private_route_table.id
  depends_on = [oci_core_service_gateway.service_gateway]
}
