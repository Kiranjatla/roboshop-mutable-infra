module "vpc" {
  source = "github.com/Kiranjatla/tf-module-vpc?ref=${var.ver}"
}

variable "ver"{}