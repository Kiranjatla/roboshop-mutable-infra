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
  private_zone_id           = var.private_zone_id
}

module "docdb" {
  for_each = var.docdb
  source = "./vendor/modules/docdb"
  name = each.key
  engine = each.value.engine
  env = var.env
 subnets = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  nodes               = each.value.nodes
  skip_final_snapshot = each.value.skip_final_snapshot
  vpc_id              = element([for i, j in module.vpc : j.vpc_id], 0)
  vpc_cidr            = element([for i, j in module.vpc : j.vpc_cidr], 0)
  BASTION_NODE        = var.BASTION_NODE
}

#output "app_subnets" {
#value = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
#}

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
  nodes               = each.value.nodes
  skip_final_snapshot = each.value.skip_final_snapshot
  vpc_id              = element([for i, j in module.vpc : j.vpc_id], 0)
  vpc_cidr            = element([for i, j in module.vpc : j.vpc_cidr], 0)
  BASTION_NODE        = var.BASTION_NODE
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
  vpc_id              = element([for i, j in module.vpc : j.vpc_id], 0)
  vpc_cidr            = element([for i, j in module.vpc : j.vpc_cidr], 0)
}


module "rabbitmq" {
  source          = "./vendor/modules/rabbitmq"
  for_each        = var.rabbitmq
  env             = var.env
  subnets         = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  name            = each.key
  instance_type   = each.value.instance_type
  private_zone_id = var.private_zone_id
  vpc_id              = element([for i, j in module.vpc : j.vpc_id], 0)
  vpc_cidr            = element([for i, j in module.vpc : j.vpc_cidr], 0)
  BASTION_NODE        = var.BASTION_NODE
}

module "apps" {
  source        = "./vendor/modules/app-setup"
  env           = var.env
  subnets       = each.key == "frontend" ? flatten([for i, j in module.vpc : j.private_subnets["frontend"]["subnets"][*].id]) : flatten([for i, j in module.vpc : j.private_subnets["app"]["subnets"][*].id])
  for_each      = var.apps
  name          = each.key
  instance_type = each.value.instance_type
  min_size      = each.value.min_size
  max_size      = each.value.max_size
  lb_listener_priority = each.value.lb_listener_priority
  type                 = each.value.type
  vpc_id        = element([for i, j in module.vpc : j.vpc_id], 0)
  BASTION_NODE = var.BASTION_NODE
  app_port_no = each.value.app_port_no
  PROMETHEUS_NODE = var.PROMETHEUS_NODE
  vpc_cidr = element([for i, j in module.vpc : j.vpc_cidr], 0)
  alb = module.alb
  private_zone_id      = var.private_zone_id
  public_dns_name      = try(each.value.public_dns_name, null)
  public_zone_id       = var.public_zone_id
  ACM_ARN = var.ACM_ARN

}

module "alb" {
  source   = "./vendor/modules/alb"
  for_each = local.merged_alb
  env      = var.env
  subnets  = each.value.subnets
  name     = each.key
  vpc_id   = element([for i, j in module.vpc : j.vpc_id], 0)
  vpc_cidr = element([for i, j in module.vpc : j.vpc_cidr], 0)
  internal = each.value.internal
}

#output "test" {
#  value = local.merged_alb
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

