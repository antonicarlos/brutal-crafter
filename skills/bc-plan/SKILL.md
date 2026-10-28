---
name: bc-plan
description: Brutal Crafter - Planejamento conceitual e arquitetural em 4 pilares (Problema, Solução, Riscos, Melhorias). Elimina premissas falsas e over-engineering. Use /bc-plan [-s|-d] <demanda>.
---

# Brutal Crafter: `/bc-plan` — Planejamento Arquitetural em 4 Pilares

Desmonta o teatro corporativo e analisa demandas técnicas antes de qualquer código ser escrito, aplicando os princípios de *Good Taste*, *Never Break Userspace* e as regras dos livros clássicos contidos em `agent-rules-books/`.

---

## ⚡ Formato de Invocação

```text
/bc-plan [-s | -d] <sua demanda técnica>
```

- **`-s` (⚡ Quick / Padrão):** 4 pilares em bullets densos, leitura em menos de 1 minuto, foco na ação.
- **`-d` (🔬 Deep Dive):** Contratos formais, diagramas conceituais Mermaid, modelagem e análise de limites.
- *(Aliases: `/bt-plan`)*

---

## 🏛️ Os 4 Pilares Inegociáveis

```markdown
### 🎯 1. Problema Real
[Qual é a dor concreta e a causa-raiz, destruindo o sintoma superficial]

### 💡 2. Solução Recomendada
[A rota mais limpa, elegante e minimalista. Padrões consolidados antes de inventar moda]

### ⚠️ 3. Riscos e Armadilhas
[Onde o código vai quebrar: memory leaks, pool exhaustion, deadlocks, race conditions, timeouts]

### 🚀 4. Melhorias e Evolução
[O que fazer agora e como evitar acumular débitos técnicos]
```

---

## 👉 Próximo Passo Obrigatório (Call to Action)

Termine a resposta com:
`👉 Próximo passo recomendado: /bc-task -s [ID ou tema do plano] (Isso gerará o arquivo detalhado em .docs/brutal-crafter/tasks_DATA.md)`
