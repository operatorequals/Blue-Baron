variable subscription_id {
}

variable resource_group_name {
    default = "bluebaron"
}

variable eventhub_namespace_name {
    default = "blueBaronEventHubNamespace"
}

variable eventhub_name {
    description = "Activity Logs Eventhub name"
    default = "insights-activity-logs"    
}

variable diagnostic_name {
    description = "Activity Logs Diagnostic Setting Name"
    default = "bluebaron-activity-logs"
}

# variable eventhub_authorization_rule_id {}

variable activity_logs {
    description = "Enabled Activity Log Categories"
    default = [
    # ["Audit category name",  "Audit enabled)"] 
        ["Administrative", true],
        ["Security", true],
        ["ServiceHealth", true],
        ["Alert", true],
        ["Recommendation", true],
        ["Policy", true],
        ["Autoscale", true],
        ["ResourceHealth", true],
    ]
}