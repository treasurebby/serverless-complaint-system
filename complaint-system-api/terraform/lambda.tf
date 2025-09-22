

resource "aws_lambda_function" "submit_complaint" {
    function_name    = "submit_complaint"
    role             = aws_iam_role.lambda_exec.arn
    handler          = "submit_complaint.lambda_handler"
    runtime          = "python3.12"
    filename         = "${path.module}/../build/submit_complaint.zip"
    source_code_hash = filebase64sha256("${path.module}/../build/submit_complaint.zip")
}

resource "aws_lambda_function" "get_status" {
    function_name    = "get_status"
    role             = aws_iam_role.lambda_exec.arn
    handler          = "get_status.lambda_handler"
    runtime          = "python3.12"
    filename         = "${path.module}/../build/get_status.zip"
    source_code_hash = filebase64sha256("${path.module}/../build/get_status.zip")
}


resource "aws_lambda_function" "complaint_processor" {
    function_name = "ComplaintProcessor"
    role = aws_iam_role.lambda_role.invoke_arn
    handler = "complaint_processor.lambda_handler"
    runtime = "python3.12"
    filename = "lambda.zip"
    source_code_hash = filebase64sha256("lambda.zip")
}