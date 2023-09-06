module "policy" {
  source = "../.."

  policy = {
    name    = "tardigrade-test-policy-${local.test_id}"
    content = data.aws_iam_policy_document.admin.json
  }
}

data "aws_iam_policy_document" "admin" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "random_string" "test_id" {
  length  = 6
  upper   = false
  special = false
  numeric = false
}

locals {
  test_id = resource.random_string.test_id.result
}
