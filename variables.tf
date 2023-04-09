variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "ses_email_lambda_vars" {
  description = "SES Lambda variables"
  type = object({
    source_arn         = string,
    allowed_from_users = list(string)
  })
}
