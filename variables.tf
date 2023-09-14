variable "policy" {
  description = "Object of attributes and attachments for an AWS Organizations Policy"
  type = object({
    name          = optional(string)
    content       = optional(string)
    create_policy = optional(bool, true)
    description   = optional(string)
    id            = optional(string)
    skip_destroy  = optional(bool)
    type          = optional(string)
    tags          = optional(map(string))

    attachments = optional(list(object({
      name         = string
      target_id    = string
      skip_destroy = optional(bool)
    })), [])
  })

  validation {
    condition = (
      var.policy.type != null ?
      contains(["AISERVICES_OPT_OUT_POLICY", "BACKUP_POLICY", "SERVICE_CONTROL_POLICY", "TAG_POLICY"], var.policy.type) :
      true
    )
    error_message = "Policy `type` must be one of: AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY, TAG_POLICY"
  }

  validation {
    condition     = var.policy.create_policy ? var.policy.name != null : true
    error_message = "Policy `name` is required when `create_policy` is true."
  }

  validation {
    condition     = var.policy.create_policy ? var.policy.content != null : true
    error_message = "Policy `content` is required when `create_policy` is true."
  }

  validation {
    condition     = !var.policy.create_policy ? var.policy.id != null : true
    error_message = "Policy `id` is required when `create_policy` is false."
  }

  validation {
    condition = (
      var.policy.create_policy && (var.policy.type == null || var.policy.type == "SERVICE_CONTROL_POLICY") ?
      length(jsonencode(jsondecode(var.policy.content))) <= 5120 :
      true
    )
    error_message = (
      var.policy.create_policy ?
      "Content length ${length(jsonencode(jsondecode(var.policy.content)))} of Service Control Policy \"${var.policy.name}\" exceeds max limit of 5120 characters." :
      ""
    )
  }

  validation {
    condition = (
      var.policy.type == "AISERVICES_OPT_OUT_POLICY" ?
      length(jsonencode(jsondecode(var.policy.content))) <= 2500 :
      true
    )
    error_message = (
      var.policy.create_policy ?
      "Content length ${length(jsonencode(jsondecode(var.policy.content)))} of AI Services Opt Out Policy \"${var.policy.name}\" exceeds max limit of 2500 characters." :
      ""
    )
  }

  validation {
    condition = (
      var.policy.type == "BACKUP_POLICY" ?
      length(jsonencode(jsondecode(var.policy.content))) <= 10000 :
      true
    )
    error_message = (
      var.policy.create_policy ?
      "Content length ${length(jsonencode(jsondecode(var.policy.content)))} of Backup Policy \"${var.policy.name}\" exceeds max limit of 10000 characters." :
      ""
    )
  }

  validation {
    condition = (
      var.policy.type == "TAG_POLICY" ?
      length(jsonencode(jsondecode(var.policy.content))) <= 10000 :
      true
    )
    error_message = (
      var.policy.create_policy ?
      "Content length ${length(jsonencode(jsondecode(var.policy.content)))} of Tag Policy \"${var.policy.name}\" exceeds max limit of 10000 characters." :
      ""
    )
  }
}
