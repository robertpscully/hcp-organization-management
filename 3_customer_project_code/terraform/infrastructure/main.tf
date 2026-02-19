resource "aws_s3_bucket" "example" {
  bucket = local.bucket_name
  tags   = local.bucket_tags
}

resource "random_string" "s3_bucket_suffix" {
  keepers = {
    "version" : "v1"
  }
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}