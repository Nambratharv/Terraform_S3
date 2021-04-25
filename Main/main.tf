resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl = var.acl != "null" ? var.acl : null
  versioning {
      enabled = var.versioning
  }
  tags = var.tags
  //policy = data.aws_iam_policy_document.bucket_policy.json
  website {
    index_document = "index.html"
    error_document = "error.html"
    # routing_rules = <<EOF
    # [{
    #   "Condition": {
    #     "KeyPrefixEquals": "docs/"
    #   },
    #   "Redirect": {
    #     "ReplaceKeyPrefixWith": "documents/"
    #   }
    # }]
    # EOF
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.sse_algorithm
        kms_master_key_id = var.kms_master_key_arn
        //kms_master_key_id = "${data.aws_kms_alias.s3.arn}"
      }
    }
  }

  # dynamic "cors_rule" {
  #   for_each = var.cors_rule_inputs == null ? [] : var.cors_rule_inputs

  #   content {
  #     allowed_headers = cors_rule.value.allowed_headers
  #     allowed_methods = cors_rule.value.allowed_methods
  #     allowed_origins = cors_rule.value.allowed_origins
  #     expose_headers  = cors_rule.value.expose_headers
  #     max_age_seconds = cors_rule.value.max_age_seconds
  #   }
  # }
}

# data "aws_kms_alias" "s3" {
#  name = var.kms_alias
# }
data "aws_iam_user" "example" {
  user_name = var.user_arn
}
resource "aws_s3_bucket_policy" "this" {
  
  bucket = aws_s3_bucket.this.id
  
  policy = jsonencode({
  "Id": "MyBUCKETPOLICY",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3Allow",
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.this.arn}/*",
      "Principal": {
        "AWS": [
          "${data.aws_iam_user.example.arn}"
        ]
      }
    }
  ]
})
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
