terraform {
    source = "git::https://github.com/bbhoss001/infrastructure-modules.git//keypair?ref=main"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
    env = local.env_vars.locals.env
    key_algorithm = "RSA"
    key_name = "atlantis"
    privatekey = "atlantis.pem"
}