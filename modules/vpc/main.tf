resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name        = "secure-vpc"
      Project     = "redesYa"
      Env         = var.environment         # 
      Owner       = "Darwin Lopez "
      CostCenter  = "SECNET"
    },
    var.extra_tags                          # admite tags adicionales opcionales
  )
}

# ——— Flow Logs ———
resource "aws_cloudwatch_log_group" "vpc_flows" {
  name              = "/aws/vpc/${aws_vpc.this.id}/flowlogs"
  retention_in_days = 14
}

resource "aws_iam_role" "vpc_flowlogs" {
  name = "redesYa-vpc-flowlogs-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [{
    "Action": "sts:AssumeRole",
    "Principal": { "Service": "vpc-flow-logs.amazonaws.com" },
    "Effect": "Allow"
  }]
}
POLICY
}

resource "aws_iam_role_policy" "vpc_flowlogs" {
  name   = "policy"
  role   = aws_iam_role.vpc_flowlogs.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = "logs:PutLogEvents"
      Effect   = "Allow"
      Resource = aws_cloudwatch_log_group.vpc_flows.arn
    }]
  })
}

resource "aws_flow_log" "this" {
  iam_role_arn    = aws_iam_role.vpc_flowlogs.arn
  log_destination = aws_cloudwatch_log_group.vpc_flows.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.this.id
}
