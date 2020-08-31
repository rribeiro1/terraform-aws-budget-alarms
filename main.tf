locals {
  aws_services = {
    Athena         = "Amazon Athena"
    EC2            = "Amazon Elastic Compute Cloud - Compute"
    ECR            = "Amazon EC2 Container Registry (ECR)"
    ECS            = "Amazon EC2 Container Service"
    Kubernetes     = "Amazon Elastic Container Service for Kubernetes"
    EBS            = "Amazon Elastic Block Store"
    CloudFront     = "Amazon CloudFront"
    CloudTrail     = "AWS CloudTrail"
    CloudWatch     = "AmazonCloudWatch"
    Cognito        = "Amazon Cognito"
    Config         = "AWS Config"
    DynamoDB       = "Amazon DynamoDB"
    DMS            = "AWS Database Migration Service"
    ElastiCache    = "Amazon ElastiCache"
    Elasticsearch  = "Amazon Elasticsearch Service"
    ELB            = "Amazon Elastic Load Balancing"
    Gateway        = "Amazon API Gateway"
    Glue           = "AWS Glue"
    Kafka          = "Managed Streaming for Apache Kafka"
    KMS            = "AWS Key Management Service"
    Kinesis        = "Amazon Kinesis"
    Lambda         = "AWS Lambda"
    Lex            = "Amazon Lex"
    Matillion      = "Matillion ETL for Amazon Redshift"
    Pinpoint       = "AWS Pinpoint"
    Polly          = "Amazon Polly"
    Rekognition    = "Amazon Rekognition"
    RDS            = "Amazon Relational Database Service"
    Redshift       = "Amazon Redshift"
    S3             = "Amazon Simple Storage Service"
    SFTP           = "AWS Transfer for SFTP"
    Route53        = "Amazon Route 53"
    SageMaker      = "Amazon SageMaker"
    SecretsManager = "AWS Secrets Manager"
    SES            = "Amazon Simple Email Service"
    SNS            = "Amazon Simple Notification Service"
    SQS            = "Amazon Simple Queue Service"
    Tax            = "Tax"
    VPC            = "Amazon Virtual Private Cloud"
    WAF            = "AWS WAF"
    XRay           = "AWS X-Ray"
  }
}

resource "aws_sns_topic" "account_budgets_alarm_topic" {
  name = "account-budgets-alarm-topic"
}

resource "aws_sns_topic_policy" "account_budgets_alarm_policy" {
  arn    = aws_sns_topic.account_budgets_alarm_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    sid    = "AWSBudgetsSNSPublishingPermissions"
    effect = "Allow"

    actions = [
      "SNS:Receive",
      "SNS:Publish"
    ]

    principals {
      type        = "Service"
      identifiers = ["budgets.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.account_budgets_alarm_topic.arn
    ]
  }
}

resource "aws_budgets_budget" "budget_account" {
  name              = "${var.account_name} Account Monthly Budget"
  budget_type       = "COST"
  limit_amount      = var.account_budget_limit
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2020-01-01_00:00"

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 100
    threshold_type      = "PERCENTAGE"
    notification_type   = "FORECASTED"
    subscriber_sns_topic_arns = [
      aws_sns_topic.account_budgets_alarm_topic.arn
    ]
  }

  depends_on = [
    aws_sns_topic.account_budgets_alarm_topic
  ]
}

resource "aws_budgets_budget" "budget_resources" {
  for_each = var.services

  name              = "${var.account_name} ${each.key} Monthly Budget"
  budget_type       = "COST"
  limit_amount      = each.value.budget_limit
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2020-01-01_00:00"

  cost_filters = {
    Service = lookup(local.aws_services, each.key)
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 100
    threshold_type      = "PERCENTAGE"
    notification_type   = "FORECASTED"
    subscriber_sns_topic_arns = [
      aws_sns_topic.account_budgets_alarm_topic.arn
    ]
  }

  depends_on = [
    aws_sns_topic.account_budgets_alarm_topic
  ]
}
