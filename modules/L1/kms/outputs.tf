output "kms_key_arn" {
  value       = join("", aws_kms_key.l1_kms[*].arn)
  description = "Key ARN"
}

output "kms_key_id" {
  value       = join("", aws_kms_key.l1_kms[*].key_id)
  description = "Key ID"
}