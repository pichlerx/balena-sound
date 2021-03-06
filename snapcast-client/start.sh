#!/usr/bin/env bash

# Start snapclient if multi room is enabled
if [[ -z $DISABLE_MULTI_ROOM ]]; then
  # Wait for fleet-supervisor to start up
  # We need this because fleet-supervisor depends on resin_supervisor, which has no support for depends_on
  while ! curl -s "http://localhost:3000"; do sleep 1; done

  # Start snapclient
  SNAPCAST_SERVER=$(curl --silent http://localhost:3000)
  echo -e "Starting snapclient...\nTarget snapcast server: $SNAPCAST_SERVER"
  snapclient -h $SNAPCAST_SERVER
else
  echo "Multi-room audio is disabled, not starting snapclient."
  exit 0
fi
