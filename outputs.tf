output "budget_alarms_sns_topic_arn" {
  value = aws_sns_topic.account_budgets_alarm_topic.arn
  description = "ARN identification of the budget alarms SNS topic."
}
