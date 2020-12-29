output "arn" {
  value = aws_cloudtrail.cloudtrail.arn
}

output "id" {
  value = aws_cloudtrail.cloudtrail.id
}

output "aws_s3_prefix" {
  value = "AWSLogs/${data.aws_caller_identity.current.account_id}/CloudTrail"
}