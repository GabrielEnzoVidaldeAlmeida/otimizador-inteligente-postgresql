INSERT INTO usuarios (username)
SELECT
  INITCAP(nome || '_' || sobrenome || gs) AS username
FROM generate_series(1, 5000000) AS gs,
     (SELECT unnest(ARRAY['Ana','Bruno','Carlos','Daniela','Eduardo','Fernanda','Gustavo','Helena','Igor','Julia']) AS nome) AS nomes,
     (SELECT unnest(ARRAY['Silva','Souza','Oliveira','Lima','Costa','Pereira','Rodrigues','Almeida','Nascimento','Moreira']) AS sobrenome) AS sobrenomes
LIMIT 5000000;