variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "us-east-1"
    validation {
        condition     = var.aws_region == "us-east-1" || var.aws_region == "us-east-2"
        error_message = "The aws_region must be a valid AWS region, e.g., us-east-1."
    }
}

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
    default = []
    validation {
        condition     = alltrue([for s in var.assume_role_statements : can(regex("^(sts:AssumeRole)$", s.actions[0]))])
        error_message = "Each assume role statement must have 'sts:AssumeRole' as an action."
    }
}

variable "policy_statements" {
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
        condition     = alltrue([for s in var.policy_statements : can(regex("^(Allow|Deny)$", s.effect))])
        error_message = "Each policy statement must have 'Allow' or 'Deny' as an effect."
    }
}