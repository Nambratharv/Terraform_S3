variable "bucket_name" {
    type = string
}
variable "region" {
  description = "To be selected from: US-East-NV, US-West-NC, Mumbai, Africa"
    type = map
    default = {
        "US-East-NV" = "us-east-1"
        "US-West-NC" = "us-west-1"
        "Mumbai" = "ap-south-1"
        "Africa" = "af-south-1"
    }
}
variable "regionvalue" {
  description = "To be selected from: US-East-NV, US-West-NC, Mumbai, Africa"
    type = string
    default = "US-East-NV"
}

variable "versioning" {
    description = "(Optional)"
    type = bool
    default = true
}
variable "acl" {
  description = "(Optional) The canned ACL to apply. Defaults to 'private'. Conflicts with `grant`"
  type        = string
  default     = "private"
}
variable "tags" {
  description = "(Optional) A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}

variable "policy" {
  description = "(Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  type        = string
  default     = null
}
 variable "user_arn" {
     description = "Attach the name of the User to be used"
     type        = string
     default     = "sys_admin"
 }
variable "sse_algorithm" {
  type        = string
  default     = "aws:kms"
  description = "The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms`"
}
variable "sse_al" {
    default = "aws:kms"
  }
variable "kms_master_key_arn" {
  type = string
  default = "arn:aws:kms:us-east-1:344504139428:key/b8c38efc-4278-4aca-b48b-9d3fb150ca6d"
  description = "The AWS KMS master key ARN used for the `SSE-KMS` encryption. This can only be used when you set the value of `sse_algorithm` as `aws:kms`. The default alias/alias AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms`"
}
# variable "kms_master_key_arn" {
#   type        = string
#   //default     = ""
#   description = "The AWS KMS master key ARN used for the `SSE-KMS` encryption. This can only be used when you set the value of `sse_algorithm` as `aws:kms`. The default aws/s3 AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms`"
# }
# variable "cors_rule_inputs" {
#   type = list(object({
#     allowed_headers = list(string)
#     allowed_methods = list(string)
#     allowed_origins = list(string)
#     expose_headers  = list(string)
#     max_age_seconds = number
#   }))
#   //default = null

#   description = "Specifies the allowed headers, methods, origins and exposed headers when using CORS on this bucket"
# }