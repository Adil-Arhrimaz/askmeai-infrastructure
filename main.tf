module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  environment          = local.environment
  vpc_cidr_block       = local.config.vpc_cidr_block
  public_subnet_cidrs  = local.config.public_subnet_cidrs
  private_subnet_cidrs = local.config.private_subnet_cidrs
  availability_zones   = local.config.availability_zones
  tags = merge(
    {
      "Project"     = var.project_name,
      "Environment" = local.environment
    },
    local.config.tags
  )
}
