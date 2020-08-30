resource "aws_s3_bucket" "logs-bucket" {
  count  = var.enable_s3_logs ? 1 : 0
  bucket = "voter-place-msk-broker-logs-${var.env}"
  acl    = "private"

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = "voter-place-msk-broker-logs-${var.env}"
  }
}

resource "aws_kms_key" "kafka" {
  description = "${var.env} kafka broker encryption-at-rest key"

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = "Kafka"
  }
}

resource "aws_security_group" "kafka" {
  name        = "${var.env}-kafka-sg"
  description = "security group which controls access to ${var.env} kafka cluster"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = "Kafka"
  }
}

resource "aws_security_group_rule" "kafka_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kafka.id
}

resource "aws_security_group_rule" "kafka_ingress" {
  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"
  cidr_blocks = concat([data.terraform_remote_state.vpc.outputs.vpc_cidr_block],
  data.terraform_remote_state.vpc.outputs.vpc_secondary_cidr_blocks)
  security_group_id = aws_security_group.kafka.id
}

resource "aws_msk_cluster" "kafka" {
  cluster_name           = "voter-place-${var.env}"
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.instance_type
    ebs_volume_size = var.ebs_volume_size
    client_subnets = slice(data.terraform_remote_state.vpc.outputs.private_subnets,
      0,
      min(var.number_of_broker_nodes,
    length(data.terraform_remote_state.vpc.outputs.private_subnets)))
    security_groups = concat([aws_security_group.kafka.id],
    var.additional_security_groups)
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.kafka.arn
  }

  dynamic "open_monitoring" {
    for_each = var.enable_open_monitoring ? ["enable"] : []
    content {
      prometheus {
        jmx_exporter {
          enabled_in_broker = var.enable_jmx_exporter
        }
        node_exporter {
          enabled_in_broker = var.enable_node_exporter
        }
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = var.enable_cloudwatch_logs
        log_group = var.cloudwatch_log_group
      }
      s3 {
        enabled = var.enable_s3_logs
        bucket  = var.enable_s3_logs ? aws_s3_bucket.logs-bucket[0].id : ""
        prefix  = "logs/msk-"
      }
    }
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = "voter-place-${var.env}"
  }
}
