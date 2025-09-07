resource "kubernetes_config_map_v1_data" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  force = true

  data = {
    mapUsers = yamlencode([
      {
        userarn  = "arn:aws:iam::900615189257:user/hadar"
        username = "admin"
        groups   = ["system:masters"]
      }
    ])

    mapRoles = yamlencode([
      {
        rolearn  = var.node_group_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = [
          "system:bootstrappers",
          "system:nodes"
        ]
      },
      {
        rolearn  = var.jenkins_agent_role_arn
        username = "jenkins-agent"
        groups   = [
          "system:masters"
        ]
      },
      {
        rolearn  = var.alb_controller_role_arn
        username = "alb-controller"
        groups   = [
        "system:masters"
        ]
      }

    ])
  }
}

resource "kubernetes_service_account" "alb_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = var.alb_controller_role_arn
    }
  }
}

