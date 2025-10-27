aws_region   = "us-east-1"
environment  = "dev"
app_code     = "aw1234567"
project_name = "observabilidad"

assume_role_statements = [
  { 
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals = {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  },
  {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals = {
      type        = "AWS"
      identifiers = ["arn:aws:iam::123456789012:user/admin"]
    }
  }
]

policy_statements = [
  {
    sid       = "S3ReadAccess"
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = ["arn:aws:s3:::my-bucket/*", "arn:aws:s3:::my-bucket"]
    effect    = "Allow"
  },
  {
    sid       = "SecretsManagerAccess"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["arn:aws:secretsmanager:us-east-1:123456789012:secret:my-secret/*"]
    effect    = "Allow"
    condition = {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["us-east-1"]
    }
  },
  {
    sid       = "DenyUnauthorizedActions"
    actions   = ["iam:CreateUser", "iam:DeleteUser"]
    resources = ["*"]
    effect    = "Deny"
  }
]