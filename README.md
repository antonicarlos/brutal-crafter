# 🧠 brutal-crafter v2.3.0

<p align="center">
  <img src="https://img.shields.io/badge/Modo-Anti--Enrola%C3%A7%C3%A3o-red.svg?style=for-the-badge" alt="Anti-Enrolação">
  <img src="https://img.shields.io/badge/Foco-ADHD%20Ready-brightgreen.svg?style=for-the-badge" alt="ADHD Ready">
  <img src="https://img.shields.io/badge/Jira-MCP%20Sync-blue.svg?style=for-the-badge" alt="Jira Sync">
  <img src="https://img.shields.io/badge/Execu%C3%A7%C3%A3o-Hands--on%20(-e)-purple.svg?style=for-the-badge" alt="Hands-on">
  <img src="https://img.shields.io/badge/Over--Engineering-Zero%20Toler%C3%A2ncia-orange.svg?style=for-the-badge" alt="Zero Over-Engineering">
</p>

<p align="center">
  <strong>"Menos teatro corporativo, zero preâmbulos vazios e mais engenharia artesanal rodando sem derrubar a infraestrutura às 3h da manhã."</strong>
</p>

---

## 🎯 Por Que Esta Skill Existe?

Sabe quando você pede pra IA uma sugestão de arquitetura simples e ela te devolve:
> *"Considere usar Event Sourcing distribuído com CQRS, Kafka com 12 partições e um cluster Kubernetes de 8 nós para sincronizar a lista de compras da sua avó"?*

Ou quando você pede instruções de código e ela cospe 8 páginas de prosa fofa com *"Espero que esteja bem! Vamos refletir sobre este desafio emocionante..."*, e esquece de fechar a conexão do banco de dados?

**O `brutal-crafter` veio para acabar com isso.**

Ele une:
1. **O estilo anti-procrastinação do ADHD:** Ação imediata na primeira linha, passos numerados, listas com no máximo 5 itens e zero preâmbulos vazios.
2. **A sinceridade ácida do desenvolvedor sênior cascudo (`brutal-code-review`):** Foco no "Good Taste" (eliminar casos especiais na modelagem) e na regra de ferro "Never Break Userspace".
3. **A precisão cirúrgica de arquitetura (`skill-architect`):** Bounded Contexts pragmáticos, tracer bullets e critérios de aceite EARS (`WHEN`/`WHILE`/`IF...THEN`).
4. **As regras de ferro dos livros clássicos (`agent-rules-books/`):** Prevenção de vazamentos de recursos (*Release It!*), modelos de concorrência e idempotência (*DDIA*), modularidade profunda (*APOSD*) e quebra de dependências (*Working Effectively with Legacy Code*).
5. **Persistência física, execução hands-on e integração Jira:** Salvamento automático de tasks em `.docs/brutal-crafter/` com checklist `- [ ]` / `- [x]`, execução via flag `-e` e sincronização resiliente no Jira via MCP.

---

## 📖 Glossário de Letras e Flags

- **Prefixo `bc-` (Battle-Crafted / Brutal Crafter):** Comandos e auditorias testadas no fogo da produção com base nos livros clássicos *(aliases transparentes `/bt-` mantidos)*.
- **Flag `-s` (Short / Simple / Sintético):** Modo rápido anti-procrastinação. Bullet points objetivos, leitura em menos de 1 minuto e foco imediato na ação.
- **Flag `-d` (Deep / Detailed):** Modo mergulho profundo (*Deep Dive*). Contratos formais, diagramas conceituais, modelagem de dados e matriz exaustiva de riscos.
- **Flag `-e` (Execute / Hands-on):** Execução prática de código, migrations idempotentes com rollback e testes automatizados, marcando tarefas concluídas com `- [x]`.
- **Flag `-j` (Jira Integration):** Dispara a criação e sincronização resiliente das tarefas no Jira via MCP utilizando o arquivo gerado em disco.
- **Flag `--status`:** Exibe painel compacto do status das tarefas em `.docs/brutal-crafter/`.
- **Sintaxe `EARS` (Easy Approach to Requirements Syntax):** Critérios de aceite padronizados sem ambiguidade (`WHEN [evento]`, `WHILE [estado]`, `IF [erro] THEN [recuperação]`).

---

## ⚡ Gestão e Sugestão Ativa de Modos (`-s` vs `-d`)

A skill facilita a escolha de velocidade sem travar você:

