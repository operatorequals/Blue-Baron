#   The SIEM namespace contains the main log engine (elasticsearch/kibana),
# the alerting mechanism (praeco/elastalert), the data lake (mongodb) and
# the interconnector (fluentd)
siem-ns = "bluebaron-siem"

#   The Audit namespace contains the log collector (fluentd) and
# an Auditbeat Daemonset, as a testing log source.
audit-ns = "bluebaron-audit"
