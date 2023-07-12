output "s3_bucket_website_endpoint" {
  description = "Website endpoint"
  value       = try(aws_s3_bucket_website_configuration.s3_website_configuration.website_endpoint, "")
}