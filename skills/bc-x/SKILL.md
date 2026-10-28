---
name: bc-x
description: Brutal Crafter - Auditoria de codebase & análise de riscos arquiteturais. Ingestão via npx repomix ou fallback nativo (find/grep), varredura de leaks, concorrência e timeouts. Use /bc-x [-s|-d] [caminho].
---

# Brutal Crafter: `/bc-x` — Auditoria de Codebase & Riscos

Executa varredura profunda no repositório ou diretório indicado para identificar anti-patterns, memory leaks, concorrência perigosa, timeouts ausentes e violações dos 14 livros clássicos contidos em `agent-rules-books/`.

---

## ⚡ Formato de Invocação

```text
/bc-x [-s | -d] [caminho_opcional]
```

- **`-s` (⚡ Quick / Padrão):** Resumo executivo dos 5 riscos mais graves e recomendações imediatas.
- **`-d` (🔬 Deep Dive):** Varredura linha a linha, contratos violados, pontos de saturação e mitigação formal.
- *(Aliases: `/bt-x`)*

---

## 🔍 Ingestão e Varredura com Fallback Nativo

1. **Tentativa Primária:** Executa `npx repomix --style xml` caso o pacote esteja disponível.
2. **Fallback Nativo Automático:** Se `npx` ou `repomix` não existirem, executa busca cirúrgica usando comandos bash padrão (`find`, `grep -rnE`, `git status`) para mapear:
   - Conexões de banco/cursores abertos sem `using`/`defer`/`with`.
   - Chamadas assíncronas blocantes (`.Result`, `.Wait()`, `.block()`).
   - Requisições HTTP sem timeout explícito.
   - Comandos Redis bloqueantes (`KEYS *`) ou consultas sem índices.
   - Variáveis mutáveis padrão em assinaturas de funções.

---

## 🏛️ Estrutura Obrigatória da Resposta

Apresenta o relatório estritamente nos **4 Pilares**:
1. **🎯 1. Problema Real:** Estado atual do código e causas-raiz dos riscos.
2. **💡 2. Solução Recomendada:** Padrões consolidados para refatoração limpa.
3. **⚠️ 3. Riscos e Armadilhas:** Impactos de produção (OOM, deadlocks, connection leaks).
4. **🚀 4. Melhorias e Evolução:** Passos de saneamento ordenados por criticidade.

---

## 👉 Próximo Passo Obrigatório (Call to Action)

Termine a resposta com:
`👉 Próximo passo recomendado: /bc-craft -s [feature prioritária] ou /bc-plan -s [feature]`