1. **Quando o comando vier sozinho (ex: apenas `/bc-plan` ou `/bc-task`):**  
   O agente interrompe e exibe o seletor objetivo de 2 linhas:
   > 🎯 **Qual ritmo você precisa agora?**  
   > - `1` ou `-s` (⚡ Quick): Direto ao ponto, 4 pilares em 30s.  
   > - `2` ou `-d` (🔬 Deep): Minúcias técnicas, contratos e diagramas.  
   >  
   > *Responda com o número/flag e o que deseja fazer.*

2. **Quando o comando vier com a demanda mas sem flag (ex: `/bc-plan criar webhook`):**  
   - Assume **`-s` (Quick)** por padrão para não gerar atrito.
   - Adiciona no topo da resposta a dica de expansão rápida:  
     `[MODO: ⚡ QUICK | 💡 Quer ver em detalhes? Responda apenas "-d"]`

3. **Comutação instantânea:**  
   Se após uma resposta rápida você responder apenas `-d`, o agente expande aquela mesma análise imediatamente para o modo Deep, sem exigir que você reescreva nada.

---

## 🛠️ Comandos Oficiais da Skill

```text
Fluxo Direto (Recomendado - 1 Passo):
/bc-craft [-s | -d] [-j] (Planejamento 4 Pilares + Tarefas em Disco + Jira) ──► /bc-dev -e (Código Seguro & Testes)

Fluxo Modular / Tradicional:
/bc-x (Auditoria Codebase) ──► /bc-plan (Requisitos) ──► /bc-task (Tarefas em Disco/Jira) ──► /bc-dev (Código Seguro)
```

| Comando | O Que Faz | Exemplo de Uso |
| :--- | :--- | :--- |
| **`/bc-craft [-s \| -d] [-j]`** | **Planejamento & Tarefas Unificado (NOVO):** Gera os 4 pilares de arquitetura e já salva as tarefas atômicas em `.docs/brutal-crafter/tasks_*.md` com suporte opcional a sync Jira MCP (`-j`). | `/bc-craft -s Webhook Pix`<br>`/bc-craft -d -j Gateway pagamentos`<br>*(Aliases: `/bc-pt`, `/bc-plantask`)* |
| **`/bc-x [-s \| -d] [caminho]`** | **Auditoria de Codebase & Riscos:** Ingestão com `npx repomix` ou fallback nativo automático (`find`/`grep`), varredura de leaks, concorrência e timeouts. | `/bc-x -s`<br>`/bc-x -d src/Billing` |
| **`/bc-plan [-s \| -d]`** | **Requisitos & Solução:** Desarma premissas falsas, elimina over-engineering e estampa data obrigatória. | `/bc-plan -s Criar checkout Pix`<br>`/bc-plan -d Gateway de pagamentos` |
| **`/bc-task [-s \| -d] [-j] [--status]`** | **Detalhamento Atômico & Arquivo:** Salva em `.docs/brutal-crafter/tasks_*.md` com formato checklist `- [ ]`, suporte a `--status` e sync Jira MCP. | `/bc-task -s Plano de checkout`<br>`/bc-task -d -j Plano de checkout`<br>`/bc-task --status` |
| **`/bc-dev [-s \| -d \| -e]`** | **Diretrizes Técnicas ou Execução Hands-on:** Lê o arquivo `.docs/brutal-crafter/` mais recente. No modo `-e`, codifica, testa e marca `- [x]`. | `/bc-dev -s TASK-01`<br>`/bc-dev -e TASK-01` |

---

## ⚡ `/bc-craft` — Planejamento e Tarefas em 1 Só Passo

Se você já sabe o que precisa construir e não quer rodar `/bc-plan` para depois rodar `/bc-task`:
1. Execute `/bc-craft -s <sua demanda>` (ou com `-j` para sincronizar no Jira).
2. O agente gera os 4 pilares arquiteturais, decompõe até 5 tarefas com critérios EARS e **já salva fisicamente o arquivo em `.docs/brutal-crafter/tasks_DD-MM-YYYY.md`**.
3. Você vai direto para a implementação: `/bc-dev -e TASK-01`.

---

## 📁 Obrigação de Arquivo e Sincronização Jira (`/bc-craft` e `/bc-task`)

