variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}
variable "origin_id" {
  description = "The ID of the CloudFront origin"
  type        = string
}
variable "oidc_provider_arn" {
  description = "The ARN of the OIDC provider"
  type        = string
}
variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate for CloudFront"
  type        = string
}