resource "aws_api_gateway_rest_api" "complaint_api" {
    name        = "ComplaintSystemAPI"
    description = "API for submitting complaints and checking status"
}

# /submit-complaint resource
resource "aws_api_gateway_resource" "submit_complaint" {
    rest_api_id = aws_api_gateway_rest_api.complaint_api.id
    parent_id   = aws_api_gateway_rest_api.complaint_api.root_resource_id
    path_part   = "submit-complaint"
}

# /get-status resource
resource "aws_api_gateway_resource" "get_status" {
    rest_api_id = aws_api_gateway_rest_api.complaint_api.id
    parent_id   = aws_api_gateway_rest_api.complaint_api.root_resource_id
    path_part   = "get-status"
}

# POST /submit-complaint method
resource "aws_api_gateway_method" "submit_complaint_post" {
    rest_api_id   = aws_api_gateway_rest_api.complaint_api.id
    resource_id   = aws_api_gateway_resource.submit_complaint.id
    http_method   = "POST"
    authorization = "NONE"
}

# GET /get-status method
resource "aws_api_gateway_method" "get_status_get" {
    rest_api_id   = aws_api_gateway_rest_api.complaint_api.id
    resource_id   = aws_api_gateway_resource.get_status.id
    http_method   = "GET"
    authorization = "NONE"
}

# Integration for POST /submit-complaint
resource "aws_api_gateway_integration" "submit_complaint_integration" {
    rest_api_id             = aws_api_gateway_rest_api.complaint_api.id
    resource_id             = aws_api_gateway_resource.submit_complaint.id
    http_method             = aws_api_gateway_method.submit_complaint_post.http_method
    integration_http_method = "POST"
    type                    = "AWS_PROXY"
    uri                     = aws_lambda_function.submit_complaint.invoke_arn
}

# Integration for GET /get-status
resource "aws_api_gateway_integration" "get_status_integration" {
    rest_api_id             = aws_api_gateway_rest_api.complaint_api.id
    resource_id             = aws_api_gateway_resource.get_status.id
    http_method             = aws_api_gateway_method.get_status_get.http_method
    integration_http_method = "POST"
    type                    = "AWS_PROXY"
    uri                     = aws_lambda_function.get_status.invoke_arn
}
    http_method = aws_api_gateway_method.get_status_get.http_method
    integration_http_method = "GET"
    type = "AWS_PROXY"
    uri = aws_lambda_function.get_status.invoke_arn
    
}

#permissions so api gateway can call the lambda
resource "aws_lambda_permissions" "allow_api_gw_submit" {
    statement_id = "AllowAPIGatewayInvokeSubmit"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.submit_complaint.function_name
    principal = "apigateway.amazonaws.com"
    source_arn = "${aws_api_gateway_rest_api.complaint_api.execution_arn}/*/POST/submit_complaint

}
resource "aws_lambda_permissions" "allow_api_gw_get" {
    statement_id = "AllowAPIGatewayInvokeGet"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.get_status.function_name
    principal = "apigateway.amazonaws.com"
    source_arn = "${aws_api_gateway_rest_api.complaint_api.execution_arn}/*/GET/get_status"
    
}

#deployment + get_status_get
resource "aws_api_gateway_deployment" "complaint_api" {
    rest_api_id = aws_api_gateway_rest_api.complaint_api.id
    depends_on = [
        aws_api_gateway_integration.submit_complaint,
        aws_api_gateway_integration.get_status
    ]
}

resource "aws_api_gateway_stage" "dev" {
    rest_api_id = aws_api_gateway_rest_api.complaint_api.id
    deployment_id = aws_api_gateway_deployment.complaint_api.id
    stage_name = "dev"
}