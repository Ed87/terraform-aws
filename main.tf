data "aws_ami" "server_ami" {
  most_recent      = true
  owners           = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "random_integer" "random" {
    min = 1
    max = 100
}

resource "aws_instance" "myserver" {
  ami           = data.aws_ami.server_ami.id
  instance_type = "t2.micro"
  tags = {
    Name = "myserver-dev-${random_integer.random.id}"
  }

   root_block_device {
    volume_size = 10
  }
}