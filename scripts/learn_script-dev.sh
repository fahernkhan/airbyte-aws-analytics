docker-compose build --no-cache

docker-compose up -d

docker ps

docker-compose down
docker-compose up -d --build

docker-compose down
docker-compose pull  # pastikan image ter-update
docker-compose up -d --build
####
docker-compose down -v
docker-compose up --build

###
tree -L 3 -I "node_modules|dist|.git|coverage"

docker compose stop -v
### network
sudo ufw disable
sudo ufw status
sudo ufw enable
