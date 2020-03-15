export RAILS_ENV=development
export ENTRYPOINT=test

docker-compose build
docker images
docker-compose up