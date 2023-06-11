module "server" {
  for_each = var.components
  source = "./module"
  components_name = each.value["name"]
  env = var.env
  instance_type = each.value["instance"]
  password =lookup(each.value,"password","null")
}
