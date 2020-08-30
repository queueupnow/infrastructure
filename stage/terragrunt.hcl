# Terragrunt is a thin wrapper around terraform which provides extra tools for
# a DRY workflow for working with terraform.  The backend declaration here is
# merged with the terragrunt.hcl file where terragrunt is actually run, so
# path_to_relative_include() resolves to the full path between this dir and 
# that one, giving a key that is the same as the relative path difference
# between this dir and the dir where terragrunt was run.
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "voter-place-stage-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "skip"
  }
}

# When using this terragrunt config, terragrunt will generate the file "provider.tf"
# with the aws provider block before calling to terraform. Note that this will
# skip writing the `provider.tf` file if it already exists.
generate "provider" {
  path      = "providers.tf"
  if_exists = "skip"
  contents  = <<EOF
terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region  = var.aws_region
}
EOF
}

# this terraform block gets merged with the terraform block in the leaf teragrunt.hcl
# file It sets an extended timeout for acquiring the remote_state lock
terraform {
  # Force Terraform to keep trying to acquire a lock for up to 20 minutes if someone
  # else already has the lock
  extra_arguments "retry_lock" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=20m"]
  }
}

# The inputs block gets merged with inputs in terragrunt.hcl where terragrunt
# was run. In here, we grab any variables declared in ./shared.yaml and 
# app.yaml in the same directory where terragrunt was run, and merge them with
# any static values declared here.  The values in the calling directory take
# precedence so you can override the shared values.
inputs = merge(
  yamldecode(
    file("${find_in_parent_folders("account.yaml", "${get_parent_terragrunt_dir()}/empty.yaml")}"),
  ),
  yamldecode(
    file("${find_in_parent_folders("region.yaml", "${get_parent_terragrunt_dir()}/empty.yaml")}"),
  ),
  yamldecode(
    file("${find_in_parent_folders("env.yaml", "${get_parent_terragrunt_dir()}/empty.yaml")}"),
  ),
  {
    # You can add variable values here, but more consistent to populate ./account.yaml
  }
)
