{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "elastic-cluster.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "elastic-cluster.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "elastic-cluster.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "elastic-cluster.labels" -}}
helm.sh/chart: {{ include "elastic-cluster.chart" . }}
{{ include "elastic-cluster.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "elastic-cluster.selectorLabels" -}}
app.kubernetes.io/name: {{ include "elastic-cluster.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use in elasticsearch
*/}}
{{- define "elastic-cluster.elasticsearch.serviceAccountName" -}}
{{- if .Values.elasticsearch.serviceAccount.create -}}
    {{ default (include "elastic-cluster.fullname" .) .Values.elasticsearch.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.elasticsearch.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use in kibana
*/}}
{{- define "elastic-cluster.kibana.serviceAccountName" -}}
{{- if .Values.kibana.serviceAccount.create -}}
    {{ default (printf "%s-kibana" (include "elastic-cluster.fullname" .)) .Values.kibana.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.kibana.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use in fleet
*/}}
{{- define "elastic-cluster.fleet.serviceAccountName" -}}
{{- if .Values.fleet.serviceAccount.create -}}
    {{ default (printf "%s-fleet" (include "elastic-cluster.fullname" .)) .Values.fleet.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.fleet.serviceAccount.name }}
{{- end -}}
{{- end -}}

