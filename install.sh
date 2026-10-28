#!/usr/bin/env bash
# ==============================================================================
# brutal-crafter - Script de Instalação Universal (Linux / macOS)
# ==============================================================================
# Instala e configura a skill brutal-crafter para múltiplos assistentes de IA:
# - Google Antigravity (~/.antigravity/skills e ~/.gemini/antigravity-cli/skills)
# - Gemini CLI & Code Assist (~/.gemini/skills)
# - Claude Code (~/.claude/skills e local CLAUDE.md)
# - OpenCode (~/.config/opencode/skills e local .opencode/skills)
# - OpenAI Codex / OpenDevin (~/.codex/skills)
# - Cursor AI / Windsurf (.cursorrules, rules/brutal-crafter.mdc, .windsurfrules)
# - GitHub Copilot (.github/copilot-instructions.md)
# - Roo Code / Cline (.clinerules)
# - Aider (CONVENTIONS.md)
# - Continue.dev (.continue/prompts)
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_NAME="brutal-crafter"

# Cores
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_CYAN='\033[0;36m'
C_BOLD='\033[1m'

info()    { echo -e "${C_CYAN}ℹ [INFO]${C_RESET} $*"; }
success() { echo -e "${C_GREEN}✔ [SUCESSO]${C_RESET} $*"; }
warn()    { echo -e "${C_YELLOW}⚠ [AVISO]${C_RESET} $*"; }
error()   { echo -e "${C_RED}✖ [ERRO]${C_RESET} $*" >&2; }

show_help() {
  echo -e "${C_BOLD}Uso:${C_RESET} ./install.sh [OPÇÕES]"
  echo ""
  echo -e "${C_BOLD}Opções de Alvo (Agentes):${C_RESET}"
  echo -e "  -a, --all              Instala em todos os agentes suportados / detectados"
  echo -e "  -g, --gemini, --antigravity"
  echo -e "                         Instala no Google Antigravity e Gemini CLI (~/.antigravity, ~/.gemini)"
  echo -e "  -c, --claude           Instala no Claude Code (~/.claude/skills)"
  echo -e "  -o, --opencode         Instala no OpenCode (~/.config/opencode/skills e ~/.opencode/skills)"
  echo -e "  --codex                Instala no OpenAI Codex / OpenDevin (~/.codex/skills)"
  echo -e "  -p, --project, --local Instala no projeto ativo (.cursorrules, CLAUDE.md, .github, .opencode, agent-rules-books)"
  echo -e "  --cursor               Configura regras para Cursor AI (.cursorrules ou .cursor/rules)"
  echo -e "  --windsurf             Configura regras para Windsurf (.windsurfrules local)"
  echo -e "  --copilot              Configura regras para GitHub Copilot (.github/copilot-instructions.md)"
  echo -e "  --cline, --roo         Configura regras para Cline / Roo Code (.clinerules local)"
  echo -e "  --aider                Configura diretrizes para Aider (CONVENTIONS.md local)"
  echo -e "  --continue             Configura prompt para Continue.dev (.continue/prompts local)"
  echo -e "  -t, --target <PATH>    Instala em diretório customizado"
  echo ""
  echo -e "${C_BOLD}Modos de Instalação:${C_RESET}"
  echo -e "  -s, --symlink          Cria links simbólicos (ideal para desenvolvimento contínuo da skill)"
  echo -e "  --copy                 Cópia física limpa dos 2 itens essenciais (padrão)"
  echo -e "  -u, --uninstall        Desinstala a skill dos agentes selecionados (ou de todos com --all)"
  echo -e "  -h, --help             Exibe esta ajuda"
  echo ""
  echo -e "${C_BOLD}Exemplos:${C_RESET}"
  echo -e "  ./install.sh                     # Auto-detecta ambientes instalados e faz o deploy limpo"
  echo -e "  ./install.sh --symlink           # Instala criando symlinks (atualizações refletem na hora)"
  echo -e "  ./install.sh --project           # Instala no projeto ativo com agent-rules-books"
  echo -e "  ./install.sh --opencode          # Instala especificamente no OpenCode"
  echo -e "  ./install.sh --gemini --claude   # Instala no Antigravity/Gemini e Claude Code"
  echo -e "  ./install.sh --all               # Configura todos os agentes suportados"
  echo -e "  ./install.sh --uninstall --all   # Remove a skill de todos os ambientes"
}

