######
#
# Description:
#   Init script to build and run the app in a container in your local environment
# Usage: 
#   ./init.sh
#
######
CONTEXT='/home/ec2-user/environment/ben-tech-challenge/app'
DOCKERFILE='../app/Dockerfile'
APPNAME='ben-tech-challenge'
VERSION=$(git describe)
SHA=$(git rev-parse --short HEAD)
VERSION_TAG="$VERSION.$SHA"
IMAGE="$APPNAME-$VERSION_TAG"
PORT=80

# Clean up container if it is already running
docker stop $APPNAME 2>/dev/null 
docker rm $APPNAME 2>/dev/null 

docker build --file $DOCKERFILE $CONTEXT --tag $IMAGE --build-arg APPNAME=$APPNAME --build-arg SHA=$SHA --build-arg VERSION=$VERSION --build-arg PORT=$PORT
docker run --detach --publish $PORT:$PORT --name $APPNAME --tty $IMAGE 