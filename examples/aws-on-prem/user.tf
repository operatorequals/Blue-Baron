
module "user"{
  source = "../../modules/aws-iam-user-role-s3-sqs/"

  aws_sqs_queue_arn = module.aws-s3-event-sqs.aws_s3_sqs_map["${module.aws-s3-default.id}/${local.cloudtrail_s3_prefix}"].arn

  aws_s3_bucket_arn = module.aws-s3-default.arn

  aws_s3_prefix     = local.cloudtrail_s3_prefix
}


