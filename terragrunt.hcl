remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    profile = "devops"
    role_arn = "arn:aws:iam::672451395673:role/terraform"
    bucket = "myatlantisdemo"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  profile = "devops"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::672451395673:role/terraform"
  }
}
EOF
}