# Valida integridade da pasta fonte
validate_source() {
  if [[ ! -f "$SCRIPT_DIR/SKILL.md" ]]; then
    error "SKILL.md não encontrado em $SCRIPT_DIR!"
    exit 1
  fi
  if [[ ! -d "$SCRIPT_DIR/agent-rules-books" ]]; then
    warn "agent-rules-books/ não encontrado em $SCRIPT_DIR. A skill rodará sem a base de livros."
  fi
}

# Instala pasta de skill (estratégia de cópia limpa dos 2 itens essenciais ou symlink)
install_skill_folder() {
  local target_dir="$1"
  local use_symlink="$2"

  mkdir -p "$(dirname "$target_dir")"

  if [[ -L "$target_dir" ]] || [[ -e "$target_dir" ]]; then
    rm -rf "$target_dir"
  fi

  if [[ "$use_symlink" == "true" ]]; then
    ln -sfn "$SCRIPT_DIR" "$target_dir"
    success "Symlink criado: $target_dir -> $SCRIPT_DIR"
  else
    mkdir -p "$target_dir"
    # Cópia limpa dos 2 itens essenciais: SKILL.md e agent-rules-books/
    cp "$SCRIPT_DIR/SKILL.md" "$target_dir/"
    if [[ -d "$SCRIPT_DIR/agent-rules-books" ]]; then
      mkdir -p "$target_dir/agent-rules-books"
      cp -R "$SCRIPT_DIR/agent-rules-books/." "$target_dir/agent-rules-books/"
    fi
    [[ -f "$SCRIPT_DIR/README.md" ]] && cp "$SCRIPT_DIR/README.md" "$target_dir/"
    [[ -f "$SCRIPT_DIR/LICENSE" ]] && cp "$SCRIPT_DIR/LICENSE" "$target_dir/"
    # Aliases de compatibilidade para agentes que buscam CLAUDE.md ou .cursorrules
    ln -sfn "SKILL.md" "$target_dir/CLAUDE.md" 2>/dev/null || cp "$target_dir/SKILL.md" "$target_dir/CLAUDE.md"
    ln -sfn "SKILL.md" "$target_dir/.cursorrules" 2>/dev/null || cp "$target_dir/SKILL.md" "$target_dir/.cursorrules"
    success "Cópia limpa realizada com sucesso para: $target_dir"
  fi
}

# Instalação no projeto ativo (no diretório atual)
install_project_local() {
  local use_symlink="$1"
  local target_pwd="$(pwd)"

  info "Instalando no projeto ativo ($target_pwd)..."
  if [[ "$use_symlink" == "true" ]]; then
    ln -sfn "$SCRIPT_DIR/SKILL.md" "$target_pwd/.cursorrules"
    ln -sfn "$SCRIPT_DIR/SKILL.md" "$target_pwd/CLAUDE.md"
    mkdir -p "$target_pwd/.github"
    ln -sfn "$SCRIPT_DIR/SKILL.md" "$target_pwd/.github/copilot-instructions.md"
    mkdir -p "$target_pwd/.opencode/skills"
    ln -sfn "$SCRIPT_DIR" "$target_pwd/.opencode/skills/$SKILL_NAME"
    ln -sfn "$SCRIPT_DIR/agent-rules-books" "$target_pwd/agent-rules-books"
    success "Symlinks criados no projeto ativo (.cursorrules, CLAUDE.md, .github/copilot-instructions.md, .opencode, agent-rules-books)."
  else
    cp "$SCRIPT_DIR/SKILL.md" "$target_pwd/.cursorrules"
    cp "$SCRIPT_DIR/SKILL.md" "$target_pwd/CLAUDE.md"
    mkdir -p "$target_pwd/.github"
    cp "$SCRIPT_DIR/SKILL.md" "$target_pwd/.github/copilot-instructions.md"
    mkdir -p "$target_pwd/.opencode/skills/$SKILL_NAME"
    cp "$SCRIPT_DIR/SKILL.md" "$target_pwd/.opencode/skills/$SKILL_NAME/"
    if [[ -d "$SCRIPT_DIR/agent-rules-books" ]]; then
      mkdir -p "$target_pwd/agent-rules-books"
      cp -R "$SCRIPT_DIR/agent-rules-books/." "$target_pwd/agent-rules-books/"
      mkdir -p "$target_pwd/.opencode/skills/$SKILL_NAME/agent-rules-books"
      cp -R "$SCRIPT_DIR/agent-rules-books/." "$target_pwd/.opencode/skills/$SKILL_NAME/agent-rules-books/"
    fi
    success "Cópia limpa realizada no projeto ativo (.cursorrules, CLAUDE.md, .github/copilot-instructions.md, .opencode, agent-rules-books)."
  fi
}

