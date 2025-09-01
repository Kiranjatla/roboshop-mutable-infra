#locals {
#  app_private_subnets =  lookup(lookup(lookup({ for k, v in module.vpc.private_subnets : "subnets" => v.subnets }, "subnets", null), "app", null), "subnets",null)
#  database_private_subnets =  lookup(lookup(lookup({ for k, v in module.vpc.private_subnets : "subnets" => v.subnets }, "subnets", null), "database", null), "subnets",null)
#  frontend_private_subnets =  lookup(lookup(lookup({ for k, v in module.vpc.private_subnets : "subnets" => v.subnets }, "subnets", null), "frontend", null), "subnets",null)
#  public_subnets = lookup(lookup(lookup({ for k, v in module.vpc.public_subnets : "subnets" => v.subnets }, "subnets", null), "public", null), "subnets",null)
#}
#
##this will displays you the output of public subnets
##output "public_subnets" {
##  value = local.public_subnets[*].id
##}