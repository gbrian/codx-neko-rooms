source ./env.sh

echo "Create registry directory"
mkdir registry

echo "Run registry"
docker-compose down
docker-compose up -d

sleep 5

echo "Populate images"
bash ./populate.sh