env = "dev"

vpc = {
  vpc1 = {
    cidr_block            = "10.0.0.0/16"
    additional_cidr_block = []
#    additional_cidr_block = [10.1.0.0/16]  (if you want additional cidr just uncomment this)
    private_subnets = {
      frontend = {
        cidr_block = ["10.0.0.0/24", "10.0.1.0/24"]
        name       = "frontend"
        attach_to  = "ngw"
      }
      database = {
        cidr_block = ["10.0.2.0/24", "10.0.3.0/24"]
        name       = "database"
        attach_to  = "ngw"
      }
      app = {
        cidr_block = ["10.0.4.0/24", "10.0.5.0/24"]
        name       = "app"
        attach_to  = "ngw"
      }
    }
    public_subnets = {
      public = {
        cidr_block = ["10.0.255.0/24", "10.0.254.0/24"]
        name      = "public"
        attach_to = "igw"
      }
    }
    subnet_availability_zones = ["us-east-1a", "us-east-1b"]
  }}
 management_vpc = {
  vpc_id = "vpc-0e9cafb191c019955"
  route_table = "rtb-0a069e77621f9b019"
  vpc_cidr = "172.31.0.0/16"
}

docdb = {
  db1 = {
    engine = "docdb"
    skip_final_snapshot = true
    nodes = {
      one = {
        instance_class = "db.t3.medium"
      }
    }
  }
}

rds = {
  db1 = {
    allocated_storage   = 10
    engine              = "aurora-mysql"
    engine_version      = "5.7.mysql_aurora.2.11.2"
    instance_class      = "db.t3.micro"
#    parameter_group_name = "default.mysql5.7"
    skip_final_snapshot = true
    nodes = {
      one = {
        instance_class = "db.t3.medium"
      }
    }
  }}

elasticache = {
  ec1 = {
    engine          = "redis"
    engine_version  = "6.2"
    node_type       = "cache.t3.micro"
    num_cache_nodes = 1
  }
}

rabbitmq = {
  mq1 = {
    instance_type = "t3.micro"
  }
}

apps = {
  cart = {
    instance_type = "t3.micro"
    max_size      = 1
    min_size      = 1
    app_port_no   = 8080
    lb_listener_priority = 100
    type                 = "backend"
  }
  catalogue = {
    instance_type = "t3.micro"
    max_size      = 1
    min_size      = 1
    app_port_no   = 8080
    lb_listener_priority = 101
    type                 = "backend"
  }
  user = {
    instance_type = "t3.micro"
    max_size      = 1
    min_size      = 1
    app_port_no   = 8080
    lb_listener_priority = 102
    type                 = "backend"
  }
  shipping = {
    instance_type = "t3.micro"
    max_size      = 1
    min_size      = 1
    app_port_no   = 8080
    lb_listener_priority = 103
    type                 = "backend"
  }
  payment = {
    instance_type = "t3.micro"
    max_size      = 1
    min_size      = 1
    app_port_no   = 8080
    lb_listener_priority = 104
    type                 = "backend"
  }
  frontend = {
    instance_type = "t3.micro"
    max_size      = 1
    min_size      = 1
    app_port_no   = 80
    lb_listener_priority = 100
    type             = "frontend"
    public_dns_name  = "dev"
  }
}
BASTION_NODE    = "172.31.44.45/32"
private_zone_id = "Z08890812GDKJPFF6GWTN"
public_zone_id = "Z102158514HH6PL8QXJYQ"
PROMETHEUS_NODE = "172.31.29.131/32"
#(prometheus server ip)

  alb = {
    public = {
      internal = false
    }
    private = {
      internal = true
    }
  }

ACM_ARN = "arn:aws:acm:us-east-1:037402781494:certificate/6078a0ef-dda1-4b97-8964-2296abf4c304"