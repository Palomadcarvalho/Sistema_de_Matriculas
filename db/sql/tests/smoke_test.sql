-- SMOKE TEST — seguro (usa ROLLBACK)
SELECT current_database() AS db, current_user AS "user", version() AS postgres_version;

SELECT 'usuario' AS tabela, COUNT(*) AS qtd FROM usuario
UNION ALL SELECT 'aluno', COUNT(*) FROM aluno
UNION ALL SELECT 'professor', COUNT(*) FROM professor
UNION ALL SELECT 'disciplina', COUNT(*) FROM disciplina
UNION ALL SELECT 'periodo_matricula', COUNT(*) FROM periodo_matricula
UNION ALL SELECT 'oferta_disciplina', COUNT(*) FROM oferta_disciplina
UNION ALL SELECT 'matricula', COUNT(*) FROM matricula;

SELECT o.id, d.codigo, d.nome,
       o.capacidade_max - COUNT(m.id) AS vagas, o.status
FROM oferta_disciplina o
JOIN disciplina d ON d.id = o.disciplina_id
LEFT JOIN matricula m ON m.oferta_id = o.id AND m.status='ATIVA'
GROUP BY o.id, d.codigo, d.nome, o.capacidade_max, o.status
ORDER BY d.codigo;

BEGIN;
INSERT INTO usuario (nome,email,senha_hash,papel)
VALUES ('Smoke Test','smoke_test@ex.com','<bcrypt>','ALUNO');
INSERT INTO aluno(id) SELECT id FROM usuario WHERE email='smoke_test@ex.com';
WITH any_oferta AS (SELECT id FROM oferta_disciplina ORDER BY id LIMIT 1)
INSERT INTO matricula (aluno_id, oferta_id, tipo)
SELECT (SELECT id FROM usuario WHERE email='smoke_test@ex.com'),
       (SELECT id FROM any_oferta),'OBRIGATORIA';
SELECT u.nome, d.codigo, m.tipo, m.status
FROM matricula m
JOIN usuario u ON u.id = m.aluno_id
JOIN oferta_disciplina o ON o.id = m.oferta_id
JOIN disciplina d ON d.id = o.disciplina_id
WHERE u.email='smoke_test@ex.com';
ROLLBACK;
SELECT COUNT(*) AS ainda_existe_aluno_de_teste
FROM usuario WHERE email='smoke_test@ex.com';
