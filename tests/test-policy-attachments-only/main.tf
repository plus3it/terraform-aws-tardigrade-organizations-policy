module "policy" {
  source = "../.."

  policy = {
    create_policy = false
    id            = aws_organizations_policy.test.id

    attachments = [
      {
        name      = "tardigrade-test-policy-attachment-${local.test_id}"
        target_id = data.aws_organizations_organization.this.roots[0].id
      }
    ]
  }
}

resource "aws_organizations_policy" "test" {
  name    = "tardigrade-test-policy-${local.test_id}"
  content = data.aws_iam_policy_document.admin.json
}

data "aws_iam_policy_document" "admin" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
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
