# 🧠 brutal-crafter

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/Licen%C3%A7a-Apache%202.0-blue.svg?style=flat-square" alt="Licença Apache 2.0"></a>
  <img src="https://img.shields.io/badge/PRs-Bem--vindas-brightgreen.svg?style=flat-square" alt="Pull Requests Bem-vindas">
  <img src="https://img.shields.io/badge/Over--Engineering-Zero%20Toler%C3%A2ncia-red.svg?style=flat-square" alt="Zero Tolerância a Over-Engineering">
  <img src="https://img.shields.io/badge/Foco-ADHD%20Ready-brightgreen.svg?style=flat-square" alt="ADHD Ready">
  <img src="https://img.shields.io/badge/Jira-MCP%20Sync-blue.svg?style=flat-square" alt="Jira Sync">
  <img src="https://img.shields.io/badge/Multi--Agente-Cursor%20%7C%20Antigravity%20%7C%20Gemini%20%7C%20Claude%20%7C%20Copilot%20%7C%20OpenCode%20%7C%20Codex-purple.svg?style=flat-square" alt="Compatível com Cursor, Antigravity, Gemini, Claude, Copilot, OpenCode e Codex">
</p>

<p align="center">
  <strong>"Menos teatro corporativo, zero preâmbulos vazios e mais engenharia artesanal rodando sem derrubar a infraestrutura às 3h da manhã."</strong>
</p>

---

## 📑 Sumário

