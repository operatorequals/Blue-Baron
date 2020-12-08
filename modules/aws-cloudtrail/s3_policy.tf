resource "random_id" "cloudtrail_name" {
  byte_length = 4
}


resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket   = var.aws_s3_bucket_name

  policy = data.aws_iam_policy_document.cloudtrail.json
}


data "aws_iam_policy_document" "cloudtrail" {

  statement {
    sid       = "AWSCloudTrailAclCheck-${random_id.cloudtrail_name.dec}"
    effect    = "Allow"
    resources = [data.aws_s3_bucket.bucket.arn]
    actions   = ["s3:GetBucketAcl"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

  statement {
    sid       = "AWSCloudTrailWrite-${random_id.cloudtrail_name.dec}"
    effect    = "Allow"
    resources = ["${data.aws_s3_bucket.bucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    actions   = ["s3:PutObject"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

}