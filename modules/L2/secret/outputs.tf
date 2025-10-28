output "secret_arn" {
    description = "The ARN of the created secret"
    value       = module.secrets_manager.secret_arn
}

output "secret_name" {
    description = "The name of the created secret"
    value       = module.secrets_manager.secret_name
}

output "iam_role_arn" {
    description = "The ARN of the IAM role created for accessing the secret"
    value       = module.iam_role.iam_role_arn
}

output "iam_role_name" {
    description = "The name of the IAM role created for accessing the secret"
    value       = module.iam_role.iam_role_name
}

output "kms_key_arn" {
  value       = module.kms.kms_key_arn
  description = "Key ARN"
}

output "kms_key_id" {
  value       = module.kms.kms_key_id
  description = "Key ID"
}
