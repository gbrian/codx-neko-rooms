set -e
echo "Merge features"
cd neko-rooms
git checkout codx-master
git pull m1k1o master
git merge room_snapshots
git merge room-stats

echo "Build neko rooms"
cd ..
docker-compose build neko-rooms