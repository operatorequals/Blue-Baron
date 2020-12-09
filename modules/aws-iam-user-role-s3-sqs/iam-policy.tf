
data "aws_iam_policy_document" "user-policy" {
  statement {
    sid = "AllowS3BucketAccess"
    actions = ["S3:ListBucket"]
    resources = [
      "${var.aws_s3_bucket_arn}*",
    ]
  }

  statement {
    sid = "GetObject"
    actions = ["S3:GetObject"]
    resources = [
      "${var.aws_s3_bucket_arn}/${var.aws_s3_prefix}*",
    ]
  }

  statement {
    sid = "AccessSQS"
    actions = [
        "SQS:GetQueueUrl",
        "SQS:DeleteMessage",
        "SQS:ChangeMessageVisibility",
        "SQS:ReceiveMessage",
    ]
    resources = [
      var.aws_sqs_queue_arn,
    ]
  }

}


resource "aws_iam_user_policy" "user-policy" {
  name = "BlueBaron-Log-Exporter-Policy-${random_id.user_name.dec}"
  user = aws_iam_user.user.name

  policy = data.aws_iam_policy_document.user-policy.json
}