- [Visão Geral](#visao-geral)
- [Como Executar e Comandos Oficiais](#como-executar)
  - [Diferença entre /brutal-crafter e os Comandos /bc-*](#diferenca-comandos)
  - [Fluxos de Execução: Direto vs. Modular](#fluxos-execucao)
  - [Tabela de Comandos & Exemplos](#tabela-comandos)
  - [Gestão Ativa de Ritmo (`-s` vs `-d`)](#gestao-ritmo)
  - [Próximo Passo Obrigatório (Call to Action)](#call-to-action)
- [Filosofia Central: Rigor Técnico + Simplicidade](#filosofia)
- [Instalação e Configuração Multiagente](#instalacao)
  - [🚀 Antigravity (Google)](#antigravity)
  - [♊ Gemini CLI & Code Assist](#gemini)
  - [🟢 Cursor AI / Windsurf](#cursor)
  - [🟠 Claude Code](#claude)
  - [🔵 GitHub Copilot](#copilot)
  - [⚡ OpenCode](#opencode)
  - [🟣 OpenAI Codex / OpenDevin](#codex)
  - [🤖 Scripts Automatizados (`scripts/install.sh` / `scripts/install.ps1`)](#scripts-instalacao)
- [Base Teórica Fundamentada (`agent-rules-books`)](#base-teorica)
- [Diretrizes Especializadas por Stack Técnica](#diretrizes-por-stack)
- [Arquitetura de Tarefas e Persistência em 3 Níveis](#arquitetura-tarefas)
- [Formato do Output de Planejamento e Execução](#formato-output)
- [Segurança, LGPD & Licença](#seguranca-licenca)

---

<a id="visao-geral"></a>
## 📌 Visão Geral

O **`brutal-crafter`** é uma Skill universal e agnóstica para assistentes e CLIs de IA (**Antigravity**, **Cursor**, **Gemini CLI**, **Claude Code**, **OpenCode**, **GitHub Copilot**, **Windsurf**, **Codex**).

A maioria das IAs quando questionada sobre arquitetura ou código sofre de dois extremos: ou gera elogios genéricos e páginas de prosa vazia, ou inventa dezenas de camadas desnecessárias (*"vamos criar um cluster Kubernetes com Event Sourcing e Kafka para um CRUD simples"*), esquecendo detalhes críticos como fechamento de conexões, timeouts e idempotência.

O **brutal-crafter** acaba com o teatro corporativo aplicando engenharia de sistemas de missão crítica aliada ao estilo de ação imediata:

* 🟢 **Ação Imediata & ADHD Ready:** Comandos diretos na primeira linha, passos numerados, listas com no máximo 5 itens e zero preâmbulos fofos.
* ⚔️ **Guerra ao Over-Engineering:** Princípio do *Good Taste* (eliminar casos especiais na modelagem) e a regra de ouro *Never Break Userspace*.
* 🏛️ **Os 4 Pilares Inegociáveis:** Todo planejamento arquitetural decompõe **Problema Real**, **Solução Recomendada**, **Riscos e Armadilhas** e **Melhorias e Evolução**.
* 📚 **Fundamentação Clássica:** Críticas e validações respaldadas pelas obras canônicas da engenharia de software contidas em `agent-rules-books/`.
* 📝 **Persistência Física & Jira MCP:** Salva automaticamente o planejamento em `.docs/brutal-crafter/tasks_*.md` com formato checklist (`- [ ]` / `- [x]`), execução hands-on (`-e`) e sincronização resiliente com Jira via MCP (`-j`).

---

<a id="como-executar"></a>
## ⚡ Como Executar e Comandos Oficiais

<a id="diferenca-comandos"></a>
### 🧭 Qual a Diferença do `/brutal-crafter` para os Comandos `/bc-*`?

O ecossistema é desenhado para cobrir tanto conversas livres de alto nível quanto execuções táticas cirúrgicas:

| Comando | Escopo e Função Principal | Quando Usar |
| :--- | :--- | :--- |
| **`/brutal-crafter`** | **Guarda-chuva & Orquestrador Geral:** Ativa a persona sênior completa (ADHD, Good Taste, Never Break Userspace, os 14 livros) e interpreta qualquer demanda livre, orientando você ou disparando a etapa certa automaticamente. | Para discussões arquiteturais abertas, dúvidas conceituais de design ou quando não souber por qual etapa começar. |
| **`/bc-craft`** | **Atalho em 1 Passo (All-in-One):** Gera os 4 pilares + decompõe tarefas em disco (`.docs/brutal-crafter/`) + sincroniza no Jira (`-j`). | Quando já sabe o que precisa construir e quer o plano e as tarefas geradas de imediato sem fricção. |
| **`/bc-x`** | **Auditoria de Codebase:** Varredura técnica profunda no código existente caçando leaks de recursos, concorrência perigosa, timeouts e anti-patterns. | Antes de refatorar código legado ou ao ingressar em um repositório desconhecido. |
| **`/bc-plan`** | **Planejamento Conceitual Puro:** Desarma premissas falsas e estrutura os 4 pilares arquiteturais sem gerar arquivos de tarefas ainda. | Quando a demanda técnica ainda é vaga e necessita de alinhamento prévio antes de criar tarefas. |
| **`/bc-task`** | **Detalhamento e Persistência Física:** Quebra o planejamento em tarefas atômicas sequenciais em disco com checklist `- [ ]` e sincroniza no Jira via MCP (`-j`). | Para formalizar o backlog de desenvolvimento em arquivo e sincronizar o board. |
| **`/bc-dev`** | **Diretrizes e Execução Hands-on:** Lê o arquivo em disco. No modo `-e`, codifica autonomamente, roda os testes do projeto e fecha o checklist (`- [x]`). | Para implementar cada tarefa com validação real e sem quebrar contratos de produção. |

---

<a id="fluxos-execucao"></a>
### 🔄 Fluxos de Execução: Direto vs. Modular

```text
Fluxo Direto (Recomendado - Alta Velocidade):
/bc-craft [-s | -d] [-j] (Planejamento 4 Pilares + Tarefas em Disco + Jira) ──► /bc-dev -e (Código Seguro & Testes)

Fluxo Modular / Tradicional:
/bc-x (Auditoria Codebase) ──► /bc-plan (Requisitos) ──► /bc-task (Tarefas em Disco/Jira) ──► /bc-dev (Código Seguro)
```

---

<a id="tabela-comandos"></a>
### 🛠️ Tabela de Comandos & Exemplos

| Comando | O Que Faz | Exemplo de Uso |
| :--- | :--- | :--- |
| **`/brutal-crafter`** | **Skill Master & Orquestrador Geral:** Carrega a persona artesanal completa e atende qualquer demanda arquitetural ou de código. | `/brutal-crafter Como isolar o core bancário de APIs legadas?` |
| **`/bc-craft [-s \| -d] [-j]`** | **Planejamento & Tarefas Unificado:** Gera os 4 pilares de arquitetura e já salva as tarefas atômicas em `.docs/brutal-crafter/tasks_*.md` com suporte a sync Jira MCP (`-j`). *(Aliases: `/bc-pt`, `/bc-plantask`)* | `/bc-craft -s Webhook Pix`<br>`/bc-craft -d -j Gateway pagamentos` |
| **`/bc-x [-s \| -d] [caminho]`** | **Auditoria de Codebase & Riscos:** Ingestão com `npx repomix` ou fallback nativo automático (`find`/`grep`), varredura de leaks, concorrência, timeouts e anti-patterns. | `/bc-x -s`<br>`/bc-x -d src/Billing` |
| **`/bc-plan [-s \| -d]`** | **Requisitos & Solução:** Desarma premissas falsas, elimina over-engineering e consolida os 4 pilares arquiteturais. | `/bc-plan -s Criar checkout Pix`<br>`/bc-plan -d Gateway de pagamentos` |
| **`/bc-task [-s \| -d] [-j] [--status]`** | **Detalhamento Atômico & Arquivo:** Salva em `.docs/brutal-crafter/tasks_*.md` com formato checklist `- [ ]`, suporte a `--status` e sync Jira MCP. | `/bc-task -s Plano de checkout`<br>`/bc-task -d -j Plano de checkout`<br>`/bc-task --status` |
| **`/bc-dev [-s \| -d \| -e]`** | **Diretrizes Técnicas ou Execução Hands-on:** Lê o arquivo `.docs/brutal-crafter/` mais recente. No modo `-e`, codifica, executa testes e marca `- [x]`. | `/bc-dev -s TASK-01`<br>`/bc-dev -e TASK-01` |

> [!TIP]
> **Compatibilidade Retroativa:** Todos os comandos `/bt-*` (`/bt-x`, `/bt-plan`, `/bt-task`, `/bt-dev`) são mantidos como aliases transparentes.

---

<a id="gestao-ritmo"></a>
### ⏱️ Gestão Ativa de Ritmo (`-s` vs `-d`)

A skill adapta a profundidade sem burocracia:

1. **Comando isolado (ex: `/bc-plan`):** Exibe o seletor objetivo de 2 opções:
   > 🎯 **Qual ritmo você precisa agora?**  
   > - `1` ou `-s` (⚡ Quick): Direto ao ponto, 4 pilares em 30s.  
   > - `2` ou `-d` (🔬 Deep): Minúcias técnicas, contratos e diagramas.
2. **Comando com demanda sem flag (ex: `/bc-plan criar webhook`):**
   Assume **`-s` (Quick)** por padrão e exibe dica no topo: `[MODO: ⚡ QUICK | 💡 Quer ver em detalhes? Responda apenas "-d"]`.
3. **Comutação instantânea:** Se responder apenas `-d` na sequência, a análise é expandida instantaneamente para o modo Deep.

---

<a id="call-to-action"></a>
### 👉 Próximo Passo Obrigatório (Call to Action)

Toda resposta encerra com a próxima ação bounded recomendada:
* **Após `/bc-x`:** `👉 Próximo passo recomendado: /bc-craft -s [feature] ou /bc-plan -s [feature]`
* **Após `/bc-plan`:** `👉 Próximo passo recomendado: /bc-task -s [ID ou tema do plano]`
* **Após `/bc-task` ou `/bc-craft` (sem `-j`):** `👉 Próximo passo recomendado: /bc-task -j (sincronizar Jira) ou /bc-dev -e TASK-01 (implementar)`
* **Após `/bc-task` ou `/bc-craft` (com `-j`):** `👉 Próximo passo recomendado: /bc-dev -e TASK-01 (guiado pelo arquivo sincronizado no Jira)`
* **Após `/bc-dev`:** `👉 Próximo passo recomendado: /bc-dev -e [próxima TASK] ou /bc-task --status`

---

<a id="filosofia"></a>
## 🎯 Filosofia Central: Rigor Técnico + Simplicidade

| Princípio | Diretriz Prática |
| :--- | :--- |
| **🟢 Sinceridade Sem Fofura** | Sem elogios vazios ou rodeios. Diagnóstico imediato do problema e da causa-raiz. |
| **⚔️ Guerra ao Over-Engineering** | A solução mais elegante é a mais simples que resolve o problema sem criar 15 camadas desnecessárias. |
| **🛡️ Never Break Userspace** | Código "teoricamente perfeito" que quebra contratos ou clientes em produção é terminantemente rejeitado. |
| **⏱️ Zero Bikeshedding & Foco ADHD** | Ação na primeira linha, passos ordenados, no máximo 5 itens por lista e foco em resiliência, concorrência e estabilidade. |
| **🧠 Memória & Persistência Auditável** | Tarefas físicas salvas em `.docs/brutal-crafter/` com checklists `- [ ]` / `- [x]` e rastreabilidade total. |
| **⚡ Execução Autônoma** | Permissão total para inspecionar, criar diretórios, gerar arquivos de tarefas e executar testes sem interrupções desnecessárias. |

---

<a id="instalacao"></a>
## 🛠️ Guia de Instalação e Configuração Multiagente

A Skill necessita estritamente de apenas **2 itens** para funcionar:
1. O arquivo de instruções (`SKILL.md`) e os sub-comandos (`skills/bc-*/`)
2. A pasta com a biblioteca de regras (`agent-rules-books/`)

A base bibliográfica (`agent-rules-books/`) é autossuficiente e vem embutida diretamente na árvore do repositório (não requer submódulos Git). A estratégia de **cópia limpa** garante que apenas esses itens essenciais sejam transferidos para o seu assistente ou projeto, registrando tanto a skill principal `/brutal-crafter` quanto os comandos dedicados `/bc-craft`, `/bc-x`, `/bc-plan`, `/bc-task` e `/bc-dev` no autocomplete do seu chat.

> [!TIP]
> **⚡ Recomendado (Registra Todos os Comandos `/bc-*` Automaticamente):**
> Execute o script `./scripts/install.sh` (Linux/macOS) ou `.\scripts\install.ps1` (Windows). Ele detecta automaticamente o Google Antigravity, Gemini CLI, Claude Code e OpenCode e registra **todos** os comandos oficiais (`/bc-craft`, `/bc-x`, `/bc-plan`, `/bc-task`, `/bc-dev`, `/brutal-crafter`) com autocompletion instantâneo.

---

<a id="antigravity"></a>
### 🚀 Antigravity (Google)

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-crafter.git /tmp/bc_temp && \
    mkdir -p ~/.antigravity/skills/brutal-crafter && \
    cp /tmp/bc_temp/SKILL.md ~/.antigravity/skills/brutal-crafter/ && \
    cp -r /tmp/bc_temp/agent-rules-books ~/.antigravity/skills/brutal-crafter/ && \
    rm -rf /tmp/bc_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-crafter.git $env:TEMP\bc_temp; `
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.antigravity\skills\brutal-crafter"; `
    Copy-Item "$env:TEMP\bc_temp\SKILL.md" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-crafter\"; `
    Copy-Item -Recurse -Force "$env:TEMP\bc_temp\agent-rules-books" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-crafter\"; `
    Remove-Item -Recurse -Force "$env:TEMP\bc_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    mkdir -p ~/.antigravity/skills/brutal-crafter && \
    cp SKILL.md ~/.antigravity/skills/brutal-crafter/ && \
    cp -r agent-rules-books ~/.antigravity/skills/brutal-crafter/
    ```
  - **Windows (PowerShell):**
    ```powershell
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.antigravity\skills\brutal-crafter"
    Copy-Item "SKILL.md" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-crafter\"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-crafter\"
    ```
- **🔗 Via Symlink (Execute dentro da pasta clonada):**
  - **Linux / macOS:** `mkdir -p ~/.antigravity/skills && ln -sfn "$(pwd)" ~/.antigravity/skills/brutal-crafter`
  - **Windows (PowerShell):** `New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.antigravity\skills"; New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.antigravity\skills\brutal-crafter" -Target (Get-Location)`

---

<a id="gemini"></a>
### ♊ Gemini CLI & Code Assist

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-crafter.git /tmp/bc_temp && \
    mkdir -p ~/.gemini/skills/brutal-crafter && \
    cp /tmp/bc_temp/SKILL.md ~/.gemini/skills/brutal-crafter/ && \
    cp -r /tmp/bc_temp/agent-rules-books ~/.gemini/skills/brutal-crafter/ && \
    rm -rf /tmp/bc_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-crafter.git $env:TEMP\bc_temp; `
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini\skills\brutal-crafter"; `
    Copy-Item "$env:TEMP\bc_temp\SKILL.md" -Destination "$env:USERPROFILE\.gemini\skills\brutal-crafter\"; `
    Copy-Item -Recurse -Force "$env:TEMP\bc_temp\agent-rules-books" -Destination "$env:USERPROFILE\.gemini\skills\brutal-crafter\"; `
    Remove-Item -Recurse -Force "$env:TEMP\bc_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    mkdir -p ~/.gemini/skills/brutal-crafter && \
    cp SKILL.md ~/.gemini/skills/brutal-crafter/ && \
    cp -r agent-rules-books ~/.gemini/skills/brutal-crafter/
    ```
  - **Windows (PowerShell):**
    ```powershell
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini\skills\brutal-crafter"
    Copy-Item "SKILL.md" -Destination "$env:USERPROFILE\.gemini\skills\brutal-crafter\"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "$env:USERPROFILE\.gemini\skills\brutal-crafter\"
    ```
- **🔗 Via Symlink (Execute dentro da pasta clonada):**
  - **Linux / macOS:** `mkdir -p ~/.gemini/skills && ln -sfn "$(pwd)" ~/.gemini/skills/brutal-crafter`
  - **Windows (PowerShell):** `New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini\skills"; New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gemini\skills\brutal-crafter" -Target (Get-Location)`

---

<a id="cursor"></a>
### 🟢 Cursor AI / Windsurf (No projeto ativo)

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  *Execute na raiz do projeto onde deseja habilitar o brutal-crafter:*
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-crafter.git /tmp/bc_temp && \
    cp /tmp/bc_temp/SKILL.md .cursorrules && \
    cp -r /tmp/bc_temp/agent-rules-books ./agent-rules-books && \
    rm -rf /tmp/bc_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-crafter.git $env:TEMP\bc_temp; `
    Copy-Item "$env:TEMP\bc_temp\SKILL.md" -Destination ".cursorrules"; `
    Copy-Item -Recurse -Force "$env:TEMP\bc_temp\agent-rules-books" -Destination "agent-rules-books"; `
    Remove-Item -Recurse -Force "$env:TEMP\bc_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    cp SKILL.md /caminho/do/seu/projeto/.cursorrules && \
    cp -r agent-rules-books /caminho/do/seu/projeto/
    ```
  - **Windows (PowerShell):**
    ```powershell
    Copy-Item "SKILL.md" -Destination "C:\caminho\do\projeto\.cursorrules"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "C:\caminho\do\projeto\agent-rules-books"
    ```
- **🔗 Via Symlink (Opcional):**
  - **Linux / macOS:** `ln -s /caminho/para/brutal-crafter/SKILL.md .cursorrules && ln -s /caminho/para/brutal-crafter/agent-rules-books agent-rules-books`
  - **Windows (PowerShell):** `New-Item -ItemType SymbolicLink -Path ".cursorrules" -Target "C:\caminho\para\brutal-crafter\SKILL.md"; New-Item -ItemType SymbolicLink -Path "agent-rules-books" -Target "C:\caminho\para\brutal-crafter\agent-rules-books"`

---

<a id="claude"></a>
### 🟠 Claude Code (No projeto ativo ou Global)

#### No Projeto Ativo (Recomendado)
*Execute na raiz do projeto onde deseja habilitar o brutal-crafter:*

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-crafter.git /tmp/bc_temp && \
    cp /tmp/bc_temp/SKILL.md CLAUDE.md && \
    cp -r /tmp/bc_temp/agent-rules-books ./agent-rules-books && \
    rm -rf /tmp/bc_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-crafter.git $env:TEMP\bc_temp; `
    Copy-Item "$env:TEMP\bc_temp\SKILL.md" -Destination "CLAUDE.md"; `
    Copy-Item -Recurse -Force "$env:TEMP\bc_temp\agent-rules-books" -Destination "agent-rules-books"; `
    Remove-Item -Recurse -Force "$env:TEMP\bc_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    cp SKILL.md /caminho/do/seu/projeto/CLAUDE.md && \
    cp -r agent-rules-books /caminho/do/seu/projeto/
    ```
  - **Windows (PowerShell):**
    ```powershell
    Copy-Item "SKILL.md" -Destination "C:\caminho\do\projeto\CLAUDE.md"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "C:\caminho\do\projeto\agent-rules-books"
    ```

#### Global (Claude Code Skills)
- **Linux / macOS:** `mkdir -p ~/.claude/skills/brutal-crafter && cp SKILL.md ~/.claude/skills/brutal-crafter/ && cp -r agent-rules-books ~/.claude/skills/brutal-crafter/`
- **Windows (PowerShell):** `New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills\brutal-crafter"; Copy-Item "SKILL.md" -Destination "$env:USERPROFILE\.claude\skills\brutal-crafter\"; Copy-Item -Recurse -Force "agent-rules-books" -Destination "$env:USERPROFILE\.claude\skills\brutal-crafter\"`

---

<a id="copilot"></a>
### 🔵 GitHub Copilot (No projeto ativo)

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  *Execute na raiz do projeto onde deseja habilitar o brutal-crafter:*
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-crafter.git /tmp/bc_temp && \
    mkdir -p .github && \
    cp /tmp/bc_temp/SKILL.md .github/copilot-instructions.md && \
    cp -r /tmp/bc_temp/agent-rules-books ./agent-rules-books && \
    rm -rf /tmp/bc_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-crafter.git $env:TEMP\bc_temp; `
    New-Item -ItemType Directory -Force -Path ".github"; `
    Copy-Item "$env:TEMP\bc_temp\SKILL.md" -Destination ".github\copilot-instructions.md"; `
    Copy-Item -Recurse -Force "$env:TEMP\bc_temp\agent-rules-books" -Destination "agent-rules-books"; `
    Remove-Item -Recurse -Force "$env:TEMP\bc_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    mkdir -p /caminho/do/seu/projeto/.github && \
    cp SKILL.md /caminho/do/seu/projeto/.github/copilot-instructions.md && \
    cp -r agent-rules-books /caminho/do/seu/projeto/
    ```
  - **Windows (PowerShell):**
    ```powershell
    New-Item -ItemType Directory -Force -Path "C:\caminho\do\projeto\.github"
    Copy-Item "SKILL.md" -Destination "C:\caminho\do\projeto\.github\copilot-instructions.md"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "C:\caminho\do\projeto\agent-rules-books"
    ```

---

<a id="opencode"></a>
### ⚡ OpenCode

O **OpenCode** suporta Skills nativamente através do diretório `.opencode/skills/` (no projeto ativo) ou `~/.config/opencode/skills/` (global para todos os projetos do usuário).

#### No Projeto Ativo (Recomendado)
*Execute na raiz do projeto onde deseja habilitar o brutal-crafter:*

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-crafter.git /tmp/bc_temp && \
    mkdir -p .opencode/skills/brutal-crafter && \
    cp /tmp/bc_temp/SKILL.md .opencode/skills/brutal-crafter/ && \
    cp -r /tmp/bc_temp/agent-rules-books .opencode/skills/brutal-crafter/ && \
    rm -rf /tmp/bc_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-crafter.git $env:TEMP\bc_temp; `
    New-Item -ItemType Directory -Force -Path ".opencode\skills\brutal-crafter"; `
    Copy-Item "$env:TEMP\bc_temp\SKILL.md" -Destination ".opencode\skills\brutal-crafter\"; `
    Copy-Item -Recurse -Force "$env:TEMP\bc_temp\agent-rules-books" -Destination ".opencode\skills\brutal-crafter\"; `
    Remove-Item -Recurse -Force "$env:TEMP\bc_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    mkdir -p /caminho/do/seu/projeto/.opencode/skills/brutal-crafter && \
    cp SKILL.md /caminho/do/seu/projeto/.opencode/skills/brutal-crafter/ && \
    cp -r agent-rules-books /caminho/do/seu/projeto/
    ```
  - **Windows (PowerShell):**
    ```powershell
    New-Item -ItemType Directory -Force -Path "C:\caminho\do\projeto\.opencode\skills\brutal-crafter"
    Copy-Item "SKILL.md" -Destination "C:\caminho\do\projeto\.opencode\skills\brutal-crafter\"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "C:\caminho\do\projeto\agent-rules-books"
    ```

#### Global (Disponível em qualquer projeto no OpenCode)
- **Linux / macOS / WSL:**
  ```bash
  mkdir -p ~/.config/opencode/skills/brutal-crafter && \
  cp SKILL.md ~/.config/opencode/skills/brutal-crafter/ && \
  cp -r agent-rules-books ~/.config/opencode/skills/brutal-crafter/
  ```
- **Windows (PowerShell):**
  ```powershell
  New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode\skills\brutal-crafter"
  Copy-Item "SKILL.md" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-crafter\"
  Copy-Item -Recurse -Force "agent-rules-books" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-crafter\"
  ```

---

<a id="codex"></a>
### 🟣 OpenAI Codex / OpenDevin

- **Linux / macOS / WSL:**
  ```bash
  mkdir -p ~/.codex/skills/brutal-crafter && \
  cp SKILL.md ~/.codex/skills/brutal-crafter/ && \
  cp -r agent-rules-books ~/.codex/skills/brutal-crafter/
  ```
- **Windows (PowerShell):**
  ```powershell
  New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.codex\skills\brutal-crafter"
  Copy-Item "SKILL.md" -Destination "$env:USERPROFILE\.codex\skills\brutal-crafter\"
  Copy-Item -Recurse -Force "agent-rules-books" -Destination "$env:USERPROFILE\.codex\skills\brutal-crafter\"
  ```

---

<a id="scripts-instalacao"></a>
### 🤖 Scripts Automatizados (`scripts/install.sh` / `scripts/install.ps1`)

O repositório disponibiliza instaladores automatizados na pasta `scripts/` que realizam **auto-detecção inteligente** dos ambientes presentes e aplicam a estratégia de cópia limpa ou links simbólicos:

```bash
# Linux / macOS:
./scripts/install.sh                    # Auto-detecta ambientes (Antigravity, Gemini, Claude, OpenCode, Codex)
./scripts/install.sh --symlink          # Modo desenvolvimento contínuo (cria links simbólicos)
./scripts/install.sh --all              # Instala e configura em todos os agentes suportados
./scripts/install.sh --project          # Instala localmente no projeto ativo (.cursorrules, CLAUDE.md, etc.)
./scripts/install.sh --uninstall --all  # Remove a skill dos diretórios de agentes
```

```powershell
# Windows (PowerShell):
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1               # Auto-detecta e instala
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Symlink      # Cria links/junctions para dev
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -All          # Configura todos os agentes
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Project      # Instala no projeto ativo
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Uninstall    # Remove a skill
```

| Flag Linux (`./scripts/install.sh`) | Parâmetro Windows (`.\scripts\install.ps1`) | Descrição |
| :--- | :--- | :--- |
| `-a`, `--all` | `-All` | Configura todos os agentes suportados. |
| `-g`, `--gemini`, `--antigravity` | `-Gemini`, `-Antigravity` | Instala no Antigravity e Gemini CLI (`~/.antigravity` e `~/.gemini`). |
| `-c`, `--claude` | `-Claude` | Instala no Claude Code (`~/.claude/skills`). |
| `-o`, `--opencode` | `-OpenCode` | Instala no OpenCode (`~/.config/opencode/skills`). |
| `--codex` | `-Codex` | Instala no OpenAI Codex / OpenDevin (`~/.codex/skills`). |
| `-p`, `--project` | `-Project` | Instala no projeto atual (`.cursorrules`, `CLAUDE.md`, `.github/copilot-instructions.md`, `agent-rules-books/`). |
| `-s`, `--symlink` | `-Symlink` | Cria symlinks / junctions (atualizações refletem imediatamente). |
| `--copy` | *(Padrão)* | Força a cópia física limpa dos 2 itens essenciais. |
| `-u`, `--uninstall` | `-Uninstall` | Desinstala a skill dos ambientes selecionados. |
| `-h`, `--help` | `-Help` | Exibe o menu detalhado de ajuda. |

---

<a id="base-teorica"></a>
## 📚 Base Teórica Fundamentada (`agent-rules-books`)

O agente não inventa regras da própria cabeça nem alucina opiniões pessoais. Toda análise arquitetural, apontamento de riscos e sugestão técnica cita as obras clássicas contidas em `./agent-rules-books/`:

| Domínio de Engenharia | Obras e Autores de Referência | Foco de Avaliação |
| :--- | :--- | :--- |
| **🏛️ Arquitetura & Design** | • *A Philosophy of Software Design* (John Ousterhout)<br>• *Clean Architecture* (Robert C. Martin)<br>• *Clean Code* (Robert C. Martin)<br>• *Code Complete* (Steve McConnell)<br>• *Patterns of Enterprise Application Architecture* (Martin Fowler) | Módulos profundos, baixo acoplamento, interfaces simples e legibilidade sem excesso de camadas. |
| **🧩 Domain-Driven Design (DDD)** | • *Domain-Driven Design* (Eric Evans)<br>• *Domain-Driven Design Distilled* (Vaughn Vernon)<br>• *Implementing Domain-Driven Design* (Vaughn Vernon) | Linguagem ubíqua, limites de contexto (Bounded Contexts) e integridade de entidades/agregados. |
| **🔧 Refatoração & Código Legado** | • *Refactoring* (Martin Fowler)<br>• *Refactoring Guru* (Alexander Shvets)<br>• *Working Effectively with Legacy Code* (Michael Feathers) | Técnicas seguras de alteração sem quebrar contratos legados; testes de caracterização. |
| **🌐 Sistemas Distribuídos & Resiliência** | • *Designing Data-Intensive Applications* (Martin Kleppmann)<br>• *Release It!* (Michael Nygard)<br>• *The Pragmatic Programmer* (David Thomas & Andrew Hunt) | Consistência de dados, circuit breakers, timeouts, tolerância a falhas e contenção de concorrência. |

> [!NOTE]
> **Política de Leitura Sob Demanda (`.nano.md`):**
> Para economizar tokens e garantir respostas ultrarrápidas, a skill carrega exclusivamente os resumos cirúrgicos `.nano.md` (< 50 linhas) referentes ao problema em discussão (ex: `release-it.nano.md` para timeouts e circuit breakers; `designing-data-intensive-applications.nano.md` para idempotência). É proibido carregar todos os livros simultaneamente na memória do chat.

---

<a id="diretrizes-por-stack"></a>
## 🔍 Diretrizes Especializadas por Stack Técnica

O `brutal-crafter` vem configurado de fábrica com regras rigorosas para armadilhas comuns em produção:

- **C# / .NET Core:** Bloqueio de LINQ em rotinas de alto throughput, deadlocks em chamadas assíncronas (`.Result`, `.Wait()`), e concatenação de strings em laços (exige `StringBuilder` ou `Span<T>`).
- **Python:** Bloqueio de argumentos mutáveis como default (`def fn(itens=[])`), tarefas CPU-bound em threads comuns ao invés de multiprocessing, e I/O blocante em loops assíncronos.
- **Go:** Detecção de vazamento de Goroutines (canais sem timeout ou contexts sem cancelamento), erros ignorados (`_ = err`) e alocações indevidas na heap por escape analysis induzida por ponteiros.
- **Java / JVM (Spring Boot, Quarkus):** Prevenção de queries N+1 do JPA/Hibernate, bloqueio de chamadas reativas (`.block()`) e estouro de heap por thread pools desconfigurados.
- **Node.js / TypeScript:** Prevenção de travamento do Event Loop com I/O síncrono, tratamento de Floating Promises e vazamento de memória por listeners soltos.
- **Bancos de Dados & Cache (SQL, Redis):** Tolerância zero para vazamento de conexões/cursores fora de blocos `using`/`with`/`defer`, consultas `JSONB` sem índices, comandos bloqueados em produção (`KEYS *` no Redis) e inserções sem TTL.
- **Mensageria & Queues (Kafka, RabbitMQ, SQS):** Obrigatoriedade de idempotência/deduplicação no processamento de mensagens e tratamento de mensagens tóxicas via Dead Letter Queue (DLQ).
- **Containers, K8s & Cloud (Docker, AWS):** Identificação de caminhos locais hardcoded (`C:\temp`, `/mnt/c/`), falta de limites de CPU/RAM em manifests Kubernetes e credenciais expostas.
- **Métricas & Observabilidade:** Alerta contra alta cardinalidade usada como Tags em time-series (InfluxDB) e excesso de logs estruturados em rotinas de alto tráfego.

---

<a id="arquitetura-tarefas"></a>
## 🧠 Arquitetura de Tarefas e Persistência em 3 Níveis

Para manter a integridade do projeto, rastreabilidade contínua e eliminar a necessidade de repetir instruções:

```text
┌─────────────────────────────────────────────────────────────────┐
│ Camada 1: Global Engineering Rules                              │
│ [SKILL_DIR]/agent-rules-books/*.nano.md                         │
│ └─ 14 livros clássicos de arquitetura, resiliência e concorrência│
└────────────────────────────────┬────────────────────────────────┘
                                 │
┌────────────────────────────────┴────────────────────────────────┐
│ Camada 2: Local Project Tasks & State                           │
│ [REPO_ROOT]/.docs/brutal-crafter/tasks_DD-MM-YYYY.md            │
│ └─ Checklists (- [ ] / - [x]), critérios EARS, arquivos e testes│
└────────────────────────────────┬────────────────────────────────┘
                                 │
┌────────────────────────────────┴────────────────────────────────┐
│ Camada 3: Resilient Jira Sync (MCP)                             │
│ Jira Board / Sprints / Issues                                   │
│ └─ Sincronização atômica card a card via MCP (flag -j)          │
└─────────────────────────────────────────────────────────────────┘
```

> [!TIP]
> **Fidelidade Total em Checklist (`- [ ]` ➔ `- [x]`):**
> Ao executar uma tarefa com `/bc-dev -e TASK-XX`, o agente implementa o código, roda os testes de validação e atualiza diretamente o arquivo físico `.docs/brutal-crafter/tasks_*.md`, transformando o item em `- [x]`. O comando `/bc-task --status` exibe um painel rápido de tarefas concluídas e pendentes.

> [!NOTE]
> **Autonomia Total de Execução (Zero Interrupção):**
> O agente possui autorização total para criar o diretório `.docs/brutal-crafter/`, atualizar os arquivos de tarefas, executar comandos de terminal de inspeção/testes e aplicar alterações mantendo tudo na working tree (*git changes*) para inspeção, sem criar commits sem ordem explícita.

---

<a id="formato-output"></a>
## 🚦 Formato do Output de Planejamento e Execução

### Exemplo de Planejamento (`/bc-craft -s Webhook Pix`):

```markdown
# Planejamento Arquitetural: Webhook Pix

### 🎯 1. Problema Real
Recebimento assíncrono de notificações de pagamento sem garantia de ordem ou entrega única. Causa-raiz: idempotência frágil e falta de contenção de concorrência.

### 💡 2. Solução Recomendada
Endpoint dedicado com validação de assinatura HMAC no middleware, registro de deduplicação via Redis com TTL de 24h e despacho de evento para fila interna.

### ⚠️ 3. Riscos e Armadilhas
- **Replay Attacks / Duplicate Processing:** Requisições repetidas debitando ou creditando duas vezes *(Mitigação: ID de transação Pix único com trava no banco)*.
- **Connection Leak:** Falta de liberação de conexão SQL em caso de timeout no gateway de pagamento *(Enforced via agent-rules-books/release-it/)*.

### 🚀 4. Melhorias e Evolução
Adicionar circuit breaker para o provedor PSP e painel de métricas com taxa de deduplicação.

---
📁 **Tarefas salvas com sucesso em:** `.docs/brutal-crafter/tasks_28-10-2026.md`

### - [ ] [TASK-01] Middleware de Validação de Assinatura HMAC
- **Alvo:** `src/Middlewares/PixSignatureMiddleware.cs`
- **Critério EARS:** `WHEN payload for recebido, IF assinatura HMAC for inválida THEN retornar HTTP 401 sem processar corpo.`

👉 **Próximo passo recomendado:** `/bc-dev -e TASK-01`
```

---

<a id="seguranca-licenca"></a>
## 🛡️ Segurança, LGPD & Licença

* **🔒 100% LGPD / PII Safe:** Não transmite nem armazena segredos, credenciais, dados corporativos confidenciais ou informações pessoais identificáveis.
* **📄 Licença:** [Apache 2.0](LICENSE) — Livre para uso pessoal, em equipes e ambientes corporativos.
