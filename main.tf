module "vpc" {
  source = "./vendor/modules/vpc"
  vpc = var.vpc
  env = var.env
  management_vpc = var.management_vpc
}


#module "docdb" {
#  source = "./vendor/modules/docdb"
#  env = var.env
#  docdb = var.docdb
# subnets = lookup(local.subnets, "app", null)
#}

output "app_private_subnets" {
  value = local.private_subnets[*].id
}

