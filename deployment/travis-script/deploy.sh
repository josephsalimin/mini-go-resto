export RAILS_ENV=development
export ENTRYPOINT=up

docker-compose build
docker images

echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USERNAME" --password-stdin
docker push $DOCKER_HUB_USERNAME/$DOCKER_REPO_HUB:$CI_COMMIT
ssh $DEPLOYMENT_HOST "docker pull $DOCKER_HUB_USERNAME/$DOCKER_REPO_HUB:$CI_COMMIT"
ssh $DEPLOYMENT_HOST "docker run -v /tmp/db:/app/db/persistent -d -p 5051:3000 $DOCKER_HUB_USERNAME/$DOCKER_REPO_HUB:$CI_COMMIT"