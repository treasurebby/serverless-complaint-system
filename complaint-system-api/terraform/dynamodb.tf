resource "aws_dynamodb_table" "complaints" {
  name           = "complaints"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "complaintId"

  attribute {
    name = "complaintId"
    type = "S"
  }

  tags = {
    Environment = "dev"
    Project     = "ComplaintSystemAPI"
  }
}





