# IAM Role for Lambda execution
resource "aws_iam_role" "lambda_exec" {
  name = "complaint_lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach basic logging permissions so Lambda can write to CloudWatch
resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "lambda_role" {
    name = "complaint_lambda_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazoneaws.com"
            }
        }]
    })
}

resource "aws_iam_policy_attachement" "lambda_policy_attach" {
    name = "lambda_dynamodb_atttach"
    roles = [aws_iam_role.lambda_role.name]
    policy_arn = "arn:aws:iam: :aws:policy/AmazoneDynamoDBFullAccess"
}