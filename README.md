# Infinity Works Airflow Hack Night, 18.6.2019

## Objective
Learn about using and running workflows in [Apache Airflow](https://airflow.apache.org/) by dividing into teams and completing set challenges.

## Setup
The hack night took place in 3 phases:
1. Short briefing about useful Airflow is concepts, and the goals of the hacking challenge 
2. Hacking!
3. Group discussion to share findings

Each team at the hack night had an instance of Airflow running on an EC2 server in Infinity Works' AWS account. By committing to a git repository, each team could get their DAGS to be run in their Airflow instance. Further information about how Airflow was deployed is at the end of this document.

### Briefing
* [Hack Night: Apache Airflow](https://drive.google.com/a/infinityworks.com/file/d/1o8AG6c-T6EvelO2Mgr-IRaaQKz0LeWwG/view?usp=sharing) presented by Hanwei Teo.
* [Hacking challenge goals](https://drive.google.com/open?id=1WG9LoIhK_QWsC1cbQKDgsvtQLOuY2LTj)

### Hacking
We divided into 3 teams, whose work can be found here:
* https://github.com/infinityworks/airflow-hacknight-coke
* https://github.com/infinityworks/airflow-hacknight-sprite
* https://github.com/infinityworks/airflow-hacknight-fanta

### Findings
Overall, Airflow is not plug-and-play. In terms of what it's like to use, it is more like Jenkins than like CircleCI. More experimentation is needed to discover:
* what it's like to use once you're past the initial learning curve
* for our likely use cases, whether AWS step functions would be preferable

It would also be beneficial to explore existing approaches to orchestration within InfinityWorks projects, e.g. how orchestration problems were sovled in New Nectar/Krang.

A fuller list of Airflow pros and cons follows:

#### Pros
* It's Python, which makes it extensible and is good for cross functionality i.e. the same engineer that writes an ETL will most likely be able to write/modify the DAG that invokes ETL job
* The built-in DAG visualisation is great
* It's unit test able
* It seems to very smoothly discover new DAGs
* It's an industry standard, free (both like speech and like beer) and it has a following

#### Cons
* The DSL is not transparent
* Where are the logs? What do the logs mean?
* The UI is not intuitive
* The docs are bad, you have to rely quite heavily on Stack Overflow and actually reading Airflow code.

## Airflow Deployment Information

In addition to the below, an [application producing dummy transaction data](https://github.com/infinityworks/iw-airflow-hack-dummy-data-generator) was set up to write fake transactions as json to an s3 bucket every 3 seconds.

### aws-deploy

For deploying into the Cloud, creates a single EC2 instance and two S3 buckets (Input and Output).

N.B. You will need to create a new repo for the DAGs.

### local-deploy

For deploying locally using docker-compose
