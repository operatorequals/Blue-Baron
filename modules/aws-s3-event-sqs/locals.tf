locals {
  aws_s3_bucket_arn = data.aws_s3_bucket.bucket.arn
  aws_s3_bucket_id = data.aws_s3_bucket.bucket.id

  aws_s3_prefixes = var.aws_s3_prefixes
}

data "aws_s3_bucket" "bucket" {
  bucket = var.aws_s3_bucket_name

}
