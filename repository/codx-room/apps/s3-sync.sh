# Syncs S3 bucket with local system
function usage () {
  echo "s3-sync Syncs S3 bucket with local folder
  Scipts requieres:
    * aws.sh
    * S3_SYNC env variable with the format 'bucket:local' (s3MyBucket:folder/bucket)
  "
}
if [ -z "$S3_SYNC" ]; then
  echo "S3_SYNC setting is missing"
  usage
  exit 1
fi

echo "Install dependencies"
bash $CODX_APPS/aws.sh

BUCKET=$(echo $S3_SYNC | cut -d ":" -f 1)
FOLDER=$(echo $S3_SYNC | cut -d ":" -f 2)

mkdir -p /home/coder/$FOLDER