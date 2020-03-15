echo "Migrating DB"
RUBYOPT='-W0' bundle exec rake db:migrate db:test:prepare

echo "Running rspec"
RUBYOPT='-W0' bundle exec rspec --format documentation