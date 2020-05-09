terraform {
  required_version = "~> 0.12.24"
  required_providers {
    aws = "~> 2.60.0"
  }
  backend "s3" {}

}

module "organizations" {
  source = "../../modules/organizations"

  service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "ssm.amazonaws.com"
  ]

  audit_root_email = "kiririmode+sandbox-audit@gmail.com"
  service_accounts = {
    "dev" = {
      email = "kiririmode+sandbox-dev@gmail.com"
    },
    "prod" = {
      email = "kiririmode+sandbox-prod@gmail.com"
    }
  }
}
