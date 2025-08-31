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

output "private_subnets" {
  value = local.app_private_subnets[*].id
}

output "public_subnets" {
  value = local.public_subnets[*].id
}
