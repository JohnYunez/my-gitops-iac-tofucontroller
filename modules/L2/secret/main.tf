module "secrets_manager" {
    source  = "https://artifactory.apps.bancolombia.com/artifactory/common-terraform-modules/bancolombia/L1-secretsmanager/aws"
    version = "1.0.1"
    secret_description = "Secret for application ${var.app_code}-${var.project_name}"
    app_code = var.app_code
    project_name = var.project_name
    environment = var.environment
    allowed_role_arn = module.iam_role.iam_role_arn
    
    # Conditional variables based on secret_type
    secret_string_template = var.secret_type == "string_template" ? var.string_template_value : null
    create_random_password = var.secret_type == "random" ? true : false
    random_password_length = var.secret_type == "random" ? var.password_length : 16
}

module "iam_role" {
    source = "https://artifactory.apps.bancolombia.com/artifactory/common-terraform-modules/bancolombia/L1-iam-role/aws"
    version = "1.0.0"
    app_code = var.app_code
    project_name = var.project_name
    environment = var.environment
    assume_role_statements = var.assume_role_statements #!= null ? var.assume_role_statements : local.assume_role_statements
    policy_statements = var.custom_policy_statements #!= null ? var.custom_policy_statements : local.default_secrets_manager_policy_statements
}