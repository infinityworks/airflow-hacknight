provider "aws" {
  region = "eu-west-1"
}


module "team_1" {
  source = "./airflow"

  team     = "test"
  owner    = "adam.pietrzycki@infinityworks.com"
  key_name = "adampie"
  cidr     = "0.0.0.0/0"
}
