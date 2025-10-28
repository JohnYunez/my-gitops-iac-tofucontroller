variable "aws_region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "us-east-2"
}
variable "app_code" {
    description = "The application code identifier"
    type        = string
}

variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "environment" {
    description = "The deployment environment (e.g., dev, prod)"
    type        = string
}

variable "secret_type" {
    description = "Type of secret to create: 'string_template' for a templated secret string, 'random' for generated username/password"
    type        = string
    validation {
        condition     = contains(["string_template", "random", "secret_string"], var.secret_type)
        error_message = "secret_type must be either 'string_template', 'random' or 'secret_string'."
    }
}

variable "string_template_value" {
    description = "The value to use for the secret when secret_type is 'string_template'"
    type        = string
    default     = ""
}

variable "password_length" {
    description = "Length of the random password when secret_type is 'random'"
    type        = number
    default     = 16
}

variable "assume_role_statements" {
    description = "List of assume role statements"
    type = list(object({
        effect  = optional(string, "Allow")
        actions = optional(list(string), ["sts:AssumeRole"])
        principals = object({
            type        = optional(string, null)
            identifiers = optional(list(string), null)
        })
    }))
    default = null
    validation {
        condition     = alltrue([for s in var.assume_role_statements : can(regex("^(sts:AssumeRole)$", s.actions[0]))])
        error_message = "Each assume role statement must have 'sts:AssumeRole' as an action."
    }
}

variable "assume_role_type" {
    description = "The type of role to assume: 'Service' for AWS service role, 'AWS' for standard AWS IAM role. Used if assume_role_statements is not provided."
    type        = string
    default     = "Service"
    validation {
        condition     = contains(["Service", "AWS"], var.assume_role_type)
        error_message = "assume_role_type must be either 'service' or 'aws'."
    }
}

variable "assume_role_identifiers" {
    description = "List of identifiers for the principals allowed to assume the role. Used if assume_role_statements is not provided."
    type        = list(string)
    default     = []
}

variable "custom_policy_statements" {
    description = "List of policy statements to attach to the IAM role"
    type = list(object({
        sid       = optional(string, null)
        actions   = list(string)
        resources = list(string)
        effect    = optional(string, "Allow")
        condition = optional(object({
            test     = optional(string, null)
            variable = optional(string, null)
            values   = optional(list(string), [])
        }), null)
    }))
    default = []
    validation {
        condition     = alltrue([for s in var.custom_policy_statements : can(regex("^(Allow|Deny)$", s.effect))])
        error_message = "Each policy statement must have 'Allow' or 'Deny' as an effect."
    }
}