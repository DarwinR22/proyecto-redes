resource "aws_eip" "this" {
  instance = var.instance_id
  domain   = "vpc"    # en lugar de `vpc = true`

  tags = merge(
    {
      Name       = var.name
      Project    = var.project
      Env        = var.environment
      CostCenter = var.cost_center
    },
    var.extra_tags
  )
}
