{{/*
===============================================================================
Expand the application name.

Returns the chart name defined in Chart.yaml.

Example:
Chart.yaml

name: ui

Result:
ui
===============================================================================
*/}}
{{- define "ui.name" -}}
{{- .Chart.Name -}}
{{- end }}



{{/*
===============================================================================
Return the fully qualified resource name.

Instead of using the chart name directly, Helm prefixes resources with the
release name.

Example:

helm install retail-ui .

Result:
retail-ui

This allows multiple installations of the same chart within the same cluster.

Examples:

helm install dev-ui .
helm install qa-ui .
helm install prod-ui .

Resources become:

dev-ui
qa-ui
prod-ui
===============================================================================
*/}}
{{- define "ui.fullname" -}}
{{- .Release.Name -}}
{{- end }}



{{/*
===============================================================================
Common Labels

These labels are applied to every Kubernetes resource.

Benefits:

- Easier filtering
- Better observability
- Helm release tracking
- Recommended Kubernetes labeling convention

Example:

kubectl get pods \
-l app.kubernetes.io/instance=ui
===============================================================================
*/}}
{{- define "ui.labels" -}}

app.kubernetes.io/name: {{ include "ui.name" . }}

app.kubernetes.io/instance: {{ .Release.Name }}

app.kubernetes.io/version: {{ .Chart.AppVersion }}

app.kubernetes.io/managed-by: {{ .Release.Service }}

helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}

{{- end }}



{{/*
===============================================================================
Selector Labels

These labels are used by:

- Deployment selectors
- Service selectors

IMPORTANT:

These labels MUST remain stable.

If selector labels change after deployment,
Kubernetes creates an entirely new ReplicaSet.

Therefore selector labels should contain only immutable identifiers.
===============================================================================
*/}}
{{- define "ui.selectorLabels" -}}

app.kubernetes.io/name: {{ include "ui.name" . }}

app.kubernetes.io/instance: {{ .Release.Name }}

{{- end }}



{{/*
===============================================================================
Service Account Name

This helper determines which ServiceAccount should be used.

If a ServiceAccount template is added later,
this helper can be reused without changing any Deployment.

Current behaviour:

Uses the Kubernetes "default" ServiceAccount.

Future behaviour could be:

serviceAccount:
  create: true
  name: ""

without changing Deployment.yaml.
===============================================================================
*/}}
{{- define "ui.serviceAccountName" -}}
default
{{- end }}