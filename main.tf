module "vpc" {
  source = "./vendor/modules/vpc"
  vpc = var.vpc
  env = var.env
  management_vpc = var.management_vpc
}


module "docdb" {
  source = "./vendor/modules/docdb"
  env = var.env
  docdb = var.docdb
 subnets = local.database_private_subnets[*].id
}

#this will displays you the output of private subnets
#output "private_subnets" {
#  value = local.app_private_subnets[*].id
#}

