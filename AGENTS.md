# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module manages an AWS Organizations policy and its attachments. It takes a single `policy` object input that holds the policy name, content, type, and a list of attachments. It creates one `aws_organizations_policy` (unless `create_policy` is false, in which case it uses an existing policy `id`) and one `aws_organizations_policy_attachment` per attachment, and outputs `policy` and `policy_attachments`.
