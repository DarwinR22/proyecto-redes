output "website_endpoint" {
  description = "URL del sitio web estático en S3"
  value       = "${aws_s3_bucket.static_site.bucket}.s3-website.${var.region}.amazonaws.com"
}

output "logs_bucket_name" {
  description = "Nombre del bucket de logs"
  value       = aws_s3_bucket.logs.id
}

