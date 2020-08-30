output "id" {
  description = "ID of instance"
  value       = module.vpn.id[0]
}

output "arn" {
  description = "ARN of instance"
  value       = module.vpn.arn[0]
}

output "availability_zone" {
  description = "availability zone of instance"
  value       = module.vpn.availability_zone[0]
}

output "key_name" {
  description = "key name of instance"
  value       = module.vpn.key_name[0]
}

output "public_dns" {
  description = "public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = module.vpn.public_dns[0]
}

output "public_ip" {
  description = "public IP address assigned to the instance, if applicable"
  value       = module.vpn.public_ip[0]
}

output "ipv6_address" {
  description = "assigned IPv6 address of instance"
  value       = module.vpn.ipv6_addresses[0]
}

output "primary_network_interface_id" {
  description = "ID of the primary network interface of instance"
  value       = module.vpn.primary_network_interface_id[0]
}

output "private_dns" {
  description = "private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = module.vpn.private_dns[0]
}

output "private_ip" {
  description = "private IP address assigned to the instance"
  value       = module.vpn.private_ip[0]
}

output "security_groups" {
  description = "List of associated security groups of instance"
  value       = module.vpn.security_groups
}

output "vpc_security_group_ids" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value       = module.vpn.vpc_security_group_ids
}

output "subnet_id" {
  description = "ID of VPC subnets of instance"
  value       = module.vpn.subnet_id[0]
}

output "root_block_device_volume_id" {
  description = "volume ID of root block device of instance"
  value       = module.vpn.root_block_device_volume_ids[0]
}

output "ebs_block_device_volume_ids" {
  description = "List of volume IDs of EBS block devices of instance"
  value       = module.vpn.ebs_block_device_volume_ids[0]
}

output "instance_count" {
  description = "Number of instances to launch specified as argument to this module"
  value       = module.vpn.instance_count
}

output "hostname" {
  value = aws_route53_record.vpn.fqdn
}
