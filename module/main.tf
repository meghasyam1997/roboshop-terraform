resource "aws_instance" "instance"{
  ami           = data.aws_ami.centos.id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]

  tags = {
    Name = var.components_name
  }
}
resource "null_resource" "provisioner" {
  depends_on = [aws_instance.instance,aws_route53_record.records]
  provisioner "remote-exec" {

    connection {
      type = "ssh"
      user = "centos"
      password = "DevOps321"
      host = aws_instance.instance.private_ip
    }

    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/meghasyam1997/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${var.components_name}.sh ${var.password}"
    ]
  }

}
resource "aws_route53_record" "records" {
  zone_id = "Z06713411IASYL5XZHSG8"
  name    = "${var.components_name}-dev.msdevops72.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}