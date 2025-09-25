resource "aws_key_pair" "management" {
  key_name   = "management-key"
  public_key = file("C:/Users/dusti/.ssh/management-key.pem.pub") # Windows path
}