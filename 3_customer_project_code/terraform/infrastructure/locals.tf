locals {
  hashitalks_tag = var.hashitalks_tag != "" ? { "hashitalks2026" = var.hashitalks_tag } : {}
  bucket_tags = merge(
    {
      Name        = "hashitalks2026-demo-bucket"
      Environment = "Dev"
    },
    local.hashitalks_tag
  )

  bucket_name = "${local.prefix}hashitalks2026-demo-${random_string.s3_bucket_suffix.id}"
  prefix      = length(var.bucket_prefix) > 0 ? "${var.bucket_prefix}-" : ""

}