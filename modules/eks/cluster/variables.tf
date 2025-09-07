variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.31"
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "cluster_iam_role_arn" {
  type = string
}

variable "cluster_sg_id" {
  type = string
}

