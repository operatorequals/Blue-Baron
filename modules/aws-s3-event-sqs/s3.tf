
resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  for_each = toset(local.aws_s3_prefixes)

  queue_url = aws_sqs_queue.sqs_queue[each.value].id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_queue[each.value].arn}",
      "Condition": {
        "ArnEquals": { "aws:SourceArn": "${local.aws_s3_bucket_arn}" }
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_notification" "s3_sqs_notification" {
  bucket = local.aws_s3_bucket_id

  dynamic "queue" {
    for_each = local.aws_s3_prefixes

    content {
      queue_arn     = aws_sqs_queue.sqs_queue[queue.value].arn
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = queue.value
    }
  }
}
