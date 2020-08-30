resource "aws_route53_zone" "public" {
  name = "${var.env}.${var.tld}"

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = var.env
  }
}

resource "aws_route53_zone" "vpc" {
  name = "int.${var.env}.${var.tld}"

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = var.env
  }
}

resource "aws_route53_record" "vpc" {
  zone_id = aws_route53_zone.public.zone_id
  name = "int.${var.env}.${var.tld}"
  type = "NS"
  ttl = "300"
  records = aws_route53_zone.public.name_servers
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                         = var.env
  cidr                         = var.cidr_block
  secondary_cidr_blocks        = var.secondary_cidr_blocks
  azs                          = var.azs
  private_subnets              = var.private_subnets
  public_subnets               = var.public_subnets
  intra_subnets                = var.intra_subnets
  database_subnets             = var.database_subnets
  create_database_subnet_group = var.create_database_subnet_group
  enable_dns_hostnames         = var.enable_dns_hostnames
  enable_dns_support           = var.enable_dns_support

  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  enable_vpn_gateway = var.enable_vpn_gateway

  enable_s3_endpoint       = var.enable_s3_endpoint
  enable_dynamodb_endpoint = var.enable_dynamodb_endpoint

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = var.env
  }
}
