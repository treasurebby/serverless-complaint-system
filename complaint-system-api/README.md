# Complaint System API

This project provides a serverless complaint management API using AWS Lambda and API Gateway, managed via Terraform.

## Setup Instructions

1. Install Terraform and AWS CLI.
2. Configure your AWS credentials.
3. Deploy infrastructure using Terraform in the `terraform/` directory.
4. Package and deploy Lambda functions from the `lambdas/` directory.

## Project Structure
- `terraform/`: Infrastructure as Code (API Gateway, Lambda, IAM)
- `lambdas/`: Python Lambda functions
- `build/`: Zipped Lambda artifacts
- `ci-cd/`: GitHub Actions workflows

## Endpoints
- `POST /submit-complaint`
- `GET /get-status`
