terraform {
  source = "../../..//templates/security/cross-account-roles"
}

include {
  path = find_in_parent_folders()
}

prevent_destroy = true

inputs = {
  require_mfa_to_assume_roles = true
}
