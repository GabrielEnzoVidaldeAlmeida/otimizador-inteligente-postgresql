-- * ÍNDICES TABELA TAREFAS *

-- CREATE INDEX idx_tarefas_status ON tarefas(status); -- criando índice B-tree completo na coluna status

-- CREATE INDEX idx_tarefas_pendentes 
-- ON tarefas(status)
-- WHERE status = 'pendente' -- criando um índice parcial (só para pendente) -- criando índice parcial para tarefas pendentes

-- SELECT pg_size_pretty(pg_relation_size('idx_tarefas_status')); -- verificar tamanho índice completo

-- SELECT pg_size_pretty(pg_relation_size('idx_tarefas_pendentes')); -- verificar tamanho índice parcial

-- DROP INDEX idx_tarefas_status;
-- DROP INDEX idx_tarefas_pendentes;

-- * ÍNDICES TABELA USUARIOS *

-- CREATE INDEX idx_usuarios_lower_username ON usuarios(LOWER(username)); -- criando índice em expressão com LOWER(username)

-- SELECT
--   pg_size_pretty(pg_relation_size('idx_usuarios_lower_username')) AS tamanho; -- verificar tamanho índice tabela usuarios

-- DROP INDEX idx_usuarios_lower_username


