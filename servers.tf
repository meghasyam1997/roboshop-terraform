resource "aws_instance" "instance" {
  for_each      = var.components
  ami           = data.aws_ami.centos.id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route53_record" "records" {
  for_each = var.components
  zone_id = "Z06713411IASYL5XZHSG8"
  name    = "${each.value["name"]}-dev.msdevops72.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.value["name"]].private_ip]
}
