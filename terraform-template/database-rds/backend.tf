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
    role_arn = "${var.workspace_role_arns[var.account]}"
  }
}
