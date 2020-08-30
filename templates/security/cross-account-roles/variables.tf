variable "aws_region" {
  default = "us-west-2"
}

variable "aws_account_id" {
  type = string
}

variable "require_mfa_to_assume_roles" {
  default = true
}

variable "allow_full_access_from_account_arns" {
  type    = list(string)
  default = []
}

variable "allow_billing_access_from_account_arns" {
  type    = list(string)
  default = []
}

variable "allow_dev_access_from_account_arns" {
  type    = list(string)
  default = []
}

variable "allow_read_only_access_from_account_arns" {
  type    = list(string)
  default = []
}

variable "dev_services" {
  type    = list(string)
  default = []
}
