#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

RAILS_ENV="${RAILS_ENV:-test}"

echo "Migrating DB"
RUBYOPT='-W0' RAILS_ENV=${RAILS_ENV} bundle exec rake db:migrate db:test:prepare

echo "Running rspec"
RUBYOPT='-W0' bundle exec rspec --format documentation