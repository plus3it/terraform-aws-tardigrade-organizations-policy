output "policy" {
  description = "Object of attributes for the AWS Organizations Policy"
  value       = var.policy.create_policy ? aws_organizations_policy.this[0] : null
}

output "policy_attachments" {
  description = "Map of objects containing AWS Organizations Policy attachments"
  value       = aws_organizations_policy_attachment.this
}
