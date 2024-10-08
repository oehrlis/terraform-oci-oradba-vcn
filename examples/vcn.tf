# ------------------------------------------------------------------------------
# OraDBA - Oracle Database Infrastructure and Security, 5630 Muri, Switzerland
# ------------------------------------------------------------------------------
# Name.......: main.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@oradba.ch
# Editor.....: Stefan Oehrli
# Date.......: 2024.08.14
# Revision...: 
# Purpose....: Configuration to build the training vcn using oradba-vcn.
# Notes......: 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------
module "oradba-vcn" {
  source = "oehrlis/oradba-vcn/oci"
  # limit module version using ~>, allows only the rightmost version component to increment
  # e.g. 4.0.2 and 4.0.10 but not 4.1.0 see
  # https://developer.hashicorp.com/terraform/language/expressions/version-constraints
  version = "~> 0.0.1"

  # - Mandatory Parameters -----------------------------------------------------
  compartment_id = var.compartment_ocid

  # - Optional Parameters ------------------------------------------------------
  resource_name = local.resource_name # user-friendly string to name all resource. If undefined it will be derived from compartment name.

  # LAB specific parameter 
  lab_domain         = var.lab_domain          # The domain name of the LAB environment
  numberOf_labs      = var.numberOf_labs       # The number of VCNs to create
  label_prefix       = lower(var.label_prefix) # A string that will be prepended to all resources
  tags               = var.tags                # A simple key-value pairs to tag the resources created
  lab_dns_hostnum    = var.lab_dns_hostnum     # The host number for the LAB DNS server. This number is used to build the IP address using cidrhost function
  custom_dns_servers = var.custom_dns_servers  # List of custom DNS server
  lab_private_dns    = var.lab_private_dns     # A private DNS IP address for the training environment
  lab_public_dns     = var.lab_public_dns      # A public DNS IP address for the training environment

  # VCN Network parameter
  nat_gateway_enabled      = var.nat_gateway_enabled      # whether to create a nat gateway in the vcn
  internet_gateway_enabled = var.internet_gateway_enabled # whether to create the internet gateway
  service_gateway_enabled  = var.service_gateway_enabled  # whether to create a service gateway
  vcn_cidr                 = var.vcn_cidr                 # cidr block of VCN
  private_netnum           = var.private_netnum           # 0-based index of the private subnet when the VCN's CIDR is masked with the corresponding newbit value.
  private_newbits          = var.private_newbits          # The difference between the VCN's netmask and the desired private subnet mask
  public_netnum            = var.public_netnum            # 0-based index of the bastion subnet when the VCN's CIDR is masked with the corresponding newbit value.
  public_newbits           = var.public_newbits           # The difference between the VCN's netmask and the desired bastion subnet mask

  # Configure public/inbound access e.g. does create corresponding ingress rules
  inbound_ssh_access  = var.inbound_ssh_access  # Flag indicating whether public SSH access is to be granted, or not.
  inbound_ssh_port    = var.inbound_ssh_port    # Public SSH access port configured in security list.
  inbound_http_access = var.inbound_http_access # Flag indicating whether inbound HTTP/HTTPS access is to be granted, or not.
  inbound_http_port   = var.inbound_http_port   # Inbound HTTP access port configured in security list.
  inbound_https_port  = var.inbound_https_port  # Inbound HTTPS access port configured in security list.
  inbound_vpn_access  = var.inbound_vpn_access  # Flag indicating whether public OpenVPN access is to be granted, or not.
  inbound_vpn_port    = var.inbound_vpn_port    # Inbound OpenVPN access port configured in security list.
  inbound_mosh_access = var.inbound_mosh_access # Flag indicating whether public MOSH access is to be granted, or not.
  inbound_mosh_port   = var.inbound_mosh_port   # Inbound MOSH access port configured in security list.

  # Configure public/outbound access e.g. does create corresponding egress rules 
  outbound_http_access    = var.outbound_http_access    # Flag indicating whether outbound HTTP/HTTPS access is to be granted, or not.
  outbound_http_port      = var.outbound_http_port      # Outbound HTTP access port configured in security list.
  outbound_https_port     = var.outbound_https_port     # Outbound HTTPS access port configured in security list.
  outbound_port_range     = var.outbound_port_range     # Flag indicating whether outbound TCP range access is to be granted, or not.
  outbound_port_range_max = var.outbound_port_range_max # Outbound max port for TCP range access configured in security list.
  outbound_port_range_min = var.outbound_port_range_min # Outbound min port for TCP range access configured in security list.

  # Configure VCN Loggin
  log_is_enabled                       = var.log_is_enabled                       # Whether or not this resource is currently enabled.
  log_configuration_source_category    = var.log_configuration_source_category    # Log object category.
  log_configuration_source_service     = var.log_configuration_source_service     # Service generating log.
  log_configuration_source_source_type = var.log_configuration_source_source_type # The log source.
  log_retention_duration               = var.log_retention_duration               # Log retention duration in 30-day increments (30, 60, 90 and so on).
  log_type                             = var.log_type                             # The logType that the log object is for, whether custom or service.
}
# --- EOF ----------------------------------------------------------------------
