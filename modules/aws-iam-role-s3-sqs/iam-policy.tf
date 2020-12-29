
data "aws_iam_policy_document" "role_policy" {
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

resource "aws_iam_role_policy" "role_policy" {
  name = "BlueBaron-Log-Exporter-Policy-${random_id.role_name.dec}"
  role = aws_iam_role.role.id

  policy = data.aws_iam_policy_document.role_policy.json
}