

module "cross-account-roles" {
  source = "../../..//modules/security/cross-account-roles"

  aws_account_id = var.aws_account_id

  require_mfa_to_assume_roles = var.require_mfa_to_assume_roles

  allow_full_access_from_account_arns      = var.allow_full_access_from_account_arns
  allow_billing_access_from_account_arns   = var.allow_billing_access_from_account_arns
  allow_dev_access_from_account_arns       = var.allow_dev_access_from_account_arns
  allow_read_only_access_from_account_arns = var.allow_read_only_access_from_account_arns

  dev_services = var.dev_services
}
