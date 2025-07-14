output "distribution_domain_name" {
  description = "The Cloudfront distribution domain name"
  value       = aws_cloudfront_distribution.my_distribution.domain_name
}
