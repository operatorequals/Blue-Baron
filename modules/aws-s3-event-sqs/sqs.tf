resource "aws_sqs_queue" "sqs_queue" {
  for_each = toset(var.aws_s3_prefixes)

  # The name needs several replacements to be used as an SQS name
  # as they are treated as URLs:
  #   / -> -
  #   . -> _
  # bucket-AWSLogs/1234/CloudTrail -> bucket-AWSLogs_1234_CloudTrail
  name                        = "${local.aws_s3_bucket_id}-${replace(replace(each.value, "/", "-"), ".", "_")}"
  delay_seconds               = 0
  fifo_queue                  = false
  content_based_deduplication = false
  message_retention_seconds   = 86400

  tags = {
    Environment = "Blue-Baron"
    Project     = "https://github.com/operatorequals/Blue-Baron"
    S3-Bucket   = local.aws_s3_bucket_id
    S3-Prefix   = each.value
  }
}
