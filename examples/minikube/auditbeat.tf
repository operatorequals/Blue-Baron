module "auditbeat" {
  source = "../../modules/auditbeat"

  namespace = "default"

  collector-url = module.collector.collector_beats_url
}