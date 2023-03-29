variable "vpc_id" {}
variable "subnet_ids" {}
variable "cluster_name" {}
variable "node_type" {}
variable "num_node_groups" {}
variable "replicas_per_node_group" {}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.cluster_name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "redis" {
  name_prefix = "${var.cluster_name}-"
  ingress {
    from_port = 6379
    to_port   = 6379
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id             = "${var.cluster_name}-cluster"
  replication_group_description    = "${var.cluster_name} Redis cluster in cluster mode"
  engine                           = "redis"
  engine_version                   = "6.x"
  node_type                        = var.node_type
  number_cache_clusters            = 1
  automatic_failover_enabled       = true
  transit_encryption_enabled       = true
  at_rest_encryption_enabled       = true
  cache_subnet_group_name          = aws_elasticache_subnet_group.redis.name
  security_group_ids               = [aws_security_group.redis.id]
  cluster_mode {
    num_node_groups               = var.num_node_groups
    replicas_per_node_group       = var.replicas_per_node_group
  }
}
