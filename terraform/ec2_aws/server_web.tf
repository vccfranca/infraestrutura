data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "web" {
	ami             = data.aws_ami.ubuntu.id
	instance_type   = "t2.micro"
	security_groups = ["${aws_security_group.access.name}"]
	tags = {
		Name = "ServerWeb"
  }
}

resource "aws_security_group" "access" {
	name = "http"
	description = "access http"

	ingress {
		from_port 	= 80
		to_port   	= 80
		protocol  	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port 	= 22
		to_port   	= 22
		protocol  	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port 	 = 0
		to_port	  	 = 0
		protocol  	 = -1
		cidr_blocks  = ["0.0.0.0/0"]
	}
	tags = {
		Name = "Access http"
  }
}

output "print_public_dns" {
	value = aws_instance.web.public_dns
}  