---
name: bc-task
description: Brutal Crafter - Detalhamento atômico de tarefas com persistência em .docs/brutal-crafter/ em formato checklist (- [ ]), critérios EARS e sincronização Jira MCP. Use /bc-task [-s|-d] [-j] [--status].
---

# Brutal Crafter: `/bc-task` — Detalhamento Atômico & Persistência

Pega o planejamento arquitetural gerado por `/bc-plan` e o quebra em tarefas atômicas sequenciais (máximo 5), gravando o arquivo em disco `.docs/brutal-crafter/tasks_DD-MM-YYYY.md` com checklists `- [ ]` e suporte a sincronização Jira via MCP (`-j`).

---

## ⚡ Formato de Invocação

```text
/bc-task [-s | -d] [-j] [--status] [demanda_ou_plano]
```

- **`-s` (⚡ Quick / Padrão):** Gera tarefas atômicas em formato de checklist sucinto e grava o arquivo.
- **`-d` (🔬 Deep Dive):** Tarefas com contratos detalhados, payloads de exemplo e suites de teste.
- **`-j` (Jira MCP Sync):** Sincroniza cada card individualmente no Jira.
- **`--status`:** Exibe painel compacto das tarefas do arquivo mais recente em `.docs/brutal-crafter/` (concluídas vs pendentes).
- *(Aliases: `/bt-task`)*

---

## 📁 Persistência Física e Formato Checklist

Cada tarefa é salva obrigatoriamente no arquivo `.docs/brutal-crafter/tasks_DD-MM-YYYY.md` na seguinte estrutura:

```markdown
### - [ ] [TASK-XX] Título Claro e Específico
- **🎯 Problema que Resolve:** Descrição cirúrgica do escopo.
- **🧩 Detalhamento Técnico:** Classes, métodos, assinaturas e bibliotecas.
- **🛠️ Arquivos & Alvos:** Caminhos absolutos e relativos dos arquivos envolvidos.
- **✅ Critério de Aceite e Testes (EARS):**
  - `WHEN [evento de disparo], o sistema SHALL [comportamento].`
  - `WHILE [estado do sistema], o sistema SHALL [manter garantia].`
  - `IF [condição de falha], THEN o sistema SHALL [recuperação graciosa].`
- **🔗 Dependências:** Pré-requisitos ou tarefas anteriores.
```

---

## 👉 Próximo Passo Obrigatório (Call to Action)

Termine a resposta com:
- Sem `-j`: `👉 Próximo passo recomendado: /bc-task -j (sincronizar Jira) ou /bc-dev -e TASK-01 (implementar com validação)`
- Com `-j`: `👉 Próximo passo recomendado: /bc-dev -e TASK-01 (guiado pelo arquivo sincronizado no Jira)`
