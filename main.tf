# 1. Configure the AWS provider
provider "aws" {
  region = "eu-north-1"  # Change to your preferred region
}

# 2. Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-vnomad-terraform-bucket-12345"  # Must be globally unique
  acl    = "private"

  tags = {
    Name        = "VNomadTestBucket"
    Environment = "Dev"
    Description = "This S3 bucket is created by Terraform for VNomad project"
  }
}

# 3. Data source to get default VPC (needed for security group)
data "aws_vpc" "default" {
  default = true
}

# 4. Create a Security Group for SSH and Nomad UI access
resource "aws_security_group" "nomad_sg" {
  name        = "nomad-security-group"
  description = "Allow SSH and Nomad UI access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Nomad UI"
    from_port   = 4646
    to_port     = 4646
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 5. Create Nomad Server EC2 Instance
resource "aws_instance" "nomad_server" {
  ami           = "ami-0c395e1ea315b0088"  # Ubuntu 22.04 in us-east-1; change if region differs
  instance_type = "t3.micro"
  security_groups = [aws_security_group.nomad_sg.name]
  key_name       = "myec2key"  # Use your created key pair name here

  tags = {
    Name = "nomad-server"
  }
}

# 6. Create Nomad Client EC2 Instance
resource "aws_instance" "nomad_client" {
  ami           = "ami-0c395e1ea315b0088"  # Ubuntu 22.04 in us-east-1; change if region differs
  instance_type = "t3.micro"
  security_groups = [aws_security_group.nomad_sg.name]
  key_name       = "myec2key"  # Use your created key pair name here

  tags = {
    Name = "nomad-client"
  }
}

