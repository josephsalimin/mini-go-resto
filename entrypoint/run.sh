#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

echo "Migrating DB"
RUBYOPT='-W0' bundle exec rake db:migrate db:test:prepare

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"