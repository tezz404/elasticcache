variable "vpc_id" {}
variable "subnet_ids" {}
variable "cluster_name" {
    default = "dev-redis-cluster"
}
variable "node_type" {
  description = "The cache node type"
  type        = string
  default     = "cache.t2.small"
}
variable "num_node_groups" {
  description = "The number of node groups for the cluster"
  type        = number
  default     = 2
}
variable "replicas_per_node_group" {
  description = "The number of replicas per node group for the cluster"
  type        = number
  default     = 2
}

variable "vpc_name" {
  description = "vpc name"
  type        = string
  default     = "dev-vpc"
}