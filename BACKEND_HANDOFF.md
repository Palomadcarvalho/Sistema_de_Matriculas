# Backend Handoff — Sistema de Matrículas

Acesso ao banco (Azure PostgreSQL Flexible Server):
- Host: `sistema-de-matriculas.postgres.database.azure.com`
- Porta: `5432`
- Banco: `matriculas`
- SSL: `require`
- Usuário da aplicação: `matriculas_app`
- Senha: _fornecida em canal seguro_

URL JDBC:
```
jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME}?sslmode=${DB_SSLMODE}
```

Variáveis de ambiente (`.env`):
```
DB_HOST=sistema-de-matriculas.postgres.database.azure.com
DB_PORT=5432
DB_NAME=matriculas
DB_USER=matriculas_app
DB_PASSWORD=<SENHA>
DB_SSLMODE=require
```

Consultas úteis: ver `db/sql/` (V1, V2, V3) e `db/sql/tests/smoke_test.sql`.
