resource "aws_key_pair" "client_key" {
    key_name = "client_key"
    public_key = file("./modules/ec2/client_key.pub")
}

resource "aws_instance" "compute_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = "client_key"
  iam_instance_profile   = "github-runner-instance-profile"
  user_data              = templatefile("./install_script.sh", {})

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "${var.app_name}-github-runner-instance"
  }
}