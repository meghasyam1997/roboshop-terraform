resource "aws_instance" "instance"{
  ami           = data.aws_ami.centos.id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  tags = var.app_type == "app" ? local.app_tags : local.db_tags
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

    inline = var.app_type == "db" ? local.db_command : local.app_command
  }
}

resource "aws_route53_record" "records" {
  zone_id = "Z06713411IASYL5XZHSG8"
  name    = "${var.components_name}-dev.msdevops72.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}

resource "aws_iam_role" "role" {
  name = "${var.components_name}-${var.env}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.components_name}-${var.env}"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.components_name}-${var.env}"
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy" "ssm-ps-policy" {
  name = "${var.components_name}-${var.env}-ssm-ps-policy"
  role = aws_iam_role.role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "kms:Decrypt",
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": [
          "arn:aws:ssm:us-east-1:561174155654:parameter/${var.env}.${var.components_name}.*",
          "arn:aws:kms:us-east-1:561174155654:key/54baa543-c347-432e-ab40-108d5d0b67bb"
        ]
      }
    ]
  })
}
