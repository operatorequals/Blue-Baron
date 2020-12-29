module "aws-cloudtrail" {
  source = "../../modules/aws-cloudtrail/"

  #  Name collisions are loosely avoided in this module
  # by appending random IDs to the value below.
  name = "bluebaron-trail"
  aws_s3_bucket_name = module.aws-s3-default.id
}
