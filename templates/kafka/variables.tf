variable "terraform_state_region" {
  type = string
}
variable "terraform_state_bucket" {
  type = string
}
variable "aws_region" {
  type = string
}
variable "environment" {
  type = string
}
variable "env" {
  type = string
}
variable "kafka_version" {
  default = "2.4.1"
}
variable "number_of_broker_nodes" {
  type = number
}
variable "instance_type" {
  default = "kafka.t3.small"
}
variable "ebs_volume_size" {
  default = 1000
}
variable "additional_security_groups" {
  default = []
  type    = list(string)
}
variable "enable_open_monitoring" {
  default = false
}
variable "enable_jmx_exporter" {
  default = false
}
variable "enable_node_exporter" {
  default = false
}
variable "enable_cloudwatch_logs" {
  default = false
}
variable "cloudwatch_log_group" {
  default = ""
}
variable "enable_s3_logs" {
  default = true
}
