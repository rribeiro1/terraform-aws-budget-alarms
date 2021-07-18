<p align="center">
  <img src="https://raw.githubusercontent.com/rribeiro1/terraform-aws-budget-alarms/master/assets/cover.png" width="200">
</p>

# AWS Budget Alarms

![tfsec](https://github.com/rribeiro1/terraform-aws-budget-alarms/workflows/tfsec/badge.svg)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
<a href="https://github.com/rribeiro1/web-development-projects/commits/master"><img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/rribeiro1/terraform-aws-budget-alarms?color=5f3cfa"></a>

A Terraform module that creates AWS Budgets and, the AWS Chatbot integration allows you to receive the alerts in your designated Slack channel.

### Configure AWS Chatbot / Slack integration

In order to configure the integration between AWS Chatbot and Slack, this module requires the variables `slack_workspace_id` and `slack_channel_id`.

**Slack Workspace ID:** Perform the initial authorization flow with Slack in the AWS Chatbot console.
For more details, refer to [Setting Up AWS Chatbot with Slack](https://docs.aws.amazon.com/chatbot/latest/adminguide/setting-up.html#Setup_intro) in the AWS Chatbot User Guide.

**Slack Channel ID:** Right-click on the channel name in the left pane, then choose Copy Link. 
The channel ID is the 9-character string at the end of the URL.

### Usage

A full example is contained in the [examples](https://github.com/rribeiro1/terraform-aws-budget-alarms/tree/master/examples) directory.

```hcl
module "budget_alarms" {
  source  = "rribeiro1/budget-alarms/aws"
  version = "0.0.7" # verify the last version in the terraform registry

  account_name         = "Development"
  account_budget_limit = 100.5

  services = {
    EC2 = {
      budget_limit = 50.25
    },
    S3 = {
      budget_limit = 12.35
    },
    ECR = {
      budget_limit = 10.5
    }
  }

  notifications = {
    warning = {
      comparison_operator = "GREATER_THAN"
      threshold           = 100
      threshold_type      = "PERCENTAGE"
      notification_type   = "ACTUAL"
    },
    critical = {
      comparison_operator = "GREATER_THAN"
      threshold           = 110
      threshold_type      = "PERCENTAGE"
      notification_type   = "ACTUAL"
    }
  }

  slack_workspace_id = "12345678910"
  slack_channel_id   = "12345678910"

  tags = {
    Environment = "Development"
  }
}
```

### Disable the AWS Chatbot Integration with Slack

Make sure to set `create_slack_integration = false` to disable the integration.

### List of Services

> This list is not exhaustive and new AWS services can be added.

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

### Integration Tests

Implemented using [Kitchen-Terraform](https://github.com/newcontext-oss/kitchen-terraform).

1. Export the variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
2. Execute the commands:

```bash
bundle install
bundle exec kitchen test
```

### Docs generation

Code formatting and documentation for variables and outputs are generated using [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) which uses [terraform-docs](https://github.com/segmentio/terraform-docs).

Follow [these instructions](https://github.com/antonbabenko/pre-commit-terraform#how-to-install) to install pre-commit locally.

And install `terraform-docs` with `go get github.com/segmentio/terraform-docs` or `brew install terraform-docs`.

### Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/rribeiro1/terraform-aws-budget-alarms/issues/new/choose) section.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| local | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_budget\_limit | Set the budget limit for the AWS account. | `string` | n/a | yes |
| account\_name | Specifies the name of the AWS account | `string` | `""` | no |
| budget\_limit\_unit | The unit of measurement used for the budget forecast, actual spend, or budget threshold. | `string` | `"USD"` | no |
| budget\_time\_unit | The length of time until a budget resets the actual and forecasted spend. Valid values: `MONTHLY`, `QUARTERLY`, `ANNUALLY`. | `string` | `"MONTHLY"` | no |
| create\_slack\_integration | Whether to create the Slack integration through AWS Chatbot or not. | `bool` | `true` | no |
| notifications | Can be used multiple times to configure budget notification thresholds. | <pre>map(object({<br>    comparison_operator = string<br>    threshold           = number<br>    threshold_type      = string<br>    notification_type   = string<br>  }))</pre> | n/a | yes |
| services | Define the list of services and their limit of budget. | <pre>map(object({<br>    budget_limit = string<br>  }))</pre> | n/a | yes |
| slack\_channel\_id | The ID of the Slack channel. For example, ABCBBLZZZ. (Should be set when create\_slack\_integration is enabled). | `string` | `""` | no |
| slack\_workspace\_id | The ID of the Slack workspace authorized with AWS Chatbot. (Should be set when create\_slack\_integration is enabled). | `string` | `""` | no |
| tags | Additional tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| budget\_alarms\_sns\_topic\_arn | ARN identification of the budget alarms SNS topic. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
