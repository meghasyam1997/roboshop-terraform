locals{
  name= var.env != "" ? "${var.components_name}-${var.env}" : var.components_name
  db_command=[
    "rm -rf roboshop-shell",
    "git clone https://github.com/meghasyam1997/roboshop-shell.git",
    "cd roboshop-shell",
    "sudo bash ${var.components_name}.sh ${var.password}"
  ]

  app_command=[
    "sudo labauto ansible",
    "ansible-pull -i localhost, -U https://github.com/meghasyam1997/roboshop-ansible roboshops.yml -e env=${var.env} -e role_name=${var.components_name}"
  ]
  db_tags = {
    Name = "${var.components_name}-${var.env}"
  }
  app_tags = {
    Name = "${var.components_name}-${var.env}"
    Env = var.env
    Component = var.components_name
    Monitor = "true"
  }

}