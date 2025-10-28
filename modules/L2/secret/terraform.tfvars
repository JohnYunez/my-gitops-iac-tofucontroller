app_code                    = "nu0445001"
project_name                = "kaizen-galatea"
environment                 = "dev"

#option 1: secret_string
secret_type                 = "secret_string"
string_template_value       = "ThisIsASampleSecretValue"
#option 2: random password
# secret_type     = "random"
# password_length = 20
#option 3: String template (JSON format)
# secret_type = "string_template"
# string_template_value = "{\"username\":\"admin\",\"password\":\"mypassword\",\"database\":\"mydb\"}"

assume_role_statements = [
  {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals = {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "ec2.amazonaws.com", "ecs-tasks.amazonaws.com"]
    }
  }
]
custom_policy_statements = [
  {
    sid       = "SecretsManagerAccess"
    actions   = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = ["arn:aws:secretsmanager:us-east-1:*:secret:aw1234567-observabilidad-*"]
    effect    = "Allow"
  },
  {
    sid       = "CloudWatchLogsAccess"
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:us-east-1:*:*"]
    effect    = "Allow"
  },
  {
    sid       = "DenyDangerousActions"
    actions   = [
      "iam:CreateUser",
      "iam:DeleteUser",
      "iam:AttachUserPolicy"
    ]
    resources = ["*"]
    effect    = "Deny"
    condition = {
      test     = "StringNotEquals"
      variable = "aws:userid"
      values   = ["AIDACKCEVSQ6C2EXAMPLE"]
    }
  }
]


