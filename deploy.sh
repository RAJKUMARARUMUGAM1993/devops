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
echo "Deploying container..."

# Stop and remove old container if exists
docker rm -f devops-react-app || true

# Run the new container with correct image
docker run -d --name devops-react-app -p 80:80 devops-react-app:latest

echo "✅ Deployment complete."