uninstall_skill_folder() {
  local target_dir="$1"
  if [[ -L "$target_dir" ]] || [[ -e "$target_dir" ]]; then
    rm -rf "$target_dir"
    success "Removido: $target_dir"
  else
    info "Não instalado ou já removido: $target_dir"
  fi
}

# Gerar regra para Cursor
install_cursor_rule() {
  local use_symlink="$1"
  local target_pwd="$(pwd)"

  if [[ "$use_symlink" == "true" ]]; then
    ln -sfn "$SCRIPT_DIR/SKILL.md" "$target_pwd/.cursorrules"
    [[ -d "$SCRIPT_DIR/agent-rules-books" ]] && ln -sfn "$SCRIPT_DIR/agent-rules-books" "$target_pwd/agent-rules-books"
    success "Regra Cursor configurada via symlink (.cursorrules -> SKILL.md)"
  else
    cp "$SCRIPT_DIR/SKILL.md" "$target_pwd/.cursorrules"
    if [[ -d "$SCRIPT_DIR/agent-rules-books" ]]; then
      mkdir -p "$target_pwd/agent-rules-books"
      cp -R "$SCRIPT_DIR/agent-rules-books/." "$target_pwd/agent-rules-books/"
    fi
    success "Regra Cursor e agent-rules-books copiados (.cursorrules)"
  fi

  # Criação complementar em .cursor/rules se a pasta .cursor existir ou global
  local cursor_global_dir="$HOME/.cursor/rules"
  local cursor_local_dir="$target_pwd/.cursor/rules"
  local target_file=""

  if [[ -d "$cursor_global_dir" ]] || [[ ! -d "$target_pwd/.cursor" ]]; then
    mkdir -p "$cursor_global_dir"
    target_file="$cursor_global_dir/brutal-crafter.mdc"
  else
    mkdir -p "$cursor_local_dir"
    target_file="$cursor_local_dir/brutal-crafter.mdc"
  fi

  cat > "$target_file" << 'EOF'
---
description: brutal-crafter - Engenharia pragmática de ponta a ponta, sem over-engineering e com rigor técnico
globs: *
alwaysApply: true
---

# Brutal Crafter - Regras Ativas de Engenharia

Esta regra ativa as diretrizes e comandos do brutal-crafter:
- Comandos: `/bc-x` (Auditoria), `/bc-plan` (Planejamento), `/bc-task` (Tarefas), `/bc-craft` (Plano + Tarefas), `/bc-dev` (Hands-on)
- Flags: `-s` (Quick/ADHD), `-d` (Deep Dive), `-e` (Execute hands-on), `-j` (Jira MCP sync)
- Princípios: Good Taste, Never Break Userspace, Módulos Profundos, Zero Over-engineering.

Consulte as instruções completas em SKILL.md e agent-rules-books/.
EOF
  success "Regra Cursor gerada: $target_file"
}

# Gerar regra para Windsurf (.windsurfrules)
install_windsurf_rule() {
  local target_file="$(pwd)/.windsurfrules"
  if [[ -f "$target_file" ]] && grep -q "brutal-crafter" "$target_file"; then
    info "Regra Windsurf já presente em $target_file"
  else
    cat >> "$target_file" << 'EOF'

# --- brutal-crafter ---
# Engenharia pragmática: /bc-x, /bc-plan, /bc-task, /bc-craft, /bc-dev (-s/-d/-e/-j)
# Foco em ADHD (ação na 1ª linha, <= 5 itens), zero over-engineering e rigor técnico.
EOF
    success "Regra Windsurf adicionada a: $target_file"
  fi
}

