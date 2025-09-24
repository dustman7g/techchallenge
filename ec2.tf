data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "management" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.micro" ########### t3.micro is on free tier
  #instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.management.id
  vpc_security_group_ids      = [aws_security_group.mgmt_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = { Name = "management-instance" }
}