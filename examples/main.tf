module "budget_alarms" {
  source = "../"

  account_name         = "Prod"
  account_budget_limit = 20

  services = {
    EC2 = {
      budget_limit = 10.25
    }
  }

  notifications = {
    warning = {
      comparison_operator = "GREATER_THAN"
      threshold           = 100
      threshold_type      = "PERCENTAGE"
      notification_type   = "ACTUAL"
    }
  }

  create_slack_integration = false
  slack_workspace_id       = ""
  slack_channel_id         = ""

  tags = {
    Environment = "Prod"
  }
}

output "budgets_topic_arn" {
  value = module.budget_alarms.budget_alarms_sns_topic_arn
}
