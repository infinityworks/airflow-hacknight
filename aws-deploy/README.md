# Deploying Airflow in AWS

> DO NOT RUN THIS IN A PRODUCTION ACCOUNT, I WILL FIND YOU...

1. Create a GitHub repo for your DAGs in the format -> airflow-hacknight-{team_name}
2. Create a module for your team in main.tf:

```tf
module "team_1" {
  source = "./airflow"

  team     = "test"
  owner    = "adam.pietrzycki@infinityworks.com"
  key_name = "adampie"
  cidr     = "0.0.0.0/0"
}
```

3. Any commits to airflow-hacknight-{team_name} will be pulled every minute
4. Hack
5. Profit!

