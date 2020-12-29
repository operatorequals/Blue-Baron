# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail

resource "aws_cloudtrail" "cloudtrail" {
  name                          = "${var.name}-${random_id.cloudtrail_name.dec}"
  s3_bucket_name                = var.aws_s3_bucket_name
  include_global_service_events = true
  is_multi_region_trail         = true

  tags = {
    Environment = "Blue-Baron"
    Project     = "https://github.com/operatorequals/Blue-Baron"
    S3-Bucket   = var.aws_s3_bucket_name

  }
}
