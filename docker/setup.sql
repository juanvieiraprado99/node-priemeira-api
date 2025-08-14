-- Script de inicialização do banco de dados
-- Este arquivo é executado automaticamente quando o container é criado

-- Criar banco de teste se não existir
SELECT 'CREATE DATABASE desafio_test'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'desafio_test')\gexec

-- Conceder privilégios ao usuário postgres
GRANT ALL PRIVILEGES ON DATABASE desafio_test TO postgres;