module "iam-groups" {
  source = "../../..//modules/security/iam-groups"

  aws_account_id                      = var.aws_account_id
  require_mfa                         = var.require_mfa
  iam_groups_for_cross_account_access = var.iam_groups_for_cross_account_access
}
