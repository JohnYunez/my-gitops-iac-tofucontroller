# L2 Secret Module

This module provisions an AWS Secrets Manager secret and an IAM role with permissions to access the secret. It is designed for secure storage and controlled access to sensitive information such as credentials, API keys, or configuration values.

## Features

- Creates an AWS Secrets Manager secret.
- Creates an IAM role with permissions to read the secret.
- Outputs the secret ARN and IAM role ARN for integration.