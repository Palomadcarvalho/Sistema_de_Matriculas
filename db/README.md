# Starter Kit do Banco — Sistema de Matrículas

Este pacote entrega o **contrato do BD** para o backend: ERD, DDL, seeds e como rodar local com Docker.

## Como subir localmente
1. Instale Docker Desktop.
2. No diretório `db/`, rode:
   ```bash
   docker compose up -d
   ```
3. Acesse `http://localhost:5050` (pgAdmin) — user: `admin@example.com`, senha: `admin`.
4. Conecte no Postgres (`localhost:5432`, user: `postgres`, senha: `postgres`, DB: `matriculas`).

## Aplicar o esquema e seeds (ordem)
1. `sql/V1__baseline.sql`
2. `sql/V2__triggers.sql`
3. `sql/V3__seed.sql`

> Opcional: `sql/ops/create_app_user.sql` cria `matriculas_app` para a aplicação.

## URL JDBC (local/Azure)
```
jdbc:postgresql://<host>:5432/matriculas?sslmode=require
```
