provider "aws" {
  region = "eu-west-1"
}


module "demo" {
  source = "./airflow"

  team     = "demo"
  owner    = "adam.pietrzycki@infinityworks.com"
  key_name = "adampie"
  cidr     = "X.X.X.X/32"
}
