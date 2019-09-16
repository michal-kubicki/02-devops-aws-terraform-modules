output "bucker_arn" {
  value       = aws_s3_bucket.terraform_state_files.arn
  description = "The ARN of the S3 bucket holding state files"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.tf_locks.name
  description = "The name of the DynamoDB table holding file locks"
}