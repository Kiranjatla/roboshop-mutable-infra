module "vpc" {
  source = "./vendor/modules/vpc"
  vpc = var.vpc
  env = var.env
  management_vpc = var.management_vpc
}


module "docdb" {
  source = "./vendor/modules/docdb"
  docdb = var.docdb
  env = var.env
 subnets = local.database_private_subnets[*].id
}

moduel "rds" {
  source = "./vendor/modules/rds"
  rds = var.rds
  env = var.env
  subnets = local.database_private_subnets[*].id
}
#this will displays you the output of private subnets
#output "private_subnets" {
#  value = local.app_private_subnets[*].id
#}

