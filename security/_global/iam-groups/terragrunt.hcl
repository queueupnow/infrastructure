terraform {
  source = "git@github.com:queueupnow/infrastructure-templates.git//security/iam-groups?ref=v0.0.2"
}

include {
  path = find_in_parent_folders()
}

prevent_destroy = true

inputs = {
  require_mfa = true
  iam_groups_for_cross_account_access = [
    {
      group_name = "root-billing-access"
      role_arns = [ "arn:aws:iam::431823461389:role/cross_account_billing_access" ]
    },
    {
      group_name = "dev-full-access"
      role_arns = [ "arn:aws:iam::507625003920:role/cross_account_full_access" ]
    },
    {
      group_name = "dev-billing-access"
      role_arns = [ "arn:aws:iam::507625003920:role/cross_account_billing_access" ]
    },
    {
      group_name = "dev-dev-access"
      role_arns = [ "arn:aws:iam::507625003920:role/cross_account_dev_access" ]
    },
    {
      group_name = "dev-read-only-access"
      role_arns = [ "arn:aws:iam::507625003920:role/cross_account_read_only_access" ]
    },
    {
      group_name = "stage-full-access"
      role_arns = [ "arn:aws:iam::178696548878:role/cross_account_full_access" ]
    },
    {
      group_name = "stage-billing-access"
      role_arns = [ "arn:aws:iam::178696548878:role/cross_account_billing_access" ]
    },
    {
      group_name = "stage-dev-access"
      role_arns = [ "arn:aws:iam::178696548878:role/cross_account_dev_access" ]
    },
    {
      group_name = "stage-read-only-access"
      role_arns = [ "arn:aws:iam::178696548878:role/cross_account_read_only_access" ]
    },
    {
      group_name = "prod-full-access"
      role_arns = [ "arn:aws:iam::062394816843:role/cross_account_full_access" ]
    },
    {
      group_name = "prod-billing-access"
      role_arns = [ "arn:aws:iam::062394816843:role/cross_account_billing_access" ]
    },
    {
      group_name = "prod-dev-access"
      role_arns = [ "arn:aws:iam::062394816843:role/cross_account_dev_access" ]
    },
    {
      group_name = "prod-read-only-access"
      role_arns = [ "arn:aws:iam::prod:role/cross_account_read_only_access" ]
    },
    {
      group_name = "root-full-access"
      role_arns = [ "arn:aws:iam::431823461389:role/cross_account_full_access" ]
    },
  ]
}
