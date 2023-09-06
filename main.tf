resource "aws_organizations_policy" "this" {
  count = var.policy.create_policy ? 1 : 0

  name    = var.policy.name
  content = var.policy.content

  description  = var.policy.description
  skip_destroy = var.policy.skip_destroy
  type         = var.policy.type
  tags         = var.policy.tags
}

resource "aws_organizations_policy_attachment" "this" {
  for_each = { for attachment in var.policy.attachments : attachment.name => attachment }

  policy_id    = var.policy.create_policy ? aws_organizations_policy.this[0].id : var.policy.id
  target_id    = each.value.target_id
  skip_destroy = each.value.skip_destroy
}