# Gerar instruções para GitHub Copilot (.github/copilot-instructions.md)
install_copilot_rule() {
  local use_symlink="$1"
  local target_pwd="$(pwd)"
  local target_dir="$target_pwd/.github"
  mkdir -p "$target_dir"

  if [[ "$use_symlink" == "true" ]]; then
    ln -sfn "$SCRIPT_DIR/SKILL.md" "$target_dir/copilot-instructions.md"
    [[ -d "$SCRIPT_DIR/agent-rules-books" ]] && ln -sfn "$SCRIPT_DIR/agent-rules-books" "$target_pwd/agent-rules-books"
    success "Instruções do Copilot configuradas via symlink (.github/copilot-instructions.md)"
  else
    cp "$SCRIPT_DIR/SKILL.md" "$target_dir/copilot-instructions.md"
    if [[ -d "$SCRIPT_DIR/agent-rules-books" ]]; then
      mkdir -p "$target_pwd/agent-rules-books"
      cp -R "$SCRIPT_DIR/agent-rules-books/." "$target_pwd/agent-rules-books/"
    fi
    success "Instruções Copilot e agent-rules-books copiados (.github/copilot-instructions.md)"
  fi
}

# Gerar instruções para Cline / Roo Code (.clinerules)
install_cline_rule() {
  local target_file="$(pwd)/.clinerules"
  if [[ -f "$target_file" ]] && grep -q "brutal-crafter" "$target_file"; then
    info "Regra Cline/Roo já presente em $target_file"
  else
    cat >> "$target_file" << 'EOF'

# --- brutal-crafter ---
# Engenharia pragmática: /bc-x, /bc-plan, /bc-task, /bc-craft, /bc-dev (-s/-d/-e/-j)
# Ação na 1ª linha, tarefas atômicas com checklist persistido em .docs/brutal-crafter/.
EOF
    success "Regra Cline/Roo adicionada a: $target_file"
  fi
}

# Gerar instruções para Aider (CONVENTIONS.md)
install_aider_rule() {
  local target_file="$(pwd)/CONVENTIONS.md"
  if [[ -f "$target_file" ]] && grep -q "brutal-crafter" "$target_file"; then
    info "Diretrizes Aider já presentes em $target_file"
  else
    cat >> "$target_file" << 'EOF'

# brutal-crafter - Diretrizes de Engenharia (Aider)
- Foco em ação imediata (ADHD mode: passos numerados, <= 5 itens por lista, zero preâmbulos).
- Comandos suportados: /bc-x (auditoria), /bc-plan (planejamento), /bc-task (tarefas), /bc-craft (plano + tarefas), /bc-dev (execução).
- Princípios: Good Taste (eliminar casos especiais na modelagem), Never Break Userspace, módulos profundos.
EOF
    success "Diretrizes Aider adicionadas a: $target_file"
  fi
}

# Gerar prompt customizado para Continue.dev (.continue/prompts/brutal-crafter.prompt)
install_continue_rule() {
  local target_dir="$(pwd)/.continue/prompts"
  mkdir -p "$target_dir"
  local target_file="$target_dir/brutal-crafter.prompt"
  cat > "$target_file" << 'EOF'
---
name: brutal-crafter
description: Engenharia de software pragmática de ponta a ponta sem over-engineering
---
<system>
Você é o Brutal Crafter: Arquiteto de Software e Engenheiro Principal Sênior.
Elimine o teatro corporativo, aplique os 4 pilares (Problema, Solução, Riscos, Melhorias).
Respostas orientadas à ação imediata (modo ADHD).
Comandos suportados: /bc-x, /bc-plan, /bc-task, /bc-craft, /bc-dev (flags -s, -d, -e, -j).
</system>

{{{ input }}}
EOF
  success "Prompt Continue.dev gerado: $target_file"
}

