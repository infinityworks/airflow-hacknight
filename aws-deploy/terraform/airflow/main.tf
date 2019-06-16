resource "aws_s3_bucket" "input" {
  bucket = "airflow-input-${var.team}"
  acl    = "private"

  tags = {
    Name        = "airflow-input-${var.team}"
    Owner       = "${var.owner}"
    Project = "Airflow Hacknight"
  }
}

resource "aws_s3_bucket" "output" {
  bucket = "airflow-output-${var.team}"
  acl    = "private"

  tags = {
    Name        = "airflow-output-${var.team}"
    Owner       = "${var.owner}"
    Project = "Airflow Hacknight"
  }
}

resource "aws_security_group" "sg" {
  name        = "airflow-${var.team}-sg"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.cidr}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "airflow-sg-${var.team}"
    Owner       = "${var.owner}"
    Project = "Airflow Hacknight"
  }
}

resource "aws_instance" "airflow" {
  ami           = "ami-030dbca661d402413"
  instance_type = "t2.medium"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]

  tags = {
    Name        = "airflow-${var.team}"
    Owner       = "${var.owner}"
    Project     = "Airflow Hacknight"
  }

  user_data = <<EOF
#!/bin/bash
yum update -y
yum install python-pip gcc -y
pip install apache-airflow[s3]

airflow initdb
airflow webserver -p 8080 &
EOF
}