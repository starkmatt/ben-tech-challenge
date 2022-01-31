######
#
# Description:
#   Build script to push docker image to docker hub repo and deploy the AWS resources via terraforman 
# Usage: 
#   ./build.sh
#
######

export SHA=$(git describe --tags --long)
docker build -t nichichi/btc-repo:$SHA ../app/Dockerfile
docker push nichichi/btc-repo:$SHA
        