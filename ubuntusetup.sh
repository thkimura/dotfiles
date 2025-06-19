#!/bin/bash

echo "🚀 Iniciando setup do ambiente WSL Ubuntu..."

# Atualização do sistema
sudo apt update && sudo apt upgrade -y

# Instalação de ferramentas essenciais
sudo apt install -y curl wget git build-essential software-properties-common zsh tmux unzip python3 python3-pip ripgrep fd-find fontconfig

# Definindo Zsh como shell padrão
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh)
fi

# Forçando Zsh no WSL se chsh não funcionar
if ! grep -q "exec zsh" ~/.bashrc; then
  echo "exec zsh" >>~/.bashrc
fi

# Instalando Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "💡 Instalando Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Instalando Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  echo "🎨 Instalando tema Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Plugins do Zsh
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting || true

# Copiando arquivos de configuração
cp .zshrc ~/
cp .p10k.zsh ~/
cp .tmux.conf ~/
mkdir -p ~/.local/bin
cp ide ~/.local/bin/
chmod +x ~/.local/bin/ide

# Instalando NVM e Node.js
echo "🧩 Instalando NVM e Node.js..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
  echo 'export NVM_DIR="$HOME/.nvm"' >>~/.zshrc
  echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >>~/.zshrc
fi

# Carregando NVM e instalando Node.js
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
nvm install --lts
nvm use --lts
npm install -g yarn eslint nodemon typescript

# Atualizando pip
python3 -m pip install --upgrade pip

# Instalando Neovim (última versão via AppImage)
echo "🧠 Instalando Neovim mais recente..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage ~/.local/bin/nvim
ln -sf ~/.local/bin/nvim ~/.local/bin/vi
ln -sf ~/.local/bin/nvim ~/.local/bin/vim

# Adiciona Neovim no PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.zshrc

# LazyVim
echo "🛠️ Instalando LazyVim..."
rm -rf ~/.config/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo "✅ Setup completo! Reinicie o terminal e digite 'ide' para abrir seu ambiente."

melhore esse codigo e adicione mais itens fundamentaies para criar um ambiente de desenvolvimento usando o ubuntu wsl

### Answer:
# File: /home/k1mur4/dev/setup.sh
$()$(
  shellscript
  #!/bin/bash

  echo "🚀 Iniciando setup do ambiente WSL Ubuntu..."

  # Atualização do sistema
  echo "📦 Atualizando sistema..."
  sudo apt update && sudo apt upgrade -y

  # Instalação de ferramentas essenciais
  echo "🔧 Instalando ferramentas essenciais..."
  sudo apt install -y curl wget git build-essential software-properties-common zsh tmux unzip \
    python3 python3-pip python3-venv ripgrep fd-find fontconfig jq htop neofetch \
    net-tools dnsutils tree bat fzf silversearcher-ag

  # Criando links simbólicos para bat (pode estar como batcat no Ubuntu)
  if command -v batcat &>/dev/null; then
    mkdir -p ~/.local/bin
    ln -sf $(which batcat) ~/.local/bin/bat
  fi

  # Definindo Zsh como shell padrão
  if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Configurando Zsh como shell padrão..."
    chsh -s $(which zsh)
  fi

  # Forçando Zsh no WSL se chsh não funcionar
  if ! grep -q "exec zsh" ~/.bashrc; then
    echo "exec zsh" >>~/.bashrc
  fi

  # Instalando Oh My Zsh
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "💡 Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi

  # Instalando Powerlevel10k
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "🎨 Instalando tema Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
      ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  fi

  # Plugins do Zsh
  echo "🔌 Instalando plugins do Zsh..."
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions 2>/dev/null || true
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting 2>/dev/null || true
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/fast-syntax-highlighting 2>/dev/null || true
  git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM}/plugins/you-should-use 2>/dev/null || true

  # Copiando arquivos de configuração
  echo "📄 Copiando arquivos de configuração..."
  cp .zshrc ~/
  cp .p10k.zsh ~/
  cp .tmux.conf ~/
  mkdir -p ~/.local/bin
  cp ide ~/.local/bin/
  chmod +x ~/.local/bin/ide

  # Instalando Docker
  echo "🐳 Instalando Docker..."
  if ! command -v docker &>/dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
  fi

  # Instalando Docker Compose
  echo "🐙 Instalando Docker Compose..."
  DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
  sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  # Instalando NVM e Node.js
  echo "🧩 Instalando NVM e Node.js..."
  export NVM_DIR="$HOME/.nvm"
  if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
    echo 'export NVM_DIR="$HOME/.nvm"' >>~/.zshrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >>~/.zshrc
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >>~/.zshrc
  fi

  # Carregando NVM e instalando Node.js
  export NVM_DIR="$HOME/.nvm"
  source "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm use --lts
  npm install -g yarn eslint nodemon typescript ts-node prettier npm-check-updates

  # Instalando Python ferramentas
  echo "🐍 Configurando ambiente Python..."
  python3 -m pip install --upgrade pip
  python3 -m pip install virtualenv pipenv poetry black flake8 mypy pytest

  # Instalando Rust
  echo "🦀 Instalando Rust..."
  if ! command -v rustc &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    echo 'source "$HOME/.cargo/env"' >>~/.zshrc
    source "$HOME/.cargo/env"
  fi

  # Instalando Go
  echo "🐹 Instalando Go..."
  if ! command -v go &>/dev/null; then
    GO_VERSION="1.21.5"
    wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >>~/.zshrc
    rm go${GO_VERSION}.linux-amd64.tar.gz
  fi

  # Instalando Neovim (última versão via AppImage)
  echo "🧠 Instalando Neovim mais recente..."
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  mkdir -p ~/.local/bin
  mv nvim.appimage ~/.local/bin/nvim
  ln -sf ~/.local/bin/nvim ~/.local/bin/vi
  ln -sf ~/.local/bin/nvim ~/.local/bin/vim

  # Adiciona Neovim no PATH
  echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.zshrc

  # LazyVim
  echo "🛠️ Instalando LazyVim..."
  rm -rf ~/.config/nvim
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git

  # Instalando GitHub CLI
  echo "🐙 Instalando GitHub CLI..."
  if ! command -v gh &>/dev/null; then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
    sudo apt update
    sudo apt install gh -y
  fi

  # Configurando Git
  echo "🔄 Configurando Git..."
  git config --global core.editor "nvim"
  git config --global init.defaultBranch main

  # Instalando Lazygit
  echo "🌿 Instalando Lazygit..."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit lazygit.tar.gz

  echo "✅ Setup completo! Reinicie o terminal e digite 'ide' para abrir seu ambiente."
)$()
