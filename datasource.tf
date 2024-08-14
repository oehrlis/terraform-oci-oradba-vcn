# ------------------------------------------------------------------------------
# OraDBA - Oracle Database Infrastructur and Security, 5630 Muri, Switzerland
# ------------------------------------------------------------------------------
# Name.......: datasource.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@oradba.ch
# Editor.....: Stefan Oehrli
# Date.......: 2024.08.14
# Revision...: 
# Purpose....: Retrieve OCID for the compartment used to provide module resources
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

# Retrieve compartment information
data "oci_identity_compartment" "compartment" {
  id = var.compartment_id
}
# --- EOF ----------------------------------------------------------------------
