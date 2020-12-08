module "aws-s3-event-sqs" {
  source = "../../modules/aws-s3-event-sqs/"

  aws_s3_bucket_name = module.aws-s3-default.id

  aws_s3_prefixes = [
    local.cloudtrail_s3_prefix
  ]
}
