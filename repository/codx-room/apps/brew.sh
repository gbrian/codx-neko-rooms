curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > /home/neko/brew.sh
echo | bash /home/neko/brew.sh
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/neko/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
rm /home/neko/brew.sh