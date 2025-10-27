output "secret_arn" {
    description = "ARN of the created secret"
    value       = module.secret.secret_arn
}

output "secret_name" {
    description = "Name of the created secret"
    value       = module.secret.secret_name
}