# Variáveis de controle
OPT_ALL=false
OPT_GEMINI=false
OPT_CLAUDE=false
OPT_OPENCODE=false
OPT_CODEX=false
OPT_PROJECT=false
OPT_CURSOR=false
OPT_WINDSURF=false
OPT_COPILOT=false
OPT_CLINE=false
OPT_AIDER=false
OPT_CONTINUE=false
OPT_SYMLINK=false
OPT_UNINSTALL=false
OPT_TARGET=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -a|--all)
      OPT_ALL=true
      shift
      ;;
    -g|--gemini|--antigravity)
      OPT_GEMINI=true
      shift
      ;;
    -c|--claude)
      OPT_CLAUDE=true
      shift
      ;;
    -o|--opencode)
      OPT_OPENCODE=true
      shift
      ;;
    --codex)
      OPT_CODEX=true
      shift
      ;;
    -p|--project|--local)
      OPT_PROJECT=true
      shift
      ;;
    --cursor)
      OPT_CURSOR=true
      shift
      ;;
    --windsurf)
      OPT_WINDSURF=true
      shift
      ;;
    --copilot)
      OPT_COPILOT=true
      shift
      ;;
    --cline|--roo)
      OPT_CLINE=true
      shift
      ;;
    --aider)
      OPT_AIDER=true
      shift
      ;;
    --continue)
      OPT_CONTINUE=true
      shift
      ;;
    -s|--symlink)
      OPT_SYMLINK=true
      shift
      ;;
    --copy)
      OPT_SYMLINK=false
      shift
      ;;
    -t|--target)
      OPT_TARGET="$2"
      shift 2
      ;;
    -u|--uninstall)
      OPT_UNINSTALL=true
      shift
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      error "Opção desconhecida: $1"
      show_help
      exit 1
      ;;
  esac
done

# Se nenhum agente alvo foi especificado, auto-detecta ambientes existentes
if [[ "$OPT_ALL" == "false" && "$OPT_GEMINI" == "false" && "$OPT_CLAUDE" == "false" && "$OPT_OPENCODE" == "false" && "$OPT_CODEX" == "false" && "$OPT_PROJECT" == "false" && "$OPT_CURSOR" == "false" && "$OPT_WINDSURF" == "false" && "$OPT_COPILOT" == "false" && "$OPT_CLINE" == "false" && "$OPT_AIDER" == "false" && "$OPT_CONTINUE" == "false" && -z "$OPT_TARGET" ]]; then
  ([[ -d "$HOME/.antigravity" ]] || [[ -d "$HOME/.gemini" ]]) && OPT_GEMINI=true
  [[ -d "$HOME/.claude" ]] && OPT_CLAUDE=true
  ([[ -d "$HOME/.config/opencode" ]] || [[ -d "$HOME/.opencode" ]]) && OPT_OPENCODE=true
  [[ -d "$HOME/.codex" ]] && OPT_CODEX=true

  # Fallback caso nada seja detectado: adota padrão universal
  if [[ "$OPT_GEMINI" == "false" && "$OPT_CLAUDE" == "false" && "$OPT_OPENCODE" == "false" ]]; then
    OPT_GEMINI=true
    OPT_CLAUDE=true
    OPT_OPENCODE=true
  fi
fi

if [[ "$OPT_ALL" == "true" ]]; then
  OPT_GEMINI=true
  OPT_CLAUDE=true
  OPT_OPENCODE=true
  OPT_CODEX=true
  OPT_PROJECT=true
  OPT_CURSOR=true
  OPT_WINDSURF=true
  OPT_COPILOT=true
  OPT_CLINE=true
  OPT_AIDER=true
  OPT_CONTINUE=true
fi

echo -e "${C_BOLD}🧠 brutal-crafter - Instalador Universal (Linux / macOS)${C_RESET}"
echo -e "=========================================================="
validate_source

