# 🌍 URL pública del sitio web estático en S3
output "website_endpoint" {
  description = "Endpoint del sitio web estático en S3"
  value       = aws_s3_bucket_website_configuration.static_site.website_endpoint
}
