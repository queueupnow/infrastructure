resource "aws_security_group" "vpn" {
  name        = "${var.env}-vpn-sg"
  description = "security group which controls access to ${var.env} VPN host"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = "VPN"
  }
}

resource "aws_security_group_rule" "vpn_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpn.id
}

resource "aws_security_group_rule" "vpn_https_ingress" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpn.id
}

resource "aws_security_group_rule" "vpn_client_ingress" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpn.id
}

resource aws_route "public" {
  count                  = length(data.terraform_remote_state.vpc.outputs.public_route_table_ids)
  route_table_id         = data.terraform_remote_state.vpc.outputs.public_route_table_ids[count.index]
  destination_cidr_block = var.vpn_overlay_subnet
  instance_id            = module.vpn.id[0]
}

resource aws_route "private" {
  count                  = length(data.terraform_remote_state.vpc.outputs.private_route_table_ids)
  route_table_id         = data.terraform_remote_state.vpc.outputs.private_route_table_ids[count.index]
  destination_cidr_block = var.vpn_overlay_subnet
  instance_id            = module.vpn.id[0]
}

resource aws_route "intra" {
  count                  = length(data.terraform_remote_state.vpc.outputs.intra_route_table_ids)
  route_table_id         = data.terraform_remote_state.vpc.outputs.intra_route_table_ids[count.index]
  destination_cidr_block = var.vpn_overlay_subnet
  instance_id            = module.vpn.id[0]
}

resource aws_route "database" {
  count                  = length(data.terraform_remote_state.vpc.outputs.database_route_table_ids)
  route_table_id         = data.terraform_remote_state.vpc.outputs.database_route_table_ids[count.index]
  destination_cidr_block = var.vpn_overlay_subnet
  instance_id            = module.vpn.id[0]
}

resource "aws_eip" "this" {
  vpc      = true
  instance = module.vpn.id[0]

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = "VPN"
  }
}

resource "aws_route53_record" "vpn" {
  zone_id = data.terraform_remote_state.vpc.outputs.public_zone_id
  name    = "vpn"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.this.public_ip]
}

module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  instance_count = 1

  name                        = "${var.env}-vpn"
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.vpn.id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  source_dest_check           = false

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = var.volume_size
      encrypted   = var.encrypt_root_volume
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = "VPN"
  }
}
