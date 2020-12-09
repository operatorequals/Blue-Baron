output "aws_iam_user_arn" {
  value = aws_iam_user.user.arn
}

output "aws_iam_user_unique_id" {
  value = aws_iam_user.user.unique_id
}
 
output "access_key_id" {
  value = aws_iam_access_key.user-keys.id
}

output "secret_access_key" {
  value = aws_iam_access_key.user-keys.secret
}
