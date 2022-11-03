GH_VERION=${GH_VERION:-2.6.0}
URL="https://github.com/cli/cli/releases/download/v${GH_VERION}/gh_${GH_VERION}_linux_amd64.deb"
echo "GH URL: $URL"
curl -sL $URL > gh_linux_amd64.deb
dpkg -i gh_linux_amd64.deb
rm gh_linux_amd64.deb
