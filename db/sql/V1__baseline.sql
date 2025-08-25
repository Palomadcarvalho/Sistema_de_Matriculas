-- V1: Esquema base — Sistema de Matrículas (PostgreSQL)
CREATE TABLE IF NOT EXISTS usuario (
  id SERIAL PRIMARY KEY,
  nome TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  senha_hash TEXT NOT NULL,
  papel TEXT NOT NULL CHECK (papel IN ('ALUNO','PROFESSOR','SECRETARIA'))
);
CREATE TABLE IF NOT EXISTS aluno (
  id INTEGER PRIMARY KEY REFERENCES usuario(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS professor (
  id INTEGER PRIMARY KEY REFERENCES usuario(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS curso (
  id SERIAL PRIMARY KEY,
  nome TEXT NOT NULL,
  creditos INTEGER NOT NULL CHECK (creditos >= 0)
);
CREATE TABLE IF NOT EXISTS disciplina (
  id SERIAL PRIMARY KEY,
  codigo TEXT NOT NULL UNIQUE,
  nome TEXT NOT NULL,
  creditos INTEGER NOT NULL CHECK (creditos > 0)
);
CREATE TABLE IF NOT EXISTS curso_disciplina (
  curso_id INTEGER NOT NULL REFERENCES curso(id) ON DELETE CASCADE,
  disciplina_id INTEGER NOT NULL REFERENCES disciplina(id) ON DELETE RESTRICT,
  obrigatoria BOOLEAN NOT NULL,
  PRIMARY KEY (curso_id, disciplina_id)
);
CREATE TABLE IF NOT EXISTS periodo_matricula (
  id SERIAL PRIMARY KEY,
  ano INTEGER NOT NULL,
  semestre INTEGER NOT NULL CHECK (semestre IN (1,2)),
  inicio TIMESTAMP NOT NULL,
  fim TIMESTAMP NOT NULL,
  UNIQUE (ano, semestre),
  CHECK (fim > inicio)
);
CREATE TABLE IF NOT EXISTS oferta_disciplina (
  id SERIAL PRIMARY KEY,
  disciplina_id INTEGER NOT NULL REFERENCES disciplina(id) ON DELETE RESTRICT,
  professor_id INTEGER REFERENCES professor(id) ON DELETE SET NULL,
  periodo_id INTEGER NOT NULL REFERENCES periodo_matricula(id) ON DELETE RESTRICT,
  capacidade_max INTEGER NOT NULL DEFAULT 60 CHECK (capacidade_max BETWEEN 1 AND 60),
  status TEXT NOT NULL DEFAULT 'PLANEJADA' CHECK (status IN ('PLANEJADA','ATIVA','CANCELADA')),
  UNIQUE (disciplina_id, periodo_id)
);
CREATE TABLE IF NOT EXISTS matricula (
  id SERIAL PRIMARY KEY,
  aluno_id INTEGER NOT NULL REFERENCES aluno(id) ON DELETE CASCADE,
  oferta_id INTEGER NOT NULL REFERENCES oferta_disciplina(id) ON DELETE CASCADE,
  tipo TEXT NOT NULL CHECK (tipo IN ('OBRIGATORIA','OPTATIVA')),
  status TEXT NOT NULL DEFAULT 'ATIVA' CHECK (status IN ('ATIVA','CANCELADA')),
  data_criacao TIMESTAMP NOT NULL DEFAULT now(),
  UNIQUE (aluno_id, oferta_id)
);
CREATE INDEX IF NOT EXISTS idx_usuario_email ON usuario(email);
CREATE INDEX IF NOT EXISTS idx_oferta_periodo ON oferta_disciplina(periodo_id);
CREATE INDEX IF NOT EXISTS idx_matricula_aluno ON matricula(aluno_id);
CREATE INDEX IF NOT EXISTS idx_matricula_oferta ON matricula(oferta_id);
