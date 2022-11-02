# Syncs S3 bucket with local system
function usage () {
  echo "aws Installs aws client
  Scipts requieres:
    * AWS_ACCESS_KEY_ID env variable with the client ID
    * AWS_SECRET_ACCESS_KEY env variable with the client secret
    * AWS_REGION env variable with the client region
  "
}
if [ -z "$AWS_CLIENT_SECRET" ]; then
  echo "error: AWS_CLIENT_SECRET not found"
  usage
  exit 1
fi

# aws
sudo apt install -y unzip
curl -L "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
rm awscliv2.zip
./aws/install && aws --version