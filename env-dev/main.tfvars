app_server = {
    frontend = {
      name = "frontend"
      instance_type = "t3.small"
    }
    catalogue = {
     name = "catalogue"
     instance_type = "t3.small"
    }
    user = {
      name = "user"
      instance_type = "t3.small"
    }
    cart = {
      name = "cart"
      instance_type = "t3.small"
    }
    shipping = {
      name = "shipping"
      instance_type = "t3.small"
      password = "RoboShop@1"
    }
    payment = {
      name = "payment"
      instance_type = "t3.small"
      password = "roboshop123"
    }
}

database_server = {
  rabbitmq = {
    name = "rabbitmq"
    instance_type = "t3.medium"
    password = "roboshop123"
  }
  mysql = {
    name = "mysql"
    instance_type = "t3.medium"
    password = "RoboShop@1"
  }
  redis = {
    name = "redis"
    instance_type = "t3.medium"
  }
  mongodb = {
    name = "mongodb"
    instance_type = "t3.medium"
  }
}

env = "dev"
