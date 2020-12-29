resource "random_id" "user_name" {
  byte_length = 4
}

resource "aws_iam_user" "user" {
  name = local.aws_iam_user_name
  path = local.aws_iam_user_path

  # This is an automated user, should not have in-account dependencies
  #  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
  force_destroy = true

  tags = {
    Environment   = "Blue-Baron"
    Project       = "https://github.com/operatorequals/Blue-Baron"
    S3-Bucket-ARN = var.aws_s3_bucket_arn
    S3-Prefix     = var.aws_s3_prefix
    SQS-Url       = local.aws_sqs_queue_url
  }
}

resource "aws_iam_access_key" "user-keys" {
  user    = aws_iam_user.user.name
}
