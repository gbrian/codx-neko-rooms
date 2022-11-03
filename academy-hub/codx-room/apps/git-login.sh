# setup git login
# git token setup
echo "Setting up git token"
git config --global url."https://api:$GITHUB_TOKEN@github.com/".insteadOf "https://github.com/"
git config --global url."https://ssh:$GITHUB_TOKEN@github.com/".insteadOf "ssh://git@github.com/"
git config --global url."https://git:$GITHUB_TOKEN@github.com/".insteadOf "git@github.com:"

git config --global user.email "$GITHUB_EMAIL"
git config --global user.name "$GITHUB_USERNAME"

