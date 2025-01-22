module "policy" {
  source = "../.."

  policy = {
    name    = "tardigrade-test-policy-${local.test_id}"
    content = data.aws_iam_policy_document.admin.json
    type    = "RESOURCE_CONTROL_POLICY"

    attachments = [
      {
        name      = "tardigrade-test-policy-attachment-${local.test_id}"
        target_id = data.aws_organizations_organization.this.roots[0].id
      }
    ]
  }
}

data "aws_iam_policy_document" "admin" {
  statement {
    sid       = "AllowAllActions"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

data "aws_organizations_organization" "this" {}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}

locals {
  test_id = data.terraform_remote_state.prereq.outputs.random_string.result
}
