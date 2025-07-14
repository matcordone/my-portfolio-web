# Bucket for the portfolio website
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# Enable website hosting on the S3 bucket
resource "aws_s3_bucket_website_configuration" "my_bucket_website" {
  bucket = aws_s3_bucket.my_bucket.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# Block public access to the S3 website bucket
resource "aws_s3_bucket_public_access_block" "my_bucket_pab" {
  bucket = aws_s3_bucket.my_bucket.id
  # Blocked accesses to the bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
           Sid = "AllowCloudFrontServicePrincipalReadOnlyAccess"
           Effect = "Allow"
           Principal = {
                Service = "cloudfront.amazonaws.com"
           }
           Action = "s3:GetObject"
           Resource = "${aws_s3_bucket.my_bucket.arn}/*"
           Condition = {
                StringEquals = {
                    "AWS:SourceArn" = "${aws_cloudfront_distribution.my_distribution.arn}"
                }
           }
        }
        
    ]
  })

}