data "aws_caller_identity" "current" {}

### IAM Role Definition
resource "aws_iam_role" "this" {
    name = "${var.app_code}-${var.project_name}-${var.environment}-role-${random_string.this.result}"
    assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
    dynamic "statement" {
        for_each = var.assume_role_statements
        content {
            effect = try(statement.value.effect)
            actions = try(statement.value.actions, ["sts:AssumeRole"])
            principals {
                type        = try(statement.value.principals.type, null)
                identifiers = try(statement.value.principals.identifiers, null)
            }
        }
    }
}

## IAM Role Attachment
# resource "aws_iam_role_policy_attachment" "this" {
#     role       = aws_iam_role.this.name
#     policy_arn = aws_iam_role_policy.this
# }

## IAM Role Policy
resource "aws_iam_role_policy" "this" {
    name   = "${var.app_code}-${var.project_name}-${var.environment}-policy-${random_string.this.result}"
    role   = aws_iam_role.this.id
    policy = data.aws_iam_policy_document.policy.json
}
data "aws_iam_policy_document" "policy" {
    dynamic statement {
        for_each = var.policy_statements
        content {
            sid     = try(statement.value.sid, null)
            actions = try(statement.value.actions, [])
            resources = try(statement.value.resources, [])
            effect    = try(statement.value.effect, "Allow")
            dynamic "condition" {
                for_each = statement.value.condition != null ? [statement.value.condition] : []
                content {
                    test     = try(statement.value.condition.test, null)
                    variable = try(statement.value.condition.variable, null)
                    values   = try(statement.value.condition.values, [])
                }
            }
        }
    }
}

resource "random_string" "this" {
    length  = 8
    special = false
}
