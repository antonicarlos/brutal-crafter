---
name: bc-craft
description: Brutal Crafter - Planejamento arquitetural em 4 pilares + geração atômica de tarefas em disco (.docs/brutal-crafter/) + sincronização Jira MCP em 1 só passo. Use /bc-craft [-s|-d] [-j] <demanda>.
---

# Brutal Crafter: `/bc-craft` — Planejamento & Tarefas Unificado

Gera os **4 Pilares Arquiteturais**, decompõe em até **5 tarefas atômicas** com critérios **EARS** e salva fisicamente o arquivo em `.docs/brutal-crafter/tasks_DD-MM-YYYY.md`, com suporte opcional a sincronização Jira via MCP (`-j`).

---

## ⚡ Formato de Invocação

```text
/bc-craft [-s | -d] [-j] <sua demanda técnica>
```

- **`-s` (⚡ Quick / Padrão):** 4 pilares em bullets densos, até 5 tarefas objetivas, leitura em 30 segundos.
- **`-d` (🔬 Deep Dive):** Análise profunda, modelagem de dados, diagramas Mermaid, concorrência e riscos exaustivos.
- **`-j` (Jira MCP Sync):** Cria e sincroniza cada tarefa no Jira board ativo via MCP resiliente.
- *(Aliases: `/bc-pt`, `/bc-plantask`, `/bt-craft`)*

---

## 🏛️ Os 4 Pilares Inegociáveis

```markdown
### 🎯 1. Problema Real
[Qual é a dor de verdade e a causa-raiz, destruindo premissas falsas e sintomas superficiais]

### 💡 2. Solução Recomendada
[A rota mais simples, limpa e elegante. Padrões consolidados antes de inventar complexidade]

### ⚠️ 3. Riscos e Armadilhas
[Onde o código vai quebrar: leaks de conexão/memória, esgotamento de pool, deadlocks, race conditions, timeouts]

### 🚀 4. Melhorias e Evolução
[Ações executáveis agora, telemetria e prevenção de débitos técnicos]
```

---

## 📁 Persistência Física Obrigatória

Ao rodar `/bc-craft`, o agente **SEMPRE** executa:
1. Cria a pasta `.docs/brutal-crafter/` (se não existir).
2. Grava `.docs/brutal-crafter/tasks_DD-MM-YYYY.md` com cabeçalho `# Planejamento de Tarefas - DD/MM/YYYY`.
3. Registra as tarefas no formato checklist:
   - `### - [ ] [TASK-XX] Título Claro`
   - **🎯 Problema que Resolve**
   - **🧩 Detalhamento Técnico Profundo** (Tipos, contratos, frameworks)
   - **🛠️ Arquivos & Alvos** (Caminhos e tabelas exatas)
   - **✅ Critério de Aceite e Testes (EARS):** `WHEN [evento]`, `WHILE [estado]`, `IF [erro] THEN [recuperação]`
   - **🔗 Dependências**
4. Se a flag `-j` estiver ativa, sincroniza via Jira MCP mantendo o markdown intacto se algum card falhar.

---

## 👉 Próximo Passo Obrigatório (Call to Action)

Termine a resposta invariavelmente com:
- Sem `-j`: `👉 Próximo passo recomendado: /bc-task -j (sincronizar Jira) ou /bc-dev -e TASK-01 (implementar)`
- Com `-j`: `👉 Próximo passo recomendado: /bc-dev -e TASK-01 (guiado pelo card sincronizado no Jira)`
