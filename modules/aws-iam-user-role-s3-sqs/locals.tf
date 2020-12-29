data "aws_sqs_queue" "queue" {
  name = local.aws_sqs_queue_name
}

locals {
  aws_iam_user_name = var.aws_iam_user_name == "" ? "aws-log-exporter-${random_id.user_name.dec}" : var.aws_iam_user_name
  aws_iam_user_path = var.aws_iam_user_path == "" ? "/bluebaron/" : var.aws_iam_user_path

  # Derive the SQS queue name from ARN - used to invoke 'data.aws_sqs_queue.queue'
  aws_sqs_queue_name = element(split(":", var.aws_sqs_queue_arn), 5)
  aws_sqs_queue_url = data.aws_sqs_queue.queue.url

}

