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
## port forwarding
ssh -i your.pem -L 5433:<rds server>:5432 ubuntu@publicipec2
psql -h database_endpoint -U postgres -d nama_db
