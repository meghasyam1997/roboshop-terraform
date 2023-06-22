module "database-server" {
  for_each = var.database_server
  source = "./module"
  components_name = each.value["name"]
  env = var.env
  instance_type = each.value["instance_type"]
  password =lookup(each.value,"password","null")
  provisioner = true
  app_type = db
}

module "app-server" {
  depends_on = [module.database-server]
  for_each = var.app_server
  source = "./module"
  components_name = each.value["name"]
  env = var.env
  instance_type = each.value["instance_type"]
  password =lookup(each.value,"password","null")
  provisioner = true
  app_type = app
}

