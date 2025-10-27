
run "test-secret-created" {
    assert {
        condition     = module.secrets_manager.secret_arn != null
        error_message = "Secret should have a valid Arn"
    }
}