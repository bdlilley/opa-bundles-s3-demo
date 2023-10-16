module "s3" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "opa-demo-${data.aws_caller_identity.current.account_id}"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

output "s3-domain-name" {
    value = module.s3.s3_bucket_bucket_regional_domain_name
}

resource "aws_s3_object" "object" {
  bucket = module.s3.s3_bucket_id
  key    = "bundle.tar.gz"
  source = "${path.module}/bundle.tar.gz"
  etag = filemd5("${path.module}/bundle.tar.gz")
}