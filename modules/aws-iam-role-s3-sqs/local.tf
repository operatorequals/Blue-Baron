locals {
  # Derive the SQS queue name from ARN - used to invoke 'data.aws_sqs_queue.queue'
  aws_sqs_queue_name = element(split(":", var.aws_sqs_queue_arn), 5)
  aws_sqs_queue_url = data.aws_sqs_queue.queue.url

}

data "aws_sqs_queue" "queue" {
  name = local.aws_sqs_queue_name
}
