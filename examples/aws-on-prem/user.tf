# These modules creates an IAM Role or User with a Policy that allows
# * ListObject to the given S3 bucket
# * GetObject to the given S3 prefix
# * ReceiveMessage and other configuration Actions to the given SQS


#   An IAM User can be created in case the monitoring infrastructure
# is not itself deployed in AWS.
# In that case, the ingester has to access the S3 and SQS AWS services
# as a user, with Access Key ID and Secret Access Key
#

module "user"{
  source = "../../modules/aws-iam-user-role-s3-sqs/"

  aws_sqs_queue_arn = module.aws-s3-event-sqs.aws_s3_sqs_map["${module.aws-s3-default.id}/${local.cloudtrail_s3_prefix}"].arn

  aws_s3_bucket_arn = module.aws-s3-default.arn
  aws_s3_prefix     = local.cloudtrail_s3_prefix
}


#   An IAM Role can be created in case the monitoring infrastructure
# is deployed in AWS, as in EKS or vanilla Kubernetes with Kube2IAM or kiam deployment.
# The ingester Pod can be annotated with the role's ARN
# or in case of EKS to the Kubernetes service account.
#

# module "role" {
#   source "../../modules/aws-iam-role-s3-sqs"

#   aws_sqs_queue_arn = module.aws-s3-event-sqs.aws_s3_sqs_map["${module.aws-s3-default.id}/${local.cloudtrail_s3_prefix}"].arn

#   aws_s3_bucket_arn = module.aws-s3-default.arn
#   aws_s3_prefix     = local.cloudtrail_s3_prefix
# }
