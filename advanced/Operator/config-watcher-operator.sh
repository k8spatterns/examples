
#!/bin/bash

# Namespace to watch (or 'default' if not given)
namespace=${WATCH_NAMESPACE:-default}

# API URL setup. Requires an ambassador API proxy running side-by-side on localhost
base=http://localhost:8001
ns=namespaces/$namespace

# Main event loop
start_event_loop() {
  # Watch the K8s API on events on service objects
  echo "::: Starting to wait for events"

  # Event loop listening for changes in config maps
  curl -N -s $base/api/v1/${ns}/configmaps?watch=true | while read -r event
  do
    # Sanitize new lines
    event=$(echo "$event" | tr '\r\n' ' ')

    # Event type & name
    local type=$(echo "$event" | jq -r .type)
    local config_map=$(echo "$event" | jq -r .object.metadata.name)
    echo "::: $type -- $config_map"

    # Act only when configmap is modified
    if [ $type = "MODIFIED" ]; then
      restart_pods_depending_on_cm $config_map
    fi
  done
}

# Restart all pods that depend on config map provided by name
restart_pods_depending_on_cm() {
  local config_map=${1}

  for watcher in $(get_config_watcher_for_cm $config_map); do
    local label_selector=$(extract_label_selector_from_watcher $watcher)
    delete_pods_with_selector "$label_selector"
  done
}

# Get the ConfigWatcher CRDs that a are configured for a ConfigMap
get_config_watcher_for_cm() {
  local config_map=${1}

  # Fetch all resources "ConfigWatcher" which are stored in the given namespace
  local watcher_list=$(curl -s $base/apis/k8spatterns.io/v1/${ns}/configwatchers | \
                       jq -r '.items[]')
  # Now extract all ConfigWatcher's name whose spec says 'configMap=$config_map'
  echo $watcher_list | jq -r "select(.spec.configMap == \"$config_map\") | .metadata.name"
}

# Extract the label selector from the ConfigWatcher CRD
extract_label_selector_from_watcher() {
  local watcher=${1}

  # Get the pod selector for the given ConfigWatcher
  local pod_selector=$(curl -s $base/apis/k8spatterns.io/v1/${ns}/configwatchers/${watcher} | \
                       jq .spec.podSelector)

  # Convert from JSON to 'label=value,label2=value2' as used as query parameter
  # for the K8s API call
  echo $pod_selector | jq -r 'to_entries | map(.key + "=" + .value | @uri) | join(",")'
}

# Delete all pods that match a selector
delete_pods_with_selector() {
  local selector=${1}

  echo "::::: Deleting pods with $selector"

  # Pick up all pod names which match the given selector
  local pods=$(curl -s $base/api/v1/${ns}/pods?labelSelector=$selector | \
               jq -r .items[].metadata.name)

  # Delete all pods that matcehed
  for pod in $pods; do
    # Delete but also check exit code
    exit_code=$(curl -s -X DELETE -o /dev/null -w "%{http_code}" $base/api/v1/${ns}/pods/$pod)
    if [ $exit_code -eq 200 ]; then
      echo "::::: Deleted pod $pod"
    else
      echo "::::: Error deleting pod $pod: $exit_code"
    fi
  done
}

# ==============================================
# Fire up
start_event_loop
