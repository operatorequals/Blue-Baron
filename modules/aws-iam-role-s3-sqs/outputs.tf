output "arn" {
  description = "ARN of the IAM Role"
  value       = aws_iam_role.role.arn
}

output "name" {
  description = "Name of the IAM Role"
  value       = aws_iam_role.role.name
}
