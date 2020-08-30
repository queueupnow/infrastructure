variable "aws_region" {
  default = "us-west-2"
}
variable "aws_account_id" {
  type = string
}
variable "require_mfa" {
  default = true
}
variable "iam_groups_for_cross_account_access" {
  type = list(object({
    group_name = string
    role_arns  = list(string)
  }))
  # [
  #   {
  #     group_name = "my-group-name"
  #     role_arns = [ "arn:aws:iam::1234567890:role/my_role" ]
  #   }
  # ]
}
