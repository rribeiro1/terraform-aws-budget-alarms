variable "account_name" {
  description = "Specifies the name of the account"
  type        = string
  default     = ""
}

variable "account_budget_limit" {
  description = "Specifies the budget limit for the account level"
  type        = string
}

variable "services" {
  description = "Map of AWS services to be monitored in terms of costs"
  type = map(object({
    budget_limit = string
  }))
}