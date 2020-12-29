variable "assume_arns" {
  default = []
}

variable "assume_services" {
  default = ["ec2.amazonaws.com"]
}

variable "aws_sqs_queue_arn" {
}

variable "aws_s3_bucket_arn" {
}

variable "aws_s3_prefix" {
}
