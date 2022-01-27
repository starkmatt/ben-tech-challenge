export SHA=$(git describe --tags --long)
docker build -t nichichi/btc-repo:$SHA ../app/Dockerfile
docker push nichichi/btc-repo:$SHA
        