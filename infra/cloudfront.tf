resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "my-portfolio-oac"
  description                       = "Origin Access Control for S3 Bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "my_distribution" {
  origin {
    domain_name              = aws_s3_bucket.my_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = var.origin_id
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for my portfolio website"
  default_root_object = "index.html"
  price_class         = "PriceClass_100"

  aliases = var.aliases1

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.origin_id
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  depends_on = [aws_s3_bucket.my_bucket]

  tags = {
    Name = "my-portfolio-cloudfront"
  }
}