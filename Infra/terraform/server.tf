resource "aws_key_pair" "server_public_key" {
  key_name   = "ubuntukey"
  public_key = file("ubuntukey.pub")
}


resource "aws_instance" "ubuntu_server" {
  ami                         = "ami-014f7ab33242ea43c"
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.server_public_key.key_name
  vpc_security_group_ids      = [aws_security_group.ubuntu_server_sg.id]
  subnet_id                   = aws_subnet.ubuntu_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "ubuntu_server"
  }
}


output "PublicIP" {
  value = aws_instance.ubuntu_server.public_ip
}

output "PrivateIP" {
  value = aws_instance.ubuntu_server.private_ip
}