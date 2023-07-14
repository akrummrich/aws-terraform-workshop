data "aws_s3_object" "workshop_file_data" {
  bucket = aws_s3_bucket.workshop_bucket.bucket
  key = aws_s3_object.workshop_file.key
}