# Se for desinstalação
if [[ "$OPT_UNINSTALL" == "true" ]]; then
  warn "Iniciando desinstalação do brutal-crafter..."
  if [[ "$OPT_GEMINI" == "true" ]]; then
    uninstall_skill_folder "$HOME/.antigravity/skills/$SKILL_NAME"
    uninstall_skill_folder "$HOME/.gemini/skills/$SKILL_NAME"
    uninstall_skill_folder "$HOME/.gemini/antigravity-cli/skills/$SKILL_NAME"
  fi
  if [[ "$OPT_CLAUDE" == "true" ]]; then
    uninstall_skill_folder "$HOME/.claude/skills/$SKILL_NAME"
  fi
  if [[ "$OPT_OPENCODE" == "true" ]]; then
    uninstall_skill_folder "$HOME/.config/opencode/skills/$SKILL_NAME"
    uninstall_skill_folder "$HOME/.opencode/skills/$SKILL_NAME"
  fi
  if [[ "$OPT_CODEX" == "true" ]]; then
    uninstall_skill_folder "$HOME/.codex/skills/$SKILL_NAME"
  fi
  if [[ -n "$OPT_TARGET" ]]; then
    uninstall_skill_folder "$OPT_TARGET"
  fi
  success "Desinstalação concluída."
  exit 0
fi

# Execução das instalações
info "Modo de deploy: $(if [[ "$OPT_SYMLINK" == "true" ]]; then echo "Symlink (Desenvolvimento)"; else echo "Cópia Limpa (2 itens essenciais)"; fi)"

# 1. Antigravity & Gemini CLI
if [[ "$OPT_GEMINI" == "true" ]]; then
  info "Instalando para Google Antigravity & Gemini CLI..."
  install_skill_folder "$HOME/.antigravity/skills/$SKILL_NAME" "$OPT_SYMLINK"
  install_skill_folder "$HOME/.gemini/skills/$SKILL_NAME" "$OPT_SYMLINK"
  install_skill_folder "$HOME/.gemini/antigravity-cli/skills/$SKILL_NAME" "$OPT_SYMLINK"
fi

# 2. Claude Code
if [[ "$OPT_CLAUDE" == "true" ]]; then
  info "Instalando para Claude Code..."
  install_skill_folder "$HOME/.claude/skills/$SKILL_NAME" "$OPT_SYMLINK"
fi

# 3. OpenCode
if [[ "$OPT_OPENCODE" == "true" ]]; then
  info "Instalando para OpenCode..."
  install_skill_folder "$HOME/.config/opencode/skills/$SKILL_NAME" "$OPT_SYMLINK"
  if [[ -d "$HOME/.opencode" ]]; then
    install_skill_folder "$HOME/.opencode/skills/$SKILL_NAME" "$OPT_SYMLINK"
  fi
fi

# 4. OpenAI Codex / OpenDevin
if [[ "$OPT_CODEX" == "true" ]]; then
  info "Instalando para OpenAI Codex / OpenDevin..."
  install_skill_folder "$HOME/.codex/skills/$SKILL_NAME" "$OPT_SYMLINK"
fi

# 5. Projeto Ativo (Local)
if [[ "$OPT_PROJECT" == "true" ]]; then
  install_project_local "$OPT_SYMLINK"
fi

# 6. Cursor
if [[ "$OPT_CURSOR" == "true" ]]; then
  info "Configurando regras para Cursor AI..."
  install_cursor_rule "$OPT_SYMLINK"
fi

# 7. Windsurf
if [[ "$OPT_WINDSURF" == "true" ]]; then
  info "Configurando regras para Windsurf..."
  install_windsurf_rule
fi

# 8. GitHub Copilot
if [[ "$OPT_COPILOT" == "true" ]]; then
  info "Configurando instruções para GitHub Copilot..."
  install_copilot_rule "$OPT_SYMLINK"
fi

# 9. Cline / Roo Code
if [[ "$OPT_CLINE" == "true" ]]; then
  info "Configurando regras para Cline / Roo Code..."
  install_cline_rule
fi

# 10. Aider
if [[ "$OPT_AIDER" == "true" ]]; then
  info "Configurando diretrizes para Aider..."
  install_aider_rule
fi

# 11. Continue.dev
if [[ "$OPT_CONTINUE" == "true" ]]; then
  info "Configurando prompt para Continue.dev..."
  install_continue_rule
fi

# 12. Custom Target
if [[ -n "$OPT_TARGET" ]]; then
  info "Instalando no diretório customizado: $OPT_TARGET..."
  install_skill_folder "$OPT_TARGET" "$OPT_SYMLINK"
fi

echo -e "=========================================================="
success "Pronto! brutal-crafter instalado com sucesso."
info "Comandos disponíveis no seu agente: /bc-x, /bc-plan, /bc-task, /bc-craft, /bc-dev"
