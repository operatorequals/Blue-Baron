module "filebeat" {
  source = "../../modules/filebeat"

  namespace = var.audit-ns

  collector-url = module.collector.collector_beats_url
}