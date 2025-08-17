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
