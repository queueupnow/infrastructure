data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    region = var.terraform_state_region
    bucket = var.terraform_state_bucket
    key    = "${var.aws_region}/${var.environment}/vpc/terraform.tfstate"
  }
}
