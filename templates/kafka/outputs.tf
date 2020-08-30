output "kafka_cluster_arn" {
  value = aws_msk_cluster.kafka.arn
}
output "kafka_bootstrap_brokers" {
  value = aws_msk_cluster.kafka.bootstrap_brokers
}
output "kafka_bootstrap_brokers_tls" {
  value = aws_msk_cluster.kafka.bootstrap_brokers_tls
}
output "kafka_current_version" {
  value = aws_msk_cluster.kafka.current_version
}
output "kafka_kms_key" {
  value = aws_msk_cluster.kafka.encryption_info.0.encryption_at_rest_kms_key_arn
}
output "kafka_zookeeper_connect_string" {
  value = aws_msk_cluster.kafka.zookeeper_connect_string
}
output "kafka_sg_id" {
  value = aws_security_group.kafka.id
}
output "kafka_sg_arn" {
  value = aws_security_group.kafka.arn
}
output "kafka_sg_name" {
  value = aws_security_group.kafka.name
}
