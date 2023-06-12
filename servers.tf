module "server" {
  for_each = var.components
  source = "./module"
  components_name = var.components[each.value["name"]]
  env = var.env
  instance_type = var.components[each.value["instance"]]
  password =lookup(each.value,"password","null")
}
