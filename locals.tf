outou "private_subnets" {
  value = [for k, v in module.vpc.private_subnets : v.subnets]
}