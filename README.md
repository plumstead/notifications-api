# Plumstead Notifications API

[![Terraform CI](./actions/workflows/continuous-integration-terraform.yml/badge.svg?branch=main)](./actions/workflows/continuous-integration-terraform.yml?branch=main)
[![GitHub release](./releases)](./releases)

This project creates and manages the Plumstead Notifications API

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.62.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.62.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.ses_email_lambda_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.ses_email_lambda_log_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ses_email_lambda_ses_send_email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.ses_email_lambda_log_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.ses_email_lambda_ses_send_email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.ses_email_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.ses_email_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [archive_file.ses_email_lambda](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | n/a | yes |
| <a name="input_ses_email_lambda_vars"></a> [ses\_email\_lambda\_vars](#input\_ses\_email\_lambda\_vars) | SES Lambda variables | <pre>object({<br>    source_arn         = string,<br>    allowed_from_users = list(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_environment"></a> [environment](#output\_environment) | n/a |
<!-- END_TF_DOCS -->
