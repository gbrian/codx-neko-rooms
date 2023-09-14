#!/bin/bash
echo "Starting sync-data"

cd $HOME

function init () {
  COUNTER=0
  while true;do
    [ "$COUNTER" == "5" ] && exit 1
    wget -O initYointly.json -T 15 -c https://api-codx-dev.meetnav.com/api/neko-rooms/init-yointly/$HOSTNAME && break
    sleep 5
    let "COUNTER=COUNTER+1"
  done

  export FIREFOX_PARAMS=$(cat ./initYointly.json | jq -r '.firefoxParams')
  export URLS=$(cat ./initYointly.json | jq -r '.urls')

  echo $URLS
  echo $FIREFOX_PARAMS
}

function hashtag () {
  HASH=""
  for file in /home/neko/.mozilla/firefox/profile.default/*.sqlite; do
    last_change=$(date --utc --reference=$file +%s)
    HASH="${HASH}${last_change}"
  done
  echo $HASH
}

function upload-data () {
  echo "Uploading changes"
  tar -cvf profile.tar /home/neko/.mozilla/firefox/profile.default/*.sqlite 2>&1 > /dev/null
  echo "Uploading data"
  curl https://reqbin.com/echo/post/json
    -d @path/to/data.json 
    -H "Content-Type: application/javascript"
}

if [ "$1" == "" ];then
  init
  exit
fi

LAST_HASH=$(hashtag)
echo "LAST_HASH $LAST_HASH"
while true; do
  CURRENT_HASH=$(hashtag)
  if [ "$LAST_HASH" != "$CURRENT_HASH" ]; then
    LAST_HASH=$CURRENT_HASH
    upload-data
  fi
  sleep 10
done
