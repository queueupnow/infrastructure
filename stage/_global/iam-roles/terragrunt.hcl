terraform {
  source = "../../..//templates/security/cross-account-roles"
}

include {
  path = find_in_parent_folders()
}

prevent_destroy = true

inputs = {
  require_mfa_to_assume_roles = true
  allow_full_access_from_account_arns = ["arn:aws:iam::593971421826:root"]
  allow_billing_access_from_account_arns = ["arn:aws:iam::593971421826:root"]
  allow_dev_access_from_account_arns = ["arn:aws:iam::593971421826:root"]
  allow_read_only_access_from_account_arns = ["arn:aws:iam::593971421826:root"]
  dev_services = ["ec2", "s3", "iam", "eks", "sqs", "sns", "msk", "lambda", "rds"]
}
