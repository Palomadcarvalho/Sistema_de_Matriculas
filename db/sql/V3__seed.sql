-- V3: Seeds mínimos para começar
INSERT INTO usuario (nome, email, senha_hash, papel) VALUES
('Alice Aluna','alice@ex.com','<bcrypt>', 'ALUNO'),
('Pedro Professor','pedro@ex.com','<bcrypt>', 'PROFESSOR'),
('Sara Secretaria','sara@ex.com','<bcrypt>', 'SECRETARIA')
ON CONFLICT (email) DO NOTHING;

INSERT INTO aluno(id) 
SELECT id FROM usuario WHERE email = 'alice@ex.com'
ON CONFLICT DO NOTHING;

INSERT INTO professor(id) 
SELECT id FROM usuario WHERE email = 'pedro@ex.com'
ON CONFLICT DO NOTHING;

INSERT INTO disciplina (codigo, nome, creditos) VALUES
('INF100','Algoritmos',4),
('INF200','Banco de Dados',4)
ON CONFLICT (codigo) DO NOTHING;

WITH upsert AS (
  INSERT INTO periodo_matricula (ano, semestre, inicio, fim)
  VALUES (2025, 2, now() - interval '1 day', now() + interval '14 days')
  ON CONFLICT (ano, semestre) DO UPDATE
    SET inicio = EXCLUDED.inicio, fim = EXCLUDED.fim
  RETURNING id
)
INSERT INTO oferta_disciplina (disciplina_id, professor_id, periodo_id, capacidade_max, status)
SELECT d.id, p.id, (SELECT id FROM upsert), 60, 'PLANEJADA'
FROM disciplina d, professor p
WHERE d.codigo = 'INF100'
LIMIT 1
ON CONFLICT DO NOTHING;
