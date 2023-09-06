output "policy" {
  description = "Object of attrributes for the AWS Organizations Policy"
  value       = aws_organizations_policy.this
}

output "policy_attachments" {
  description = "Map of objects containing AWS Organizations Policy attachments"
  value       = aws_organizations_policy_attachment.this
}
