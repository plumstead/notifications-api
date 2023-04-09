locals {
  environment                           = var.environment
  project_name                          = var.project_name
  account_id                            = data.aws_caller_identity.current.account_id
  region                                = data.aws_region.current.name
  resource_prefix                       = "${local.environment}-${local.project_name}"
  ses_email_lambda_vars                 = var.ses_email_lambda_vars
  ses_email_source_arn_identity_trimmed = dirname(local.ses_email_lambda_vars.source_arn)
  ses_email_identity                    = basename(local.ses_email_lambda_vars.source_arn)
  ses_email_lambda_allowed_identities = concat(
    [
      for user in local.ses_email_lambda_vars.allowed_from_users :
      "${local.ses_email_source_arn_identity_trimmed}/${user}@${local.ses_email_identity}"
    ],
    [
      for user in local.ses_email_lambda_vars.allowed_from_users :
      "arn:aws:ses:${local.region}:${local.account_id}:identity/${user}@${local.ses_email_identity}"
    ],
    [local.ses_email_lambda_vars.source_arn]
  )
}
