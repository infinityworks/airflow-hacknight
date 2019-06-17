resource "aws_s3_bucket" "input" {
  bucket = "airflow-input-${var.team}"
  acl    = "private"

  tags = {
    Name    = "airflow-input-${var.team}"
    Owner   = "${var.owner}"
    Project = "Airflow Hacknight"
  }
}

resource "aws_s3_bucket" "output" {
  bucket = "airflow-output-${var.team}"
  acl    = "private"

  tags = {
    Name    = "airflow-output-${var.team}"
    Owner   = "${var.owner}"
    Project = "Airflow Hacknight"
  }
}

resource "aws_security_group" "sg" {
  name = "airflow-${var.team}-sg"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "airflow-sg-${var.team}"
    Owner   = "${var.owner}"
    Project = "Airflow Hacknight"
  }
}

resource "aws_instance" "airflow" {
  ami                    = "ami-030dbca661d402413"
  instance_type          = "t2.medium"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]

  tags = {
    Name    = "airflow-${var.team}"
    Owner   = "${var.owner}"
    Project = "Airflow Hacknight"
  }

  user_data = <<EOF
#!/bin/bash
yum update -y
yum install python-pip gcc git -y
pip install apache-airflow[s3]

git clone https://github.com/infinityworks/airflow-hacknight-"${var.team}".git /root/airflow/dags

airflow initdb
sed -i 's/load_examples = True/load_examples = False/g' /root/airflow/airflow.cfg
airflow webserver -p 8080 &
airflow scheduler &

(crontab -l 2>/dev/null; echo "* * * * * cd /root/airflow/dags && git pull") | crontab -

airflow delete_dag example_bash_operator -y
airflow delete_dag example_branch_dop_operator_v3 -y
airflow delete_dag example_branch_operator -y
airflow delete_dag example_http_operator -y
airflow delete_dag example_passing_params_via_test_command -y
airflow delete_dag example_python_operator -y
airflow delete_dag example_short_circuit_operator -y
airflow delete_dag example_skip_dag -y
airflow delete_dag example_subdag_operator -y
airflow delete_dag example_trigger_controller_dag -y
airflow delete_dag example_trigger_target_dag -y
airflow delete_dag example_xcom -y
airflow delete_dag latest_only -y
airflow delete_dag latest_only_with_trigger -y
airflow delete_dag test_utils -y
airflow delete_dag tutorial -y
EOF
}
