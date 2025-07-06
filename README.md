# Optimizador Inteligente (The Intelligent Optimizer) - Índices B-Tree Avançados em PostgreSQL

Este projeto é parte de um trabalho acadêmico sobre técnicas avançadas de indexação em SGBDs relacionais, utilizando **índices B-Tree** de forma **parcial** e em **expressões** para acelerar consultas em grandes volumes de dados.

---

## 📌 Tema Escolhido: **O Otimizador Inteligente**

> “A missão não é apenas criar um índice, mas criar o índice **certo** para a consulta **certa**, economizando espaço e maximizando velocidade.”

---

## ⚙️ Tecnologias

- PostgreSQL
- pgAdmin
- SQL puro com `EXPLAIN ANALYZE`
- Geração de massa com `generate_series()`

---

## 📁 Estrutura

### Tabelas criadas:

- `tarefas (id, titulo, status)`
- `usuarios (id, username)`

### Volume de dados:

- `tarefas`: **5 milhões de registros**
- `usuarios`: **5 milhões de registros**

---

## ▶️ Como reproduzir

1. Crie um banco de dados PostgreSQL local
2. Execute os scripts da pasta `scripts/` na seguinte ordem:
   - `create_tables.sql`
   - `populate_tarefas.sql`
   - `populate_usuarios.sql`
   - `indices.sql`
   - `queries_explain_analyze.sql`
3. Analise os planos de execução e compare os tempos

---

## 🧪 Cenário 1: Índice Parcial em `tarefas.status`

### Objetivo

Buscar tarefas com status `'pendente'`, mesmo com **98% dos registros como `'concluida'`**. Avaliar desempenho com:

1. Sem índice
2. Índice B-Tree completo
3. Índice parcial para status `'pendente'`

---

### Resultados (com `EXPLAIN ANALYZE`):

| Situação           | Tempo médio (3 exec.) | Tipo de plano usado             |
| ------------------ | --------------------- | ------------------------------- |
| 🔴 Sem índice      | 346,37 ms             | `Seq Scan`                      |
| 🟡 Índice completo | 10,49 ms              | `Bitmap Index Scan`             |
| 🟢 Índice parcial  | 10,19 ms              | `Bitmap Index Scan` (menor I/O) |

---

### Tamanhos dos índices:

| Índice                  | Tamanho    |
| ----------------------- | ---------- |
| `idx_tarefas_status`    | **34 MB**  |
| `idx_tarefas_pendentes` | **360 KB** |

---

### Conclusão

> O índice parcial é 100× menor que o completo, entrega **a mesma performance**, mas com **muito menos custo de manutenção e espaço**. É ideal quando só um subconjunto dos dados é buscado com frequência.

---

## 🧪 Cenário 2: Índice em Expressão com `LOWER(username)`

### Objetivo

Permitir buscas **case-insensitive** por `username` com alta performance, sem varrer milhões de registros.

---

### Resultados (com `EXPLAIN ANALYZE`):

| Situação               | Tempo médio (3 exec.) | Tipo de plano usado |
| ---------------------- | --------------------- | ------------------- |
| 🔴 Sem índice          | 1533,25 ms            | `Seq Scan`          |
| 🟢 Índice em expressão | 0,103 ms              | `Bitmap Index Scan` |

---

### Tamanho do índice:

| Índice                        | Tamanho    |
| ----------------------------- | ---------- |
| `idx_usuarios_lower_username` | **189 MB** |

---

### Conclusão

> Ao criar um índice sobre a **expressão usada na consulta** (`LOWER(username)`), reduzimos o tempo de busca em **99,9933%**. Esse tipo de índice é essencial para filtros com funções como `LOWER()`, `UPPER()`, `DATE_TRUNC()` etc.

---

## 📚 Aprendizados

- Nem todo índice precisa cobrir toda a tabela: **índices parciais** são poderosos quando o filtro é específico.
- O uso de `EXPLAIN ANALYZE` é fundamental para diagnosticar e provar ganhos de performance.
