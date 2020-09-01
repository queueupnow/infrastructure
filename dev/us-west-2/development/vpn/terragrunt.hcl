terraform {
  source = "git@github.com:queueupnow/infrastructure-templates.git//network/vpn?ref=v0.0.2"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  ami = "ami-066a70f4924af7ba1"
  instance_type = "t2.micro"
  key_name = "dev"
  vpn_overlay_subnet = "100.127.255.0/24"
}
