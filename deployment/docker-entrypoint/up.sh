#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

RAILS_ENV="${RAILS_ENV:-development}"

echo "Migrating DB ${RAILS_ENV}"
RUBYOPT='-W0' RAILS_ENV=${RAILS_ENV} bundle exec rake db:create
RUBYOPT='-W0' RAILS_ENV=${RAILS_ENV} bundle exec rake db:migrate

echo "Running rails server"
RUBYOPT='-W0' bundle exec rails s -b 0.0.0.0
