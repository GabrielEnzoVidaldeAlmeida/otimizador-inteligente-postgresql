-- 98% tarefas concluídas
INSERT INTO tarefas (titulo, status)
SELECT 'Tarefa ' || gs, 'concluida'
FROM generate_series(1, 4900000) AS gs;

-- 1% tarefas em andamento
INSERT INTO tarefas (titulo, status)
SELECT 'Tarefa ' || gs, 'em_andamento'
FROM generate_series(1, 50000) AS gs;

-- 1% tarefas pendentes
INSERT INTO tarefas (titulo, status)
SELECT 'Tarefa ' || gs, 'pendente'
FROM generate_series(1, 50000) AS gs;