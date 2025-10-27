mock_provider "aws" {
    alias = "mock"
}

override_data {
    target = data.aws_iam_policy_document.assume_role
    values = {
        json = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Action\":\"sts:AssumeRole\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"}}]}"
    }    
}

override_data {
    target = data.aws_iam_policy_document.policy
    values = {
        json = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"AllowSpecificRoleAccess\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::123456789012:role/test-role\"},\"Action\":[\"secretsmanager:GetSecretValue\",\"secretsmanager:DescribeSecret\"],\"Resource\":\"arn:aws:secretsmanager:us-east-1:123456789012:secret:mocksecret\"}]}"
    }    
}

run "test-role-created" {
    providers = {
        aws = aws.mock
    }

    assert {
        condition     = aws_iam_role.this.id != null && aws_iam_role.this.id != ""
        error_message = "Role should have a valid ID"
    }
}