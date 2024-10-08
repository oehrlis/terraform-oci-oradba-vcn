# ------------------------------------------------------------------------------
# OraDBA - Oracle Database Infrastructure and Security, 5630 Muri, Switzerland
# ------------------------------------------------------------------------------
# Name.......: logging.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@oradba.ch
# Editor.....: Stefan Oehrli
# Date.......: 2024.08.14
# Revision...: 
# Purpose....: Define OCI Log Group for private subnet.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

# create the log group ---------------------------------------------------------
resource "oci_logging_log_group" "log_group" {
  count          = var.numberOf_labs
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? format("${local.resource_shortname}%02d_log_group", count.index) : format("${var.label_prefix}-${local.resource_shortname}%02d_log_group", count.index)
  freeform_tags  = var.tags
}

# create a default log ---------------------------------------------------------
resource "oci_logging_log" "default_log_private_subnet" {
  count        = var.numberOf_labs
  display_name = var.label_prefix == "none" ? format("${local.resource_shortname}%02d_log_private_subnet", count.index) : format("${var.label_prefix}-${local.resource_shortname}%02d_log_private_subnet", count.index)
  log_group_id = oci_logging_log_group.log_group[count.index].id
  log_type     = var.log_type

  configuration {
    source {
      category    = var.log_configuration_source_category
      resource    = oci_core_subnet.private_subnet[count.index].id
      service     = var.log_configuration_source_service
      source_type = var.log_configuration_source_source_type
    }

    compartment_id = var.compartment_id
  }
  freeform_tags      = var.tags
  is_enabled         = var.log_is_enabled
  retention_duration = var.log_retention_duration
}

# create a default log ---------------------------------------------------------
resource "oci_logging_log" "default_log_public_subnet" {
  count        = var.numberOf_labs
  display_name = var.label_prefix == "none" ? format("${local.resource_shortname}%02d_log_public_subnet", count.index) : format("${var.label_prefix}-${local.resource_shortname}%02d_log_public_subnet", count.index)
  log_group_id = oci_logging_log_group.log_group[count.index].id
  log_type     = var.log_type

  configuration {
    source {
      category    = var.log_configuration_source_category
      resource    = oci_core_subnet.public_subnet[count.index].id
      service     = var.log_configuration_source_service
      source_type = var.log_configuration_source_source_type
    }

    compartment_id = var.compartment_id
  }
  freeform_tags      = var.tags
  is_enabled         = var.log_is_enabled
  retention_duration = var.log_retention_duration
}

# --- EOF ----------------------------------------------------------------------
