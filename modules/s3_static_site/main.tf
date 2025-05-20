# 🪣 Crear bucket S3 para hospedar sitio web estático
resource "aws_s3_bucket" "static_site" {
  bucket         = var.bucket_name     # Nombre personalizado del bucket (pasado como variable)
  force_destroy  = true                # Permite borrar el bucket incluso si contiene archivos

  tags = {
    Name        = "StaticSiteBucket"
    Environment = "Dev"
  }
}

# 🔓 Permitir acceso público al bucket (⚠️ solo si el objetivo es un sitio público)
resource "aws_s3_bucket_public_access_block" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 🌐 Configuración del sitio web estático (documento de inicio y error)
resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html" # Página que se muestra por defecto
  }

  error_document {
    key = "error.html"     # Página a mostrar en caso de error
  }
}

# 📜 Política que permite lectura pública de los archivos en el bucket
resource "aws_s3_bucket_policy" "allow_public_read" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",                      # Público general
        Action    = ["s3:GetObject"],         # Permite leer archivos
        Resource  = ["${aws_s3_bucket.static_site.arn}/*"]
      }
    ]
  })
}

# 📄 Subida del archivo principal (index.html) al bucket
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "index.html"                                # Nombre del objeto en S3
  source       = "${path.module}/index.html"                 # Ruta local al archivo
  content_type = "text/html"
}
