terraform {
  source = "git@github.com:queueupnow/infrastructure-templates.git//kafka?ref=v0.0.2"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  kafka_version = "2.4.1"
  number_of_broker_nodes = 2
  instance_type = "kafka.t3.small"
  ebs_volume_size = 1000  # gigabytes
  additional_security_groups = []
  enable_open_monitoring = false
  enable_jmx_exporter = false
  enable_node_exporter = false
  enable_s3_logs = true
}
