terraform {
    source = "git::https://github.com/bbhoss001/infrastructure-modules.git//ec2?ref=main"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
    env = local.env_vars.locals.env 
    ami = "ami-0453ec754f44f9a4a"
    instance_type = "t2.micro"
    key_name = dependency.key.outputs.key_name
    sg = ["sg-0fa5373ada9b75bf5"]
}

dependency "key" {
  config_path = "../keypair"
   mock_outputs = {
    key_name = "dummy"
   }
}