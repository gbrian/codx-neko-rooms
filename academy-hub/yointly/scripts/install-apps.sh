## Install APPS
for app in ${INSTALL_APPS//,/ }
do
  echo "**** INSTALLING  $app *****"
  bash -c "/yointly/codx-cli/codx.sh $app"
done