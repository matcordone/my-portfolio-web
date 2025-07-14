data "aws_iam_openid_connect_provider" "oidc" {
  arn = var.oidc_provider_arn
}

resource "aws_iam_role" "github_actions_role" {
  name = "MyPortfolioGithubActionsRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Federated = "${data.aws_iam_openid_connect_provider.oidc.arn}"
      },
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
        },
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:matcordone/my-portfolio-web:ref:refs/heads/main"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "github_actions_policy" {
  name        = "MyPortfolioGithubActionsPolicy"
  description = "Policy for GitHub Actions to access S3 and CloudFront"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        Resource = [
          "${aws_s3_bucket.my_bucket.arn}",
          "${aws_s3_bucket.my_bucket.arn}/*",
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "cloudfront:CreateInvalidation"
        ],
        Resource = "*"
      }
    ]
  }) 
}

resource "aws_iam_policy_attachment" "github_actions_policy_attachment" {
  name       = "MyPortfolioGithubActionsPolicyAttachment"
  roles      = [aws_iam_role.github_actions_role.name]
  policy_arn = aws_iam_policy.github_actions_policy.arn
}