module "domains_infrastructure" {
  source                 = "/Users/zeshantariq/Documents/terraform-modules/domains/infrastructure"
  hosted_zone            = var.hosted_zone
  tags                   = var.tags
  deploy_default_records = var.deploy_default_records
}
