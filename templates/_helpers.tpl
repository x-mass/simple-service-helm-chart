{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "mychart.fullname" -}}
{{- $name := default .Chart.Name .Values.appName -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default service name
*/}}
{{- define "mychart.fullname.service" -}}
{{ include "mychart.fullname" . }}-svc
{{- end -}}

{{/*
Create a default deployment name
*/}}
{{- define "mychart.fullname.deployment" -}}
{{ include "mychart.fullname" . }}
{{- end -}}

{{/*
Create a default HPA name
*/}}
{{- define "mychart.fullname.hpa" -}}
{{ include "mychart.fullname" . }}-hpa
{{- end -}}

{{/*
Create a default PDB name
*/}}
{{- define "mychart.fullname.pdb" -}}
{{ include "mychart.fullname" . }}-pdb
{{- end -}}

{{/*
Common labels
*/}}
{{- define "common.labels" -}}
app.kubernetes.io/name: {{ .Release.Name | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/version: {{ default "latest" .Values.deployment.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
{{- with .Values.additionalLabels }}
{{- toYaml . | nindent 4 }}
{{- end }}
{{- end }}
