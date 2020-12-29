output "aws_s3_sqs_map" {
  description = "A map with S3 dicrectories as keys pointing to maps following the schema: {\"url\":\"queue_url\", \"arn\":\"queue_arn\"}."
  # Documented at:
  #   https://www.bogotobogo.com/DevOps/Terraform/Terraform-Introduction-AWS-loops.php
  value = {
    for each in toset(local.aws_s3_prefixes):
      "${local.aws_s3_bucket_id}/${each}" => map("url",aws_sqs_queue.sqs_queue[each].id,"arn",aws_sqs_queue.sqs_queue[each].arn)
  }
}
