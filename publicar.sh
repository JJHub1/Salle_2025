#!/usr/bin/env bash
#
# publicar.sh — envia o dashboard para o GitHub (JJHub1/Salle_2025)
#
# Como usar:
#   1) Abra o Terminal
#   2) cd /Users/janism1/Desktop/PRJ/Salle_2025
#   3) bash publicar.sh
#
# Quando o git pedir a SENHA, cole um Personal Access Token
# (github.com/settings/tokens -> escopo "repo"). NAO use sua senha normal.
#
set -e

REPO_DIR="/Users/janism1/Desktop/PRJ/Salle_2025"
REMOTE_URL="https://github.com/JJHub1/Salle_2025.git"

cd "$REPO_DIR"

echo "==> Pasta: $REPO_DIR"

# Garante que e um repositorio git
if [ ! -d .git ]; then
  echo "==> Inicializando repositorio git..."
  git init -b main
fi

# Garante o remote 'origin' correto
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
fi
echo "==> Remote origin: $(git remote get-url origin)"

# Garante que estamos no branch main
git branch -M main

# Adiciona e faz commit se houver mudancas
git add -A
if git diff --cached --quiet; then
  echo "==> Nada novo para commitar (commit ja existe)."
else
  echo "==> Criando commit..."
  git commit -m "Atualizar dashboard Historico de Propostas SALLE"
fi

# Envia para o GitHub
echo "==> Enviando para o GitHub (sera pedido usuario + token)..."
git push -u origin main

echo ""
echo "==> Pronto! Arquivo publicado em: https://github.com/JJHub1/Salle_2025"
echo "==> Para deixar como site, ative o GitHub Pages em Settings > Pages (branch: main)."
