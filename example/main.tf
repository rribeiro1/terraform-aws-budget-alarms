provider "aws" {
  version = "= 3.25.0"
  region  = "eu-central-1"
}

module "budget_alerts" {
  source = "../"

  account_name         = "Development"
  account_budget_limit = 10.5

  services = {
    Route53 = {
      budget_limit = 0.25
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
