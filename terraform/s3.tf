resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "artifact_bucket" {
  bucket        = "demo-artifact-bucket-${random_id.bucket_id.hex}"
  force_destroy = true

  tags = {
    Name        = "ArtifactBucket"
    Environment = "dev"
  }
}
