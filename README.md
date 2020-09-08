<p align="center">
  <img src="/assets/cover.png" width="200">
</p>

# AWS Budget Alarms

![tfsec](https://github.com/rribeiro1/terraform-aws-budget-alarms/workflows/tfsec/badge.svg)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module that creates budget resources on AWS, also creates an SNS topic where you can subscribe to an email or lambda-function and receive the notification alarms.

## Usage

```hcl
module "budget_alarms" {
  source  = "rribeiro1/budget-alarms/aws"
  version = "0.0.3"

  account_name         = "Development"
  account_budget_limit = "5000.0"

  services = {
    S3 = {
      budget_limit = "100.0"
    },
    EC2 = {
      budget_limit = "1500.0"
    },
    RDS = {
      budget_limit = "3000.0"
    }
  }
}
```

## Doc generation

Code formatting and documentation for variables and outputs are generated using [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) which uses [terraform-docs](https://github.com/segmentio/terraform-docs).

Follow [these instructions](https://github.com/antonbabenko/pre-commit-terraform#how-to-install) to install pre-commit locally.

And install `terraform-docs` with `go get github.com/segmentio/terraform-docs` or `brew install terraform-docs`.

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/rribeiro1/terraform-aws-budget-alarms/issues/new/choose) section.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.6 |
| aws | ~> 2.37 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.37 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_budget\_limit | Specifies the budget limit for the account level | `string` | n/a | yes |
| account\_name | Specifies the name of the account | `string` | `""` | no |
| services | Map of AWS services to be monitored in terms of costs | <pre>map(object({<br>    budget_limit = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| budget\_alarms\_sns\_topic\_arn | ARN identification of the budget alarms SNS topic. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## List of Services

> This list is not exhaustive, and new AWS services can be added in the future.

| Service Key                 | Description                                        |
|-----------------------------|----------------------------------------------------|
| Athena                      | Amazon Athena.                                     |
| EC2                         | Amazon Elastic Compute Cloud - Compute".           |
| ECR                         | Amazon EC2 Container Registry (ECR).               |
| ECS                         | Amazon EC2 Container Service.                      |
| Kubernetes                  | Amazon Elastic Container Service for Kubernetes.   |
| EBS                         | Amazon Elastic Block Store.                        |
| CloudFront                  | Amazon CloudFront.                                 |
| CloudTrail                  | AWS CloudTrail.                                    |
| CloudWatch                  | Amazon CloudWatch.                                 |
| Cognito                     | Amazon Cognito.                                    |
| Config                      | AWS Config.                                        |
| DynamoDB                    | Amazon DynamoDB.                                   |
| DMS                         | AWS Database Migration Service.                    |
| ElastiCache                 | Amazon ElastiCache.                                |
| ELB                         | Amazon Elastic Load Balancing.                     |
| Gateway                     | Amazon API Gateway.                                |
| Glue                        | AWS Glue.                                          |
| Kafka                       | Managed Streaming for Apache Kafka.                |
| KMS                         | AWS Key Management Service.                        |
| Kinesis                     | Amazon Kinesis.                                    |
| Lambda                      | AWS Lambda.                                        |
| Lex                         | Amazon Lex.                                        |
| Matillion                   | Matillion ETL for Amazon Redshift.                 |
| Pinpoint                    | AWS Pinpoint.                                      |
| Polly                       | Amazon Polly.                                      |
| Rekognition                 | Amazon Rekognition.                                |
| RDS                         | Amazon Relational Database Service.                |
| Redshift                    | Amazon Redshift.                                   |
| S3                          | Amazon Simple Storage Service.                     |
| SFTP                        | AWS Transfer for SFTP.                             |
| Route53                     | Amazon Route 53.                                   |
| SageMaker                   | Amazon SageMaker.                                  |
| SecretsManager              | AWS Secrets Manager.                               |
| SES                         | Amazon Simple Email Service.                       |
| SNS                         | Amazon Simple Notification Service.                |
| SQS                         | Amazon Simple Queue Service.                       |
| Tax                         | Tax.                                               |
| VPC                         | Amazon Virtual Private Cloud.                      |
| WAF                         | AWS WAF.                                           |
| XRay                        | AWS X-Ray.                                         |

## Authors

Module managed by [Rafael Ribeiro](https://github.com/rribeiro1).

## License

Apache 2 Licensed. See LICENSE for full details.


