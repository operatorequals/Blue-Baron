module "aws-s3-default" {
  source = "../../modules/aws-s3-default/"

  #  Name collisions are loosely avoided in this module
  # by appending random IDs to the value below.
  name = "bluebaron-logs"
}
