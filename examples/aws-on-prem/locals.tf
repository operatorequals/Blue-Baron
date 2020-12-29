locals {

  # Unload the S3 prefix into a local variable to avoid the below Terraform error
  /*
  Error: Invalid for_each argument
  [...]
  The "for_each" value depends on resource attributes that cannot be determined
until apply [...]
  */
  cloudtrail_s3_prefix = module.aws-cloudtrail.aws_s3_prefix

}
