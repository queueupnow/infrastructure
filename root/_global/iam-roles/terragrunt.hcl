terraform {
  source = "git@github.com:queueupnow/infrastructure-templates.git//security/cross-account-roles?ref=v0.0.2"
}

include {
  path = find_in_parent_folders()
}

prevent_destroy = true

inputs = {
  require_mfa_to_assume_roles = true
  allow_billing_access_from_account_arns = ["arn:aws:iam::593971421826:root"]
  allow_full_access_from_account_arns = ["arn:aws:iam::593971421826:root"]
}
