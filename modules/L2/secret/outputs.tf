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