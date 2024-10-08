# Terraform LAB VCN for OCI

## Introduction

A reusable and extensible Terraform module that provisions a LAB VCN on *Oracle Cloud Infrastructure (OCI)*.

It creates the following resources:

- A VCN with customizable CIDR block
- An optional internet gateway
- An optional NAT gateway
- An optional service gateway
- Optional n-number of VCNs. This is used to build several identical environments for a training and laboratory environment.

The module can be parametrized by the number of participants. This will then create n-VCNs. The following figure shows a VCN for the compartment O-SEC. i.e. `resource_name` has been derivated from compartment name.

![VCN architecture overview](https://github.com/oehrlis/terraform-oci-oradba-vcn/raw/main/doc/images/architecture.png)

## Prerequisites

- An OCI account
- Install [Terraform](https://www.terraform.io/downloads.html)
- Create a Terraform Configuration

**HINT** This terraform module does use `count` to create multiple identical resources. Due to this at least Terraform version 0.13.0+ is required.

## Quickstart

The module is available in [Terraform registry](https://registry.terraform.io/modules/oehrlis/oradba-vcn/oci/latest). You may either us it via registry or clone [terraform-oci-oradba-vcn](https://github.com/oehrlis/terraform-oci-oradba-vcn) from github.

Add the module to the `main.tf` with the mandatory parameter.

```bash
module "oradba-vcn" {
  source  = "oehrlis/oradba-vcn/oci"
  version = ">= 1.0.0"

  # - Mandatory Parameters --------------------------------------------------
  region         = var.region
  compartment_id = var.compartment_id
}
```

To create multiple VCNs just specify the `numberOf_labs` parameter. The following example will create 3 equal VCN where each VCN is named according its number and the compartment or if specified according to the variable `resource_name`. e.g. for a compartment O-SEC it will create VCN *osec00*, *osec01* and *osec02*. The naming schema will also be used for all other resources.

```bash
module "oradba-vcn" {
  source  = "oehrlis/oradba-vcn/oci"
  version = ">= 1.0.0"

  # - Mandatory Parameters --------------------------------------------------
  region            = var.region
  compartment_id    = var.compartment_id
  numberOf_labs  = 3
}
```

The module can be customized by a couple of additional parameter. See [variables](./doc/variables.md) for more information about customisation. The folder [examples](examples) does contain an example files for [main.tf](examples/main.tf), [variables.tv](examples/variables.tf) and [terraform.tfvars](examples/terraform.tfvars.example).

## Security Configuration

The VCN will be configured with a security list allowing the following access:

- ~~Port **22** inbound SSH traffic~~ disabled by default
- ~~Port **80** inbound HTTP traffic~~ disabled by default
- ~~Port **443** inbound HTTPS traffic~~ disabled by default
- ~~Port **6000-6010** inbound MOSH traffic via UTP~~ disabled by default
- All protocols in private subnet
- All protocols in between public and private subnet
- All protocols for outbound traffic

## Related Documentation, Blog

- [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/iaas/Content/home.htm)
- [Terraform OCI Provider Documentation](https://www.terraform.io/docs/providers/oci/index.html)
- [Terraform Creating Modules](https://www.terraform.io/docs/modules/index.html)

## Projects using this module

- [terraform-oci-oradba-base](https://github.com/oehrlis/terraform-oci-oradba-base) A reusable and extensible Terraform module that provisions a LAB on Oracle Cloud Infrastructure.

## Releases and Changelog

You find all releases and release information [here](https://github.com/oehrlis/terraform-oci-oradba-vcn/releases).

## Issues

Please file your bug reports, enhancement requests, questions and other support requests within [Github's issue tracker](https://help.github.com/articles/about-issues/).

- [Questions](https://github.com/oehrlis/terraform-oci-oradba-vcn/issues?q=is%3Aissue+label%3Aquestion)
- [Open enhancements](https://github.com/oehrlis/terraform-oci-oradba-vcn/issues?q=is%3Aopen+is%3Aissue+label%3Aenhancement)
- [Open bugs](https://github.com/oehrlis/terraform-oci-oradba-vcn/issues?q=is%3Aopen+is%3Aissue+label%3Abug)
- [Submit new issue](https://github.com/oehrlis/terraform-oci-oradba-vcn/issues/new)

## How to Contribute

1. Describe your idea by [submitting an issue](https://github.com/oehrlis/terraform-oci-oradba-vcn/issues/new)
2. [Fork this respository](https://github.com/oehrlis/terraform-oci-oradba-vcn/fork)
3. [Create a branch](https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/), commit and publish your changes and enhancements
4. [Create a pull request](https://help.github.com/articles/creating-a-pull-request/)

## Acknowledgement

Code derived and adapted from [oracle-terraform-modules/terraform-oci-vcn](https://github.com/oracle-terraform-modules/terraform-oci-vcn) and Hashicorp's [Terraform 0.12 examples](https://github.com/terraform-providers/terraform-provider-oci/tree/master/examples).

## License

Copyright (c) 2024 OraDBA and/or its associates. All rights reserved.

The Terraform modules are licensed under the Apache License, Version 2.0. You may obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>.
