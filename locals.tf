locals {
  app_private_subnets =  lookup(lookup(lookup({ for k, v in module.vpc.private_subnets : "subnets" => v.subnets }, "subnets", null), "app", null), "subnets",null)
  database_private_subnets =  lookup(lookup(lookup({ for k, v in module.vpc.private_subnets : "subnets" => v.subnets }, "subnets", null), "database", null), "subnets",null)
  frontend_private_subnets =  lookup(lookup(lookup({ for k, v in module.vpc.private_subnets : "subnets" => v.subnets }, "subnets", null), "frontend", null), "subnets",null)
  }
