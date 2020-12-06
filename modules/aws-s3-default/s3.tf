resource "random_id" "bucket_name" {
  prefix      = "${var.name}-"
  byte_length = 8
}

resource "aws_s3_bucket" "bucket" {
  bucket        = random_id.bucket_name.dec
  force_destroy = true
  acl           = "private"

  tags = {
    Environment = "Blue-Baron"
    Project     = "https://github.com/operatorequals/Blue-Baron"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}
