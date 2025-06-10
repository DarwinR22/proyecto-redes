# 1. Bucket principal para sitio estático
resource "aws_s3_bucket" "static_site" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = merge(
    var.extra_tags,
    {
      Name       = var.bucket_name
      Project    = var.project
      Env        = var.environment
      CostCenter = var.cost_center
      Owner      = var.owner
    }
  )
}

# 2. Permitir acceso público (controlado)
resource "aws_s3_bucket_public_access_block" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = true
}

# 3. Configuración de sitio web
resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# 4. Política pública de solo lectura
resource "aws_s3_bucket_policy" "static_read" {
  bucket = aws_s3_bucket.static_site.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = ["s3:GetObject"],
      Resource  = ["${aws_s3_bucket.static_site.arn}/*"]
    }]
  })
}

# 5. Versionado (opcional pero útil)
resource "aws_s3_bucket_versioning" "static_site" {
  bucket = aws_s3_bucket.static_site.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 6. Logging (básico, útil para trazabilidad)
resource "aws_s3_bucket" "logs" {
  bucket        = "${var.bucket_name}-logs"
  force_destroy = true

  tags = merge(
    var.extra_tags,
    {
      Name       = "${var.bucket_name}-logs"
      Project    = var.project
      Env        = var.environment
      CostCenter = var.cost_center
      Owner      = var.owner
    }
  )
}

resource "aws_s3_bucket_logging" "static_site" {
  bucket        = aws_s3_bucket.static_site.id
  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "access/"
}

# 7. Archivos estáticos
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "error.html"
  source       = "${path.module}/error.html"
  content_type = "text/html"
}
