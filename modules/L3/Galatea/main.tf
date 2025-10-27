module "secret" {
    source  = "../../modules/L2/secret"
    version = "1.0.1"
    secret_type = var.secret_type
    environment = var.environment
    app_code = var.app_code
    project_name = var.project_name
    assume_role_statements = var.assume_role_statements
}

module "db" {
    source = "../../modules/L2/rds"
    environment = var.environment
    rds_sizing = 
}

data "aws_db_parameter_group" "example" {
    name = "your-parameter-group-name"
}
