resource "aws_subnet" "this" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-public-${count.index + 1}"
    "kubernetes.io/role/elb"              = "1"
    "kubernetes.io/cluster/hadar"         = "owned"
  }
}
