#!/usr/bin/env bash

set -o errexit
# set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

SHORT_ARGS="n"
ARGS_LONG="name:"

while getopts ":n:" option; do
    case "$option" in
        n)
            NAME=$2
            shift 2
            ;;
        *)
            echo ''
            echo >&2 Unsupported option: "$1"
            echo ''
            exit 1
            ;;
    esac
done

main() {
    mkdir -p "$NAME"
    cat >"./$NAME/main.tf" <<EOF
// Main Terraform configuration file
EOF
    cat >"./$NAME/variables.tf" <<EOF
// Variables definition file
variable "backend_state" {
  type    = string
  default = ""
}

variable "backend" {
  type    = string
  default = ""
}

variable "account" {
  type    = string
  default = "dev"
}

variable "common_tags" {
  type = map(string)
  default = {
    Client     = ""
    Project    = ""
    Stage      = "dev"
    DevOpsTool = "tofu"
  }
}
EOF
    cat >"./$NAME/outputs.tf" <<EOF
// Outputs definition file
EOF
    cat >"./$NAME/README.md" <<EOF
# $NAME Module
This module is used to ...
EOF
    cat >"./$NAME/backend.tf" <<EOF
// Backend configuration file
terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = var.backend
    key = join("/",
      [
        var.common_tags["Stage"],
        var.common_tags["Client"],
        var.common_tags["Project"],
        var.backend_state
    ])
    region       = "eu-west-1"
    workspace_key_prefix = "environments"
    use_lockfile = true # Enable native S3 locking
  }
}

# Done for deploy with workspaces
variable "workspace_role_arns" {
  description = "A map of workspace names to IAM role ARNs."
  type        = map(string)
  default = {
    "dev"     = "arn:aws:iam::305410271972:role/opentofu-deploy",
    "staging" = "arn:aws:iam::623956215528:role/opertofu-deploy",
    "prod"    = "arn:aws:iam::623956215528:role/opertofu-deploy"
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = var.common_tags
  }
  assume_role {# Done for deploy with workspaces
    role_arn = "\${var.workspace_role_arns[var.account]}"
  }
}
EOF
    echo "Tofu module $NAME created successfully."
}

main "$@"
