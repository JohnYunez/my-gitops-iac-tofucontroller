variable "environment" {
    description = "Environment (e.g., dev, qa, pdn)"
    type        = string
    validation {
        condition     = can(regex("^(dev|qa|pdn)$", var.environment))
        error_message = "The environment must be one of 'dev', 'qa', or 'pdn'."
    }
}

variable "app_code" {
    description = "Application code"
    type        = string
    validation {
        condition     = can(regex("^[a-zA-Z0-9_-]+$", var.app_code)) && length(var.app_code) <= 64
        error_message = "The app_code must contain only letters, numbers, underscores, or hyphens, and be 64 characters or less."
    }
}

variable "project_name" {
    description = "Project name"
    type        = string
    validation {
        condition     = can(regex("^[a-zA-Z0-9_-]+$", var.project_name)) && length(var.project_name) <= 64
        error_message = "The project_name must contain only letters, numbers, underscores, or hyphens, and be 64 characters or less."
    }
}

variable "secret_description" {
    description = "Description of the secret"
    type        = string
    validation {
        condition     = length(var.secret_description) <= 2048
        error_message = "The secret_description must be 2048 characters or less."
    }
}

 variable "secret_kms_key_arn" {
     description = "KMS Key ID for secret encryption"
     type        = string
     default     = null
     validation {
         condition     = can(regex("^arn:aws:kms:[a-z0-9-]+:[0-9]{12}:key/[a-f0-9-]+$", var.secret_kms_key_arn))
         error_message = "secret_kms_key_arn must be a valid KMS Key ARN."
     }
 }

variable "allowed_role_arn" {
    description = "IAM Role ARN allowed to access the secret"
    type        = string
    validation {
        condition     = can(regex("^arn:aws:iam::[0-9]{12}:role/.+", var.allowed_role_arn))
        error_message = "The allowed_role_arn must be a valid IAM Role ARN."
    }
}

variable "secret_string_template" {
    description = "Template for secret string (JSON format)"
    type        = string
    default     = null
    validation {
        condition     = var.secret_string_template == null || can(jsondecode(var.secret_string_template))
        error_message = "The secret_string_template must be a valid JSON string or null."
    }
}

variable "create_random_password" {
    description = "Whether to create a random password"
    type        = bool
    default     = false
}

variable "random_password_length" {
    description = "The length of the random password to generate. Used if create_random_password is true."
    type        = number
    default     = 16
}

variable "secret_string" {
    description = "Secret string value. Used if not use a template or random password."
    type        = string
    default     = ""
    sensitive   = true
}