Ao rodar `/bc-craft` ou `/bc-task`:
1. Cria automaticamente o diretório `.docs/brutal-crafter/` (se não existir).
2. Salva o arquivo datado: `.docs/brutal-crafter/tasks_DD-MM-YYYY.md` com cabeçalho `# Planejamento de Tarefas - DD/MM/YYYY`.
3. **Fidelidade Total em Checklist:** Cada tarefa é registrada no formato:
   - `### - [ ] [TASK-XX] Título Claro`
   - 🎯 Problema que Resolve
   - 🧩 Detalhamento Técnico Profundo (Frameworks, tipos, versões)
   - 🛠️ Arquivos & Alvos (Caminhos e tabelas exatas)
   - ✅ Critério de Aceite e Testes (EARS: `WHEN`, `WHILE`, `IF...THEN`)
   - 🔗 Dependências
4. **Flag `-j` (Resiliente):** Sincroniza cada card individualmente no Jira. Se algum card falhar, emite aviso na resposta e mantém o markdown local preservado.

---

## 👉 Próximo Passo Obrigatório (Call to Action)

Toda resposta da skill termina com o próximo passo recomendado:
- **Após `/bc-x`:** `👉 Próximo passo recomendado: /bc-craft -s [feature prioritária] ou /bc-plan -s [feature]`
- **Após `/bc-plan`:** `👉 Próximo passo recomendado: /bc-task -s [ID ou tema do plano] (Isso gerará o arquivo detalhado em .docs/brutal-crafter/tasks_DATA.md)`
- **Após `/bc-task` (sem `-j`):** `👉 Próximo passo recomendado: /bc-task -j (para sincronizar com o Jira) ou /bc-dev -e TASK-01 (para implementar com validação)`
- **Após `/bc-task` (com `-j`):** `👉 Próximo passo recomendado: /bc-dev -e TASK-01 (guiado pelo arquivo validado no Jira)`
- **Após `/bc-craft` (sem `-j`):** `👉 Próximo passo recomendado: /bc-task -j (para sincronizar com o Jira) ou /bc-dev -e TASK-01 (para implementar com validação)`
- **Após `/bc-craft` (com `-j`):** `👉 Próximo passo recomendado: /bc-dev -e TASK-01 (guiado pelo arquivo validado no Jira)`
- **Após `/bc-dev`:** `👉 Próximo passo recomendado: /bc-dev -e [próxima TASK] ou /bc-task --status para revisar o progresso total.`

---

## 🏛️ Os 4 Pilares Inegociáveis (`/bc-plan` e `/bc-x`)

```markdown
### 🎯 1. Problema Real
[Qual é a dor de verdade e a causa-raiz, destruindo o sintoma superficial]

### 💡 2. Solução Recomendada
[A rota mais limpa, elegante e minimalista. Padrões consolidados antes de inventar moda]

### ⚠️ 3. Riscos e Armadilhas
[Onde o código vai quebrar: memory leaks, pool exhaustion, deadlocks, race conditions, timeouts]

### 🚀 4. Melhorias e Evolução
[O que fazer agora e como evitar acumular débitos técnicos]
```

---

## 📚 Política de Leitura Sob Demanda (`agent-rules-books/`)

A base de livros clássicos opera em 3 camadas de leitura eficiente:
1. **Padrão:** Carrega somente `.nano.md` (< 50 linhas).
2. **Especializada:**
   - *Timeouts e Resiliência:* `release-it.nano.md`
   - *Concorrência e Idempotência:* `designing-data-intensive-applications.nano.md` e `patterns-of-enterprise-application-architecture.nano.md`
   - *Módulos Profundos e Complexidade:* `a-philosophy-of-software-design.nano.md`
   - *Código Legado:* `working-effectively-with-legacy-code.nano.md`
3. **Zero Desperdício de Tokens:** Proibido carregar todos os 14 livros simultaneamente.

---

## 🚀 Como Instalar e Plugar no Seu Agente

A skill disponibiliza instaladores automatizados para **Linux/macOS** (`install.sh`) e **Windows** (`install.ps1`), com suporte a instalação por cópia ou por **links simbólicos / junctions** (ideal para desenvolvimento ativo, onde qualquer edição no repositório reflete imediatamente no agente).

### ⚡ Instalação Rápida (1 Comando)

O instalador conta com **auto-detecção inteligente**: ele verifica automaticamente se você possui **Google Antigravity/Gemini**, **Claude Code**, **OpenCode** ou **Codex** instalados na sua máquina e faz o deploy diretamente nos ambientes detectados.

