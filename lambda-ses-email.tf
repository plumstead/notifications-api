resource "aws_cloudwatch_log_group" "ses_email_lambda_log_group" {
  name = "/aws/lambda/${local.resource_prefix}-ses-email"
}

resource "aws_iam_role" "ses_email_lambda" {
  name               = "${local.resource_prefix}-ses-email-lambda"
  assume_role_policy = templatefile("./policies/assume-roles/lambda.json.tpl", {})
}

resource "aws_iam_policy" "ses_email_lambda_log_stream" {
  name = "${local.resource_prefix}-ses-email-lambda-log-stream"
  policy = templatefile("./policies/log-stream.json.tpl",
    {
      cloudwatch_log_group_arn = aws_cloudwatch_log_group.ses_email_lambda_log_group.arn
    }
  )
}

resource "aws_iam_policy_attachment" "ses_email_lambda_log_stream" {
  name       = "${local.resource_prefix}-ses-email-lambda-log-stream"
  roles      = [aws_iam_role.ses_email_lambda.name]
  policy_arn = aws_iam_policy.ses_email_lambda_log_stream.arn
}

resource "aws_iam_policy" "ses_email_lambda_ses_send_email" {
  name = "${local.resource_prefix}-ses-email-lambda-ses-send-email"
  policy = templatefile("./policies/ses-send-email.json.tpl",
    {
      ses_identities = jsonencode(local.ses_email_lambda_allowed_identities),
      user_arns      = "[]"
    }
  )
}

resource "aws_iam_policy_attachment" "ses_email_lambda_ses_send_email" {
  name       = "${local.resource_prefix}-ses-email-lambda-ses-send-email"
  roles      = [aws_iam_role.ses_email_lambda.name]
  policy_arn = aws_iam_policy.ses_email_lambda_ses_send_email.arn
}

data "archive_file" "ses_email_lambda" {
  type        = "zip"
  source_dir  = "./lambdas/ses-email"
  output_path = "./lambdas/archive-file-output/${local.resource_prefix}-ses-email.zip"
}

resource "aws_lambda_function" "ses_email_lambda" {
  filename      = "./lambdas/archive-file-output/${local.resource_prefix}-ses-email.zip"
  function_name = "${local.resource_prefix}-ses-email"
  role          = aws_iam_role.ses_email_lambda.arn
  handler       = "function.email_handler"
  timeout       = 60

  source_code_hash = data.archive_file.ses_email_lambda.output_base64sha256

  runtime = "python3.9"

  environment {
    variables = {
      SOURCE_ARN = local.ses_email_lambda_vars.source_arn,
    }
  }
}
