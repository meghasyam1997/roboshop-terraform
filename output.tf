output "instance" {
  value = var.instance
}

output "AMI_ID" {
  value = data.aws_ami.centos.id
}

output "frontend" {
  value = aws_instance.frontend.public_ip
}