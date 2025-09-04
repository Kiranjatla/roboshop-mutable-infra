module "vpc" {
  for_each                  = var.vpc
  source                    = "./vendor/modules/vpc"
  cidr_block                = each.value.cidr_block
  additional_cidr_block     = each.value.additional_cidr_block
  private_subnets           = each.value.private_subnets
  public_subnets            = each.value.public_subnets
  subnet_availability_zones = each.value.subnet_availability_zones
  env                       = var.env
  management_vpc            = var.management_vpc
  #  private_zone_id           = var.private_zone_id
}

module "docdb" {
  for_each = var.docdb
  source = "./vendor/modules/docdb"
  name = each.key
  engine = each.value.engine
  env = var.env
 subnets = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
}

output "app_subnets" {
value = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
}

module "rds" {
  source = "./vendor/modules/rds"
  for_each = var.rds
  env = var.env
  subnets             = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  name                = each.key
  allocated_storage   = each.value.allocated_storage
  engine              = each.value.engine
  engine_version      = each.value.engine_version
  instance_class      = each.value.instance_class
  skip_final_snapshot = each.value.skip_final_snapshot
}

module "elasticache" {
  source          = "./vendor/modules/elasticache"
  for_each        = var.elasticache
  env             = var.env
  subnets         = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  name            = each.key
  engine          = each.value.engine
  engine_version  = each.value.engine_version
  node_type       = each.value.node_type
  num_cache_nodes = each.value.num_cache_nodes
}


module "rabbitmq" {
  source          = "./vendor/modules/rabbitmq"
  for_each        = var.rabbitmq
  env             = var.env
  subnets         = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  name            = each.key
  instance_type   = each.value.instance_type
}

#module "apps" {
#  source        = "./vendor/modules/app-setup"
#  env           = var.env
#  subnets       = flatten([for i, j in module.vpc : j.private_subnets["app"]["subnets"][*].id])
#  for_each      = var.apps
#  name          = each.key
#  instance_type = each.value.instance_type
#}










#module "vpc" {
#  source = "./vendor/modules/vpc"
#  vpc = var.vpc
#  env = var.env
#  management_vpc = var.management_vpc
#}
#
#module "docdb" {
#  source = "./vendor/modules/docdb"
#  docdb = var.docdb
#  env = var.env
# subnets = local.database_private_subnets[*].id
#}
#
#module "rds" {
#  source = "./vendor/modules/rds"
#  rds = var.rds
#  env = var.env
#  subnets = local.database_private_subnets[*].id
#}
##this will displays you the output of private subnets
##output "private_subnets" {
##  value = local.app_private_subnets[*].id
##}