#### 🐧 Linux / macOS:
```bash
cd /caminho/para/brutal-crafter

# Instalação padrão inteligente (auto-detecta Antigravity, Claude, OpenCode e Codex):
./install.sh

# Modo Desenvolvimento (cria symlinks em vez de copiar arquivos):
./install.sh --symlink

# Instalar especificamente no OpenCode:
./install.sh --opencode --symlink

# Instalar em TODOS os agentes (Antigravity, Claude, OpenCode, Codex, Cursor, Windsurf, Copilot, Cline, Aider, Continue):
./install.sh --all
```

#### 🪟 Windows (PowerShell):
```powershell
cd C:\caminho\para\brutal-crafter

# Instalação padrão inteligente (auto-detecta Antigravity, Claude, OpenCode e Codex):
powershell -ExecutionPolicy Bypass -File .\install.ps1

# Modo Desenvolvimento (cria junctions/symlinks diretos):
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Symlink

# Instalar especificamente no OpenCode:
powershell -ExecutionPolicy Bypass -File .\install.ps1 -OpenCode -Symlink

# Instalar em TODOS os agentes suportados:
powershell -ExecutionPolicy Bypass -File .\install.ps1 -All
```

---

### 🤖 Configuração e Comportamento por Agente

| Agente / Ferramenta | Onde a Skill Fica Instalada | Como Acionar |
| :--- | :--- | :--- |
| **Google Antigravity & Gemini CLI** | `~/.gemini/skills/brutal-crafter/`<br>`~/.gemini/antigravity-cli/skills/brutal-crafter/`<br>*(Win: `%USERPROFILE%\.gemini\...`)* | Comandos nativos `/bc-x`, `/bc-plan`, `/bc-task`, `/bc-dev` com suporte automático ao seletor de modo e flags (`-s`, `-d`, `-e`, `-j`). |
| **Claude Code** | `~/.claude/skills/brutal-crafter/`<br>*(Win: `%USERPROFILE%\.claude\skills\...`)* | O agente carrega o cérebro `SKILL.md` / `CLAUDE.md` e compreende os comandos `/bc-*` e fluxo de 4 pilares. |
| **OpenCode** | `~/.config/opencode/skills/brutal-crafter/`<br>`~/.opencode/skills/brutal-crafter/`<br>*(Win: `%USERPROFILE%\.config\opencode\...`)* | O OpenCode descobre nativamente a pasta da skill e carrega os 14 livros clássicos sob demanda em qualquer projeto. |
| **OpenAI Codex / OpenDevin** | `~/.codex/skills/brutal-crafter/`<br>*(Win: `%USERPROFILE%\.codex\skills\...`)* | O agente carrega as instruções completas de engenharia e regras de concorrência/resiliência. |
| **Cursor IDE** | Global: `~/.cursor/rules/brutal-crafter.mdc`<br>Local: `.cursor/rules/brutal-crafter.mdc` | O Cursor Agent / Composer aplica as regras automaticamente em todas as conversas e prompts. |
| **Windsurf (Codeium)** | Local: `.windsurfrules`<br>Global: `~/.codeium/windsurf/memories/` | O Cascade consome as diretrizes de concorrência, ADHD mode e aversão a over-engineering. |
| **GitHub Copilot** | Local: `.github/copilot-instructions.md` | O Copilot Chat utiliza os princípios de engenharia profunda e respostas diretas à ação. |
| **Roo Code / Cline** | Local: `.clinerules` | Os agentes de terminal seguem a persona artesanal sênior e checklists atômicos em `.docs/brutal-crafter/`. |
| **Aider** | Local: `CONVENTIONS.md` | O Aider incorpora as convenções de modularidade profunda, Good Taste e prevenção de quebra de userspace. |
| **Continue.dev** | Local: `.continue/prompts/brutal-crafter.prompt` | Acione via `@brutal-crafter` ou use como system prompt no painel do Continue. |

---

### 🛠️ Tabela de Flags dos Instaladores

