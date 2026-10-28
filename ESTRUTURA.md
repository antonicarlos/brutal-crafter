# 📦 Estrutura e Requisitos da Pasta `brutal-crafter` (v2.3.0)

Este documento define os componentes mandatórios e a arquitetura de arquivos da skill **`brutal-crafter`**, projetada para cobrir o ciclo completo de engenharia de software de ponta a ponta (**Auditoria ➔ Arquitetura ➔ Sincronização Jira ➔ Desenvolvimento Hands-on & Testes**) de forma **100% autônoma, autocontida e portátil** em qualquer assistente de IA (**Google Antigravity**, **Claude Code**, **OpenCode**, **Cursor**, **Windsurf**, **Gemini CLI**, **Codex**, **Copilot**, **Cline/Roo**, **Aider** ou **Continue**).

---

## 🗂️ Árvore de Arquivos Mandatória

```text
brutal-crafter/
├── SKILL.md                 # [MANDATÓRIO] Cérebro da skill (instruções, persona, comandos /bc-*, flags -s/-d/-e/-j, resiliência)
├── agent-rules-books/       # [MANDATÓRIO] Base de conhecimento técnico (14 livros de engenharia com versões .nano.md)
│   ├── a-philosophy-of-software-design/
│   ├── clean-architecture/
│   ├── clean-code/
│   ├── code-complete/
│   ├── designing-data-intensive-applications/
│   ├── domain-driven-design/
│   ├── domain-driven-design-distilled/
│   ├── implementing-domain-driven-design/
│   ├── patterns-of-enterprise-application-architecture/
│   ├── refactoring/
│   ├── refactoring-guru/
│   ├── release-it/
│   ├── the-pragmatic-programmer/
│   └── working-effectively-with-legacy-code/
├── install.sh               # [AUTOMAÇÃO] Script de instalação para Linux/macOS (Antigravity, Claude, OpenCode, Codex, Cursor, Windsurf, Copilot, Cline, Aider, Continue)
├── install.ps1              # [AUTOMAÇÃO] Script de instalação para Windows PowerShell (Junction/Symlink e multi-agente)
├── README.md                # [APOIO HUMANO] Guia de comandos v2.2.0, instalação multi-agente e exemplos
└── ESTRUTURA.md             # [ESTE ARQUIVO] Especificação técnica dos requisitos da pasta
```

Além disso, ao executar as tarefas, a skill gerencia automaticamente o diretório de persistência de contexto:
```text
.docs/brutal-crafter/
└── tasks_DD-MM-YYYY.md      # [GERADO POR /bc-craft ou /bc-task] Arquivo com formato checklist (- [ ] / - [x]) e fidelidade total
```

---

## 🔍 Detalhamento dos Componentes

1. **`SKILL.md` (Mandatório — O Cérebro):**
   - Comandos oficiais: `/bc-x`, `/bc-plan`, `/bc-task`, `/bc-craft`, `/bc-dev` *(com compatibilidade retroativa para `/bt-*`)*.
   - Flags: `-s` (Quick), `-d` (Deep), `-e` (Execute hands-on), `-j` (Jira sync), `--status` (painel de progresso).
   - Gestão ativa de ritmo (seletor em 2 linhas, expansão rápida `-d`).
   - Os 4 pilares: Problema, Solução, Riscos e Melhorias.
   - Checklist dinâmico com fechamento automático no markdown (`- [ ]` ➔ `- [x]`).
2. **`agent-rules-books/` (Mandatório — Base de Conhecimento):**
   - 14 livros clássicos de engenharia.
   - Política de leitura sob demanda (carrega apenas `.nano.md` < 50 linhas por assunto, prevenindo sobrecarga de tokens).
3. **Resiliência de Integrações:**
   - Fallback nativo para `/bc-x` caso `npx repomix` não esteja disponível.
   - Parametrização e tratamento atômico de falha para o Jira MCP.
   - Segurança de banco e migrações (idempotência e reversão obrigatória).

---

## 🚀 Como Transportar e Instalar a Skill

### Via Scripts Automatizados:
```bash
# Linux / macOS (Symlink para dev):
./install.sh --symlink

# Windows PowerShell:
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Symlink
```

### Manualmente:
```bash
# Para Google Antigravity:
mkdir -p ~/.gemini/antigravity-cli/skills/brutal-crafter
cp -r /home/antonisouza/Turing/skill/brutal-crafter/* ~/.gemini/antigravity-cli/skills/brutal-crafter/

# Para Claude Code:
mkdir -p ~/.claude/skills/brutal-crafter
cp -r /home/antonisouza/Turing/skill/brutal-crafter/* ~/.claude/skills/brutal-crafter/

# Para Gemini CLI:
mkdir -p ~/.gemini/skills/brutal-crafter
cp -r /home/antonisouza/Turing/skill/brutal-crafter/* ~/.gemini/skills/brutal-crafter/
```
