# terraform-aws-tardigrade-organizations-policies

Terraform module for managing AWS Organizations Policies and their attachments.

This module supports every AWS Organizations Policy type, including:

* Service Control Policies (SCPs)
* Tag Policies
* Backup Policies
* AIServicesOptOut Policies

    >WARNING: The specified policy type must be enabled in the AWS Organizations
    >master account before it can be attached. Otherwise you will get an error
    >of the form:
    >
    >```
    >Error: creating Organizations Policy Attachment (target-id:policy-id): PolicyTypeNotEnabledException: This operation can be performed only for enabled policy types.
    >```

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.35.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.35.0 |

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_policy"></a> [policy](#input\_policy) | Object of attributes and attachments for an AWS Organizations Policy | <pre>object({<br>    name          = optional(string)<br>    content       = optional(string)<br>    create_policy = optional(bool, true)<br>    description   = optional(string)<br>    id            = optional(string)<br>    skip_destroy  = optional(bool)<br>    type          = optional(string)<br>    tags          = optional(map(string))<br><br>    attachments = optional(list(object({<br>      name         = string<br>      target_id    = string<br>      skip_destroy = optional(bool)<br>    })), [])<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy"></a> [policy](#output\_policy) | Object of attrributes for the AWS Organizations Policy |
| <a name="output_policy_attachments"></a> [policy\_attachments](#output\_policy\_attachments) | Map of objects containing AWS Organizations Policy attachments |

<!-- END TFDOCS -->
