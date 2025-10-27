app_code     = "aw1449581"
project_name = "observabilidad"
environment  = "dev"

# Secret configuration - choose one of these scenarios:

# Scenario 1: Random password generation
secret_type     = "random"
password_length = 20

# Scenario 2: String template (JSON format)
# secret_type = "string_template"
# string_template_value = "{\"username\":\"admin\",\"password\":\"mypassword\",\"database\":\"mydb\"}"

# Scenario 3: Simple secret string
# secret_type = "secret_string"
# string_template_value = "my-simple-secret-value"

# Assume role policy - Option 1: Provide JSON directly
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

# Assume role policy - Option 2: Use type and identifiers (comment out assume_role_policy_json above)
# assume_role_type        = "Service"
# assume_role_identifiers = ["ec2.amazonaws.com", "lambda.amazonaws.com"]

# Custom policy statements for the IAM role
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