
resource "aws_instance" "instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  count         = var.instance_count
  subnet_id     = aws_subnet.public_subnet[0].id
  key_name      = var.keypair

  vpc_security_group_ids      =  [aws_security_group.petclinic.id]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }

  lifecycle {
    create_before_destroy = true #var.create_before_destroy
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = var.root_ebs_volume_size
  }
}

