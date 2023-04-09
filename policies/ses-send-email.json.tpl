{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ],
      %{ if user_arns != "[]" }
      "Principal": {
        "AWS": ${user_arns}
      },
      %{ endif }
      "Resource": "*"
    }
  ]
}
