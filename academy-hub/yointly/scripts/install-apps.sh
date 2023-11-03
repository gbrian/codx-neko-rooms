source ~/.bashrc
## Install APPS
for app in ${INSTALL_APPS//,/ }
do
  echo "**** INSTALLING  $app *****"
  /codx-cli/codx.sh $app
done