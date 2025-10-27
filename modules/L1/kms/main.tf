resource "aws_kms_key" "l1_kms_key" {
  description              = var.kms_description
  key_usage                = var.kms_key_usage
#  custom_key_store_id      = var.kms_custom_key_store_id
  customer_master_key_spec = var.kms_customer_master_key_spec
  deletion_window_in_days  = var.kms_deletion_window
  is_enabled               = var.kms_is_enabled
  enable_key_rotation      = var.kms_enable_key_rotation
  rotation_period_in_days  = var.kms_rotation_period_in_days
  multi_region             = var.kms_multi_region
}

resource "aws_kms_key_policy" "l1_kms_policy" {
  key_id = aws_kms_key.l1_kms_key.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "aws_kms_key_policy-1"
    Statement = [
      {
        Sid    = "Enable Secrets Manager Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "${var.kms_secretsmanager_arn}"
        },
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}
