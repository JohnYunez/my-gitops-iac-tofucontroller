data "aws_caller_identity" "current" {}

resource "aws_secretsmanager_secret" "this" {
    name        = "${var.app_code}-${var.project_name}-${var.environment}-secret"
    description = var.secret_description
    #kms_key_id  = var.secret_kms_key_arn
    recovery_window_in_days = 7
}

locals {
    secure_string = var.secret_string_template != null ? var.secret_string_template : (
        var.create_random_password ? random_password.this.result : var.secret_string
    )
}

resource "aws_secretsmanager_secret_version" "this" {
    secret_id      = aws_secretsmanager_secret.this.id
    secret_string  = local.secure_string  
}

resource "random_password" "this" {
    length = var.random_password_length
    special = true
}

# This policy restricts access to the secret to a specific role ARN
data "aws_iam_policy_document" "restrict_access" {
    statement {
        sid    = "AllowSpecificRoleAccess"
        effect = "Allow"

        principals {
            type        = "AWS"
            identifiers = [var.allowed_role_arn]
        }

        actions = [
            "secretsmanager:GetSecretValue",
            "secretsmanager:DescribeSecret"
        ]

        resources = [aws_secretsmanager_secret.this.arn]
        # condition {
        #     test     = "StringNotLike"
        #     variable = "aws:PrincipalArn"
        #     values = [
        #         "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Cloudformation-service-deployment-role-vsts",
        #         "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AWSReservedSSO_BCO-SysOpsGiotiAnalystRole*"
        #     ]
        # }
    }
}

resource "aws_secretsmanager_secret_policy" "this" {
    secret_arn = aws_secretsmanager_secret.this.arn
    policy     = data.aws_iam_policy_document.restrict_access.json
}