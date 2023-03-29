provider "aws" {
  region = "us-east-1"
}

module "redis_cluster" {
  source = "./modules/elasticache_redis_cluster"

  vpc_id                   = aws_vpc.redis.id
  subnet_ids               = aws_subnet.private.*.id
  cluster_name             = var.cluster_name
  node_type                = var.node_type
  num_node_groups          = var.num_node_groups
  replicas_per_node_group  = var.replicas_per_node_group
}

resource "aws_vpc" "redis" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private" {
  count = 2
  cidr_block = "10.0.${count.index+1}.0/24"
  availability_zone = "us-east-1a"
  vpc_id = aws_vpc.redis.id
}