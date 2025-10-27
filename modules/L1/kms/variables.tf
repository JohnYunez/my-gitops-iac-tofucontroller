variable "kms_description" {
  type = string
  description = "kms description"
  default = "module-kms-default"
}
variable "kms_key_usage" {
  type        = string
  description = "ENCRYPT_DECRYPT, SIGN_VERIFY, or GENERATE_VERIFY_MAC."
  default     = "ENCRYPT_DECRYPT"
  validation {
    condition  = contains(["ENCRYPT_DECRYPT","SIGN_VERIFY","GENERATE_VERIFY_MAC"], var.kms_key_usage)
    error_message = "The key_usage is not valid (ENCRYPT_DECRYPT|SIGN_VERIFY|GENERATE_VERIFY_MAC)"
  }
}
#variable "kms_custom_key_store_id" {
#  type = string
#  description = "ID of the KMS Custom Key Store where the key will be stored instead of KMS (eg CloudHSM)."
#}
variable "kms_customer_master_key_spec" {
  type = string
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, HMAC_224, HMAC_256, HMAC_384, HMAC_512, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, ECC_SECG_P256K1, ML_DSA_44, ML_DSA_65, ML_DSA_87, or SM2 (China Regions only). Defaults to SYMMETRIC_DEFAULT"
  default = "SYMMETRIC_DEFAULT"
  validation {
    condition  = contains(["SYMMETRIC_DEFAULT", "RSA_2048", "RSA_3072", "RSA_4096", "HMAC_224", "HMAC_256", "HMAC_384", "HMAC_512", "ECC_NIST_P256", "ECC_NIST_P384", "ECC_NIST_P521", "ECC_SECG_P256K1", "ML_DSA_44", "ML_DSA_65", "ML_DSA_87", "SM2"], var.kms_customer_master_key_spec)
    error_message = "The customer_master_key_spec is not valid (SYMMETRIC_DEFAULT|RSA_2048|RSA_3072|RSA_4096|HMAC_224|HMAC_256|...)"
  }
}
variable "kms_deletion_window" {
  type = number
  description = "The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30."
  default = 30
  validation {
    condition     = var.kms_deletion_window >= 7 &&  var.kms_deletion_window <= 30
    error_message = "The deletion_window is not valid (Between 7 and 30)"
  }
}
variable "kms_is_enabled" {
  type = bool
  description = "Specifies whether the key is enabled. Defaults to true."
  default = true
}
variable "kms_enable_key_rotation" {
  type = bool
  description = " # required to be enabled if rotation_period_in_days is specified) Specifies whether key rotation is enabled. Defaults to false"
  default = false
}
variable "kms_rotation_period_in_days" {
  type = number
  description = "Custom period of time between each rotation date. Must be a number between 90 and 2560 (inclusive)."
  default = 90
  validation {
    condition     =  var.kms_rotation_period_in_days >= 90 &&  var.kms_rotation_period_in_days <= 2560
    error_message = "The rotation_period_in_days is not valid (Between 90 and 2560)"
  }
}
variable "kms_multi_region" {
  type = bool
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key. Defaults to false"
  default = false
}

variable "kms_secretsmanager_arn" {
  type = string
  description = "ARN of the secretmanager that use the KMS key"
  validation {
    condition  = length(var.kms_secretsmanager_arn) > 4 && substr(var.kms_secretsmanager_arn, 0, 4) == "arn:"
    error_message = "The arn is invalid (must start with arn)"
  }
}
