terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# authentication and configuration
provider "aws" {
  region     = "us-east-2"
  access_key = "AKIA3DO2MDEYXHWEUB7T"
  secret_key = "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"
}

resource "aws_instance" "terraform" {
  ami           = "ami-024e6efaf93d85776"
  instance_type = "t2.micro"
  key_name	= "keyterra"

  user_data = <<-EOF
  #!/bin/bash
   sudo -i
   mkdir tools
   cd tools
   apt update -y
   apt install tree -y
   apt update -y
   apt install openjdk-11-jre -y
   apt update -y
   curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
   echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
   https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
   /etc/apt/sources.list.d/jenkins.list > /dev/null
   apt-get update -y
   apt-get install jenkins -y
   add-apt-repository ppa:deadsnakes/ppa
   apt update -y
   apt list --upgradable
   apt-get update -y
   apt install python -y
  EOF

  tags = {
    Name = "terraform"
  }
}
resource "aws_key_pair" "terraform" {
  key_name      = "keyterra"
  public_key	= "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvDCDeEnUv5jkp4FE5HT1OsqGVOohIWh0IqTXgOnz/TdQUpruwDinF9wtOtIcZJw0RLd4D6BM1sTNZbyXTNRgqs2kNkYpiPCGbAhqSdezO2MTjhuZ1qYOruRKFiQkN1WRWsVe1uy+e3ycYKFkBqIlrhvCqfNIZaeMUm0coGvjYCzuWb/tOhOrWZDTYDXdYimR1km3abz1TqTtKaY4gUmONNNSRZeaazhXpY0TdV+EyI6UOIfWciA3TAiHkJa2A1K4dzRiEPln2U81zp8784k0CZ9Ca9pfPvofUccy/28OI21c7oX4pJ5Ak9h16wzlcc/QUlUb9JknY67eUKSbX8HsdbcmvFJA6upIFIAM88P7DgEUJAzGCmxrlX71iHMJUK/KwR/bY4Zd4fxE7YDJCbPhLasCYkh5V5ShDVMIRKYdpH++EclTookbpC9fbZ7ubR8WIzjxkpOPkc4+f8WVFTV66QHbORTh+cFJy3KTeKu7psMuHjdQSiTKXM0dtqTd+SfM= root@terraform"
}

