variable subscription_id {

}

variable resource_group_name {
    default = "bluebaronrg"
}

variable location {
    default = "westeurope"
}

variable eventhub_namespace_name {
    default = "blueBaronEventHubNamespace"
}

variable eventhub_name {
    default = "insights-activity-logs"
}

variable diagnostic_name {
    default = "bluebaron-activity-logs"
}

variable activity_logs {
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