| Flag Linux (`./install.sh`) | Parâmetro Windows (`.\install.ps1`) | Ação |
| :--- | :--- | :--- |
| `-a`, `--all` | `-All` | Configura todos os agentes suportados de uma vez só. |
| `-g`, `--gemini`, `--antigravity` | `-Gemini`, `-Antigravity` | Instala para Google Antigravity e Gemini CLI. |
| `-c`, `--claude` | `-Claude` | Instala para Claude Code. |
| `-o`, `--opencode` | `-OpenCode` | Instala para OpenCode (`~/.config/opencode/skills`). |
| `--codex` | `-Codex` | Instala para OpenAI Codex / OpenDevin (`~/.codex/skills`). |
| `--cursor` | `-Cursor` | Gera arquivo de regra `.cursor/rules/brutal-crafter.mdc`. |
| `--windsurf` | `-Windsurf` | Adiciona regras ao arquivo `.windsurfrules`. |
| `--copilot` | `-Copilot` | Adiciona instruções a `.github/copilot-instructions.md`. |
| `--cline`, `--roo` | `-Cline`, `-Roo` | Adiciona regras ao arquivo `.clinerules`. |
| `--aider` | `-Aider` | Adiciona diretrizes a `CONVENTIONS.md`. |
| `--continue` | `-Continue` | Gera template em `.continue/prompts/brutal-crafter.prompt`. |
| `-s`, `--symlink` | `-Symlink` | Usa symlink / junction (evita duplicar arquivos em dev). |
| `--copy` | *(Padrão)* | Força a cópia física completa de arquivos. |
| `-t`, `--target <caminho>` | `-Target <caminho>` | Instala em um diretório customizado de sua escolha. |
| `-u`, `--uninstall` | `-Uninstall` | Remove a skill dos diretórios alvo. |
| `-h`, `--help` | `-Help` | Exibe o menu de ajuda com todos os parâmetros. |

---

### 📦 Instalação Manual (Se Preferir sem Script)

<details>
<summary><b>Clique para ver os comandos de cópia manual</b></summary>

#### OpenCode:
```bash
# Linux/macOS:
mkdir -p ~/.config/opencode/skills/brutal-crafter
cp -r /caminho/para/brutal-crafter/* ~/.config/opencode/skills/brutal-crafter/

# Windows:
mkdir "$env:USERPROFILE\.config\opencode\skills\brutal-crafter" -Force
Copy-Item -Path ".\*" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-crafter" -Recurse -Force
```

#### Google Antigravity / Gemini CLI:
```bash
# Linux/macOS:
mkdir -p ~/.gemini/skills/brutal-crafter
cp -r /caminho/para/brutal-crafter/* ~/.gemini/skills/brutal-crafter/

# Windows:
mkdir "$env:USERPROFILE\.gemini\skills\brutal-crafter" -Force
Copy-Item -Path ".\*" -Destination "$env:USERPROFILE\.gemini\skills\brutal-crafter" -Recurse -Force
```

#### Claude Code:
```bash
# Linux/macOS:
mkdir -p ~/.claude/skills/brutal-crafter
cp -r /caminho/para/brutal-crafter/* ~/.claude/skills/brutal-crafter/

# Windows:
mkdir "$env:USERPROFILE\.claude\skills\brutal-crafter" -Force
Copy-Item -Path ".\*" -Destination "$env:USERPROFILE\.claude\skills\brutal-crafter" -Recurse -Force
```

#### Cursor IDE:
Crie o arquivo `.cursor/rules/brutal-crafter.mdc` contendo:
```markdown
---
description: brutal-crafter - Engenharia pragmática sem over-engineering
globs: *
alwaysApply: true
---
Consulte as regras completas e os comandos /bc-x, /bc-plan, /bc-task, /bc-dev definidos em SKILL.md.
```

</details>

# Windows:
mkdir "$env:USERPROFILE\.gemini\skills\brutal-crafter" -Force
Copy-Item -Path ".\*" -Destination "$env:USERPROFILE\.gemini\skills\brutal-crafter" -Recurse -Force
```

#### Claude Code:
```bash
# Linux/macOS:
mkdir -p ~/.claude/skills/brutal-crafter
cp -r /caminho/para/brutal-crafter/* ~/.claude/skills/brutal-crafter/

# Windows:
mkdir "$env:USERPROFILE\.claude\skills\brutal-crafter" -Force
Copy-Item -Path ".\*" -Destination "$env:USERPROFILE\.claude\skills\brutal-crafter" -Recurse -Force
```

#### Cursor IDE:
Crie o arquivo `.cursor/rules/brutal-crafter.mdc` contendo:
```markdown
---
description: brutal-crafter - Engenharia pragmática sem over-engineering
globs: *
alwaysApply: true
---
Consulte as regras completas e os comandos /bc-x, /bc-plan, /bc-task, /bc-dev definidos em SKILL.md.
```

</details>

---

## 📜 Licença
Distribuído sob licença [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).
