resource "aws_dynamodb_table" "visitor_count" {
  name         = "visitor_count"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "cv_id"

  attribute {
    name = "cv_id"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name = "visitor_count"
  }
}
