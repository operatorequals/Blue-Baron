resource "random_id" "role_name" {
  byte_length = 4
}

data "aws_iam_policy_document" "assume_policy" {

  dynamic "statement" {
    for_each = var.assume_arns

    content {
      effect = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = var.assume_arns
      }
    }
  }

  dynamic "statement" {
    for_each = var.assume_services
    content {
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "Service"
        identifiers = var.assume_services
      }
    }
  }
}


# resource "aws_iam_role_policy_attachment" "attachment" {
#   role       = aws_iam_role.role.name
#   policy_arn = aws_iam_policy.role_policy.arn
# }


resource "aws_iam_role" "role" {
  name = "BlueBaron-Log-Exporter-Role-${random_id.role_name.dec}"

  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF

  tags = {
    Environment   = "Blue-Baron"
    Project       = "https://github.com/operatorequals/Blue-Baron"
    S3-Bucket-ARN = var.aws_s3_bucket_arn
    S3-Prefix     = var.aws_s3_prefix
    SQS-Url       = local.aws_sqs_queue_url
  }
}
