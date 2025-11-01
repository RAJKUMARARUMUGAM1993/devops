# #!/bin/bash
# set -e

# # Usage: ./deploy.sh <branch_name>
# BRANCH=${1:-dev}  # default to dev if no argument

# DEV_IMAGE="rajkumaram/dev:$BRANCH"
# PROD_IMAGE="rajkumaram/main:$BRANCH"

# # Stop previous container
# echo "Stopping old container if exists..."
# docker-compose down || true

# # Update docker-compose.yml dynamically
# if [ "$BRANCH" == "dev" ]; then
#     sed -i "s|image: .*|image: $DEV_IMAGE|" docker-compose.yml
# elif [ "$BRANCH" == "main" ]; then
#     sed -i "s|image: .*|image: $PROD_IMAGE|" docker-compose.yml
# fi

# # Start container
# echo "Starting container..."
# docker-compose up -d

# echo "Deployment completed for branch $BRANCH!"

#!/bin/bash
set -e  # Exit if any command fails
CONTAINER_NAME="devops-react-app"
IMAGE_NAME="devops-react-app:latest"

echo "🚀 Starting deployment..."

# Stop and remove old container safely
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
  echo "🛑 Removing existing container..."
  docker stop $CONTAINER_NAME || true
  sleep 3
  docker rm -f $CONTAINER_NAME || true
fi

# Remove any old dangling images (optional cleanup)
echo "🧹 Cleaning up old images..."
docker image prune -f || true

# Run the new container
echo "🚢 Starting new container..."
docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME

# Show running containers
echo "✅ Current running containers:"
docker ps

echo "✅ Deployment completed successfully!"

