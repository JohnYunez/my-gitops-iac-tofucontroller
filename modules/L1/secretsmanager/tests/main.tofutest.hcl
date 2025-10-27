mock_provider "aws" {
    alias = "mock"
    mock_resource "aws_secretsmanager_secret" {
        defaults = {
            arn  = "arn:aws:secretsmanager:us-east-1:123456789012:secret:mocksecret"
        }
    }
    mock_data "aws_iam_policy_document" {
        defaults = {
            json = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"AllowSpecificRoleAccess\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::123456789012:role/test-role\"},\"Action\":[\"secretsmanager:GetSecretValue\",\"secretsmanager:DescribeSecret\"],\"Resource\":\"arn:aws:secretsmanager:us-east-1:123456789012:secret:mocksecret\"}]}"
        }
    }
}
run "test-secret-created" {
    providers = {
        aws = aws.mock
    }
    
    assert {
        condition     = aws_secretsmanager_secret.this.name == "aw1234567-observabilidad-dev-secret"
        error_message = "Secret name should match expected pattern"
    }
}

run "test-secret-random-password" {
    providers = {
        aws = aws.mock
    }

    variables {
        create_random_password = true
        random_password_length = 12
    }
    
    assert {
        condition     = length(random_password.this.result) == var.random_password_length
        error_message = "Random password length should match the specified length"
    }
}