# 📦 Estrutura e Requisitos da Pasta `brutal-crafter` (v2.3.0)

Este documento define os componentes mandatórios e a arquitetura de arquivos da skill **`brutal-crafter`**, projetada para cobrir o ciclo completo de engenharia de software de ponta a ponta (**Auditoria ➔ Arquitetura ➔ Sincronização Jira ➔ Desenvolvimento Hands-on & Testes**) de forma **100% autônoma, autocontida e portátil** em qualquer assistente de IA (**Google Antigravity**, **Claude Code**, **OpenCode**, **Cursor**, **Windsurf**, **Gemini CLI**, **Codex**, **Copilot**, **Cline/Roo**, **Aider** ou **Continue**).

---

## 🗂️ Árvore de Arquivos Mandatória

```text
brutal-crafter/
├── SKILL.md                 # [MANDATÓRIO] Cérebro da skill e comando principal /brutal-crafter
├── skills/                  # [COMANDOS COMO SKILLS] Registra /bc-* no autocomplete do Antigravity
│   ├── bc-craft/SKILL.md    # /bc-craft (Planejamento 4 pilares + tarefas + Jira em 1 passo)
│   ├── bc-x/SKILL.md        # /bc-x (Auditoria de codebase e varredura de riscos)
│   ├── bc-plan/SKILL.md     # /bc-plan (Requisitos e arquitetura em 4 pilares)
│   ├── bc-task/SKILL.md     # /bc-task (Detalhamento atômico de tarefas - [ ])
│   └── bc-dev/SKILL.md      # /bc-dev (Diretrizes e execução hands-on -e com testes e checklist)
├── commands/                # [AUTOMAÇÃO CLI] Comandos .toml para Antigravity CLI e Gemini CLI
│   ├── bc-craft.toml
│   ├── bc-x.toml
│   ├── bc-plan.toml
│   ├── bc-task.toml
│   ├── bc-dev.toml
│   └── brutal-crafter.toml
├── .opencode/               # [OPENCODE CLI] Comandos slash nativos para OpenCode
│   └── command/
│       ├── bc-craft.md
│       ├── bc-x.md
│       ├── bc-plan.md
│       ├── bc-task.md
│       ├── bc-dev.md
│       └── brutal-crafter.md
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
├── scripts/                 # [SCRIPTS DE AUTOMAÇÃO] Instaladores multiagente
│   ├── install.sh           # Script de instalação para Linux / macOS / WSL
│   └── install.ps1          # Script de instalação para Windows (PowerShell)
├── README.md                # [APOIO HUMANO] Guia de comandos v2.3.0, instalação multi-agente e exemplos
└── ESTRUTURA.md             # [ESTE ARQUIVO] Especificação técnica dos requisitos da pasta
```

Além disso, ao executar as tarefas, a skill gerencia automaticamente o diretório de persistência de contexto:
```text
.docs/brutal-crafter/
└── tasks_DD-MM-YYYY.md      # [GERADO POR /bc-craft ou /bc-task] Arquivo com formato checklist (- [ ] / - [x]) e fidelidade total
```

---

## 🔍 Detalhamento dos Componentes

1. **Comandos Individuais Registrados (`skills/bc-*/`):**
   - No Google Antigravity e assistentes modernos, cada comando slash exibido no autocomplete (`/bc-craft`, `/bc-x`, `/bc-plan`, `/bc-task`, `/bc-dev`) é registrado como uma skill dedicada na pasta de skills do assistente, garantindo autocompletion instantâneo ao digitar `/`.
2. **`SKILL.md` (Mandatório — O Cérebro Principal):**
   - Comandos oficiais: `/bc-x`, `/bc-plan`, `/bc-task`, `/bc-craft`, `/bc-dev` *(com compatibilidade retroativa para `/bt-*`)*.
   - Flags: `-s` (Quick), `-d` (Deep), `-e` (Execute hands-on), `-j` (Jira sync), `--status` (painel de progresso).
   - Gestão ativa de ritmo (seletor em 2 linhas, expansão rápida `-d`).
   - Os 4 pilares: Problema, Solução, Riscos e Melhorias.
   - Checklist dinâmico com fechamento automático no markdown (`- [ ]` ➔ `- [x]`).
3. **`agent-rules-books/` (Mandatório — Base de Conhecimento):**
   - 14 livros clássicos de engenharia.
   - Política de leitura sob demanda (carrega apenas `.nano.md` < 50 linhas por assunto, prevenindo sobrecarga de tokens).
4. **Resiliência de Integrações:**
   - Fallback nativo para `/bc-x` caso `npx repomix` não esteja disponível.
   - Parametrização e tratamento atômico de falha para o Jira MCP.
   - Segurança de banco e migrações (idempotência e reversão obrigatória).
