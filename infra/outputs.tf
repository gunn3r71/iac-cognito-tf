output "pool_arn" {
  value = aws_cognito_user_pool.this.arn
}

output "pool_domain" {
  value = aws_cognito_user_pool.this.domain
}

output "pool_endpoint" {
  value = aws_cognito_user_pool.this.endpoint
}

output "pool_client_id" {
  value = aws_cognito_user_pool_client.this.id
}
