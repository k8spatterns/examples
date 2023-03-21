#!/bin/bash

# When using a Service with NodePort, you can use this script to find out the port and address
# and then perodically access this service:

# Pick up service's NodePort
port=$(kubectl get svc random-generator -o jsonpath={.spec.ports[0].nodePort})
# Take from the first's node the hostname which should be reachable from here
host=$(kubectl get nodes -o json | jq -r '.items[0] | .status.addresses[] | select(.type == "Hostname") | .address')
while true; do
  # Curl it assuming your are on a node on the cluster. Only print version and id.
  curl -s http://$host:$port/info | jq '.version,.id'
  echo ===========================
  sleep 1
done
