data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "bucket" {
  bucket = var.aws_s3_bucket_name

}
