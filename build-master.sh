set -e
echo "Merge features"
cd neko-rooms
git pull m1k1o master
git merge room_snapshots

echo "Build neko rooms"
cd ..
docker-compose build neko-rooms