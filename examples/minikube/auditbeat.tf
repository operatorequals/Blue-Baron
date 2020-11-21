module "auditbeat" {
  source = "../../modules/auditbeat"

  namespace = var.audit-ns

  collector-url = module.collector.collector_beats_url
}