provider "aws" {
    region = "us-east-2"
}

module "kms" {
    source        = "../../L1/kms"
    #  app_code      = var.app_code
    #  project_name  = var.project_name
    #  environment   = var.environment
    #  kms_secretsmanager_arn = module.secrets_manager.secret_arn
    kms_alias_name         = "${var.app_code}-${var.project_name}-${var.environment}"
    kms_description        = "KMS for application ${var.app_code}-${var.project_name}-${var.environment}"
}

module "secrets_manager" {
    source  = "../../L1/secretsmanager"
    depends_on = [module.kms]
    secret_description = "Secret for application ${var.app_code}-${var.project_name}-${var.environment}"
    app_code = var.app_code
    project_name = var.project_name
    environment = var.environment
    allowed_role_arn = module.iam_role.iam_role_arn
    
    # Conditional variables based on secret_type
    secret_string          = var.secret_type == "secret_string" ? var.string_template_value : null
    secret_string_template = var.secret_type == "string_template" ? var.string_template_value : null
    create_random_password = var.secret_type == "random" ? true : false
    random_password_length = var.secret_type == "random" ? var.password_length : 16

    # KMS key for encryption
    secret_kms_key_arn     = module.kms.kms_key_arn
}

module "iam_role" {
    source = "../../L1/iam-role"
    app_code = var.app_code
    project_name = var.project_name
    environment = var.environment
    assume_role_statements = var.assume_role_statements #!= null ? var.assume_role_statements : local.assume_role_statements
    policy_statements = var.custom_policy_statements #!= null ? var.custom_policy_statements : local.default_secrets_manager_policy_statements
}
