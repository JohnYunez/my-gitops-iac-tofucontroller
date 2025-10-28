output "kms_key_arn" {
  value       = join("", aws_kms_key.l1_kms_key[*].arn)
  description = "Key ARN"
}

output "kms_key_id" {
  value       = join("", aws_kms_key.l1_kms_key[*].key_id)
  description = "Key ID"
}