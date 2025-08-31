locals {
    private_subnets =  lookup(lookup({ for k, v in module.vpc.subnets : "subnets" => v.subnets }, "subnets", null), "app", null)
  }
