provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "kubernetes_master" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t3.medium"
  key_name      = "health_care_server-1"
  
  tags = {
    Name = "Kubernetes-Master"
  }
}

resource "aws_instance" "kubernetes_worker" {
  count         = 2
  ami           = "ami-084568db4383264d4"
  instance_type = "t3.medium"
  key_name      = "health_care_server-1"
  
  tags = {
    Name = "Kubernetes-Worker-${count.index}"
  }
}

output "master_ip" {
  value = aws_instance.kubernetes_master.public_ip
}

output "worker_ips" {
  value = aws_instance.kubernetes_worker[*].public_ip
}
