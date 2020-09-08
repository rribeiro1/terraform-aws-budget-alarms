variable "account_name" {
  description = "Specifies the name of the AWS account"
  type        = string
  default     = ""
}

variable "account_budget_limit" {
  description = "Set the budget limit for the AWS account"
  type        = string
}

variable "budget_limit_unit" {
  description = "The unit of measurement used for the budget forecast, actual spend, or budget threshold."
  type        = string
  default     = "USD"
}

variable "budget_time_unit" {
  description = "The length of time until a budget resets the actual and forecasted spend. Valid values: `MONTHLY`, `QUARTERLY`, `ANNUALLY`."
  type        = string
  default     = "MONTHLY"
}

variable "services" {
  description = "Define the list of services and their limit of budget"
  type = map(object({
    budget_limit = string
  }))
}

variable "notifications" {
  description = "Can be used multiple times to configure budget notification thresholds"
  type = map(object({
    comparison_operator = string
    threshold           = number
    threshold_type      = string
    notification_type   = string
  }))
}

variable "slack_channel_id" {
  type        = string
  description = "The ID of the Slack channel. To get the ID, open Slack, right click on the channel name in the left pane, then choose Copy Link. The channel ID is the 9-character string at the end of the URL. For example, ABCBBLZZZ."
}

variable "slack_workspace_id" {
  type        = string
  description = "The ID of the Slack workspace authorized with AWS Chatbot. To get the workspace ID, you must perform the initial authorization flow with Slack in the AWS Chatbot console. Then you can copy and paste the workspace ID from the console. For more details, see steps 1-4 in [Setting Up AWS Chatbot with Slack](https://docs.aws.amazon.com/chatbot/latest/adminguide/setting-up.html#Setup_intro) in the AWS Chatbot User Guide."
}

variable "create_slack_integration" {
  type        = string
  description = "Whether to create the Slack integration through AWS Chatbot or not."
  default     = true
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags"
}
