terraform {
  source = "git@github.com:queueupnow/infrastructure-templates.git//network/vpc?ref=v0.0.2"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cidr_block = "10.0.0.0/16"
  secondary_cidr_blocks = [
    "10.1.0.0/16",
    "10.2.0.0/16"
  ]
  azs = [
    "us-west-2a",
    "us-west-2b",
    "us-west-2c"
  ]
  public_subnets = [
    "10.0.0.0/22",
    "10.1.0.0/22",
    "10.2.0.0/22"
  ]
  private_subnets = [
    "10.0.128.0/17",
    "10.1.128.0/17",
    "10.2.128.0/17"
  ]
  intra_subnets = [
    "10.0.6.0/23",
    "10.1.6.0/23",
    "10.2.6.0/23"
  ]
  database_subnets = [
    "10.0.4.0/24",
    "10.1.4.0/24",
    "10.2.4.0/24"
  ]

  single_nat_gateway = true
  one_nat_gateway_per_az = true
}
