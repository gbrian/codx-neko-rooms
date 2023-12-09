## Install APPS
. ~/.bashrc
for app in ${INSTALL_APPS//,/ }
do
  echo "**** INSTALLING  $app *****"
  $CODX_APPS/codx.sh $app
done