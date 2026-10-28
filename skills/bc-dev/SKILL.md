---
name: bc-dev
description: Brutal Crafter - Diretrizes técnicas ou execução prática hands-on (-e) de tarefas persistidas em .docs/brutal-crafter/. Implementa código, roda testes e fecha o checklist (- [x]). Use /bc-dev [-s|-d|-e] <TASK-ID>.
---

# Brutal Crafter: `/bc-dev` — Diretrizes & Execução Hands-on

Consome o arquivo `.docs/brutal-crafter/tasks_*.md` mais recente. No modo `-s` ou `-d`, fornece orientações técnicas cirúrgicas. No modo **`-e` (Execute)**, codifica autonomamente a tarefa, executa as suítes de testes automatizados e marca o checklist como concluído (`- [x]`).

---

## ⚡ Formato de Invocação

```text
/bc-dev [-s | -d | -e] <TASK-ID>
```

- **`-s` (⚡ Quick / Padrão):** Diretrizes objetivas de código em 1 minuto.
- **`-d` (🔬 Deep Dive):** Snippets completos, tratativas de exceção e assinaturas de tipos.
- **`-e` (🚀 Execute / Hands-on):** Implementação ativa no repositório. O agente cria/edita os arquivos, executa a suíte de testes de validação (`dotnet test`, `pytest`, `npm test`, etc.) e altera o checklist de `- [ ]` para `- [x]` no arquivo de tarefas em disco.
- *(Aliases: `/bt-dev`)*

---

## 🛡️ Regras de Ferro de Execução Hands-on (`-e`)

1. **Never Break Userspace:** Não quebre contratos públicos nem comportamento existente.
2. **Migrations Idempotentes & Reversíveis:** Todo script de banco deve ter script de reversão e checagens `IF NOT EXISTS` / `IF EXISTS`.
3. **Validação Obrigatória:** Execute a suíte de testes do projeto antes e depois da implementação.
4. **Fechamento no Markdown:** Ao concluir e validar os testes com sucesso, abra o arquivo `.docs/brutal-crafter/tasks_*.md` e marque a tarefa com `- [x]`.
5. **Alterações na Working Tree:** Mantenha as modificações nos arquivos de trabalho para inspeção do desenvolvedor. Nunca execute `git commit` sem ordem explícita.

---

## 👉 Próximo Passo Obrigatório (Call to Action)

Termine a resposta com:
`👉 Próximo passo recomendado: /bc-dev -e [próxima TASK] ou /bc-task --status para revisar o progresso total.`
