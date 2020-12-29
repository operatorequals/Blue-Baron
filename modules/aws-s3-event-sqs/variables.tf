variable aws_s3_bucket_name {
    description = "The S3 bucket to register the Event Notifications for SQS"
}

variable aws_s3_prefixes {
    description = "A List of directories to be monitored for \"S3:ObjectCreated:*\" event (without starting or trailing \"/\")"
    type = set(string)
    default = []
}
