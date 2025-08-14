# 🚀 Node Primeira API

Uma API REST desenvolvida em Node.js como desafio para principiantes, implementando boas práticas de desenvolvimento de APIs com foco em educação e aprendizado.

## 📋 Descrição

Este projeto é uma API de gerenciamento de cursos e usuários desenvolvida com foco em boas práticas de desenvolvimento backend. A API permite criar, listar e buscar cursos, gerenciar usuários e controlar matrículas, servindo como um exemplo prático de desenvolvimento com Node.js, TypeScript e Drizzle ORM.

## 🛠️ Tecnologias Utilizadas

### Backend

- **Node.js** - Runtime JavaScript
- **TypeScript** - Linguagem de programação tipada
- **Fastify** - Framework web rápido e eficiente
- **Zod** - Validação de esquemas e tipos
- **Drizzle ORM** - ORM moderno e type-safe para banco de dados

### Banco de Dados

- **PostgreSQL** - Banco de dados relacional
- **Drizzle Kit** - Ferramentas de migração e gerenciamento de banco

### Documentação

- **Swagger/OpenAPI** - Documentação automática da API
- **Scalar API Reference** - Interface visual para documentação

### Testes

- **Vitest** - Framework de testes moderno
- **Supertest** - Testes de integração HTTP
- **Faker.js** - Geração de dados fictícios para testes

### Desenvolvimento

- **pnpm** - Gerenciador de pacotes
- **Docker Compose** - Containerização do banco de dados

## 🚀 Como Executar

### Pré-requisitos

- Node.js 18+
- pnpm
- Docker e Docker Compose

### 1. Clone o repositório

```bash
git clone <url-do-repositorio>
cd node-priemeira-api
```

### 2. (Recomendado) Execute o script de setup automático

```bash
# No Linux/macOS
chmod +x setup.sh
./setup.sh

# No Windows (PowerShell)
.\setup.ps1
```

**OU** configure manualmente seguindo os passos abaixo:

### 3. Instale as dependências

```bash
pnpm install
```

### 4. Configure as variáveis de ambiente

Copie o arquivo de exemplo e configure suas variáveis:

```bash
cp env.example .env
```

Ou crie manualmente um arquivo `.env` na raiz do projeto:

```env
# Configurações do Banco de Dados
POSTGRES_USER="postgres"
POSTGRES_PASSWORD="postgres"
POSTGRES_DB="desafioNode"
POSTGRES_HOST="localhost"
POSTGRES_PORT="5432"

# URL de conexão com o banco (valores diretos)
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/desafioNode"

# Ambiente
NODE_ENV="development"
```

### 5. Inicie o banco de dados

```bash
docker-compose up -d
```

### 6. Execute as migrações

```bash
pnpm db:migrate
```

### 7. (Opcional) Popule o banco com dados de exemplo

```bash
pnpm db:seed
```

### 8. (Opcional) Configure banco de teste

O container também cria automaticamente um banco de teste (`desafio_test`) para executar os testes.

### 9. Inicie o servidor

```bash
pnpm dev
```

O servidor estará rodando em `http://localhost:3333`

## 📚 Documentação da API

A documentação interativa está disponível em:

- **Swagger UI**: `http://localhost:3333/docs` (apenas em desenvolvimento)
- **API Reference**: `http://localhost:3333/docs` (apenas em desenvolvimento)

## 🗄️ Estrutura do Banco de Dados

### Tabela `users`

- `id`: UUID (chave primária, auto-gerado)
- `name`: Texto (obrigatório)
- `email`: Texto (obrigatório, único)

### Tabela `courses`

- `id`: UUID (chave primária, auto-gerado)
- `title`: Texto (obrigatório)
- `description`: Texto (opcional)

### Tabela `enrollments`

- `id`: UUID (chave primária, auto-gerado)
- `userId`: UUID (referência para users.id)
- `courseId`: UUID (referência para courses.id)
- `createdAt`: Timestamp com timezone (auto-gerado)

## 📁 Estrutura do Projeto

```
node-priemeira-api/
├── src/
│   ├── database/
│   │   ├── client.ts      # Conexão com banco
│   │   ├── schema.ts      # Esquemas das tabelas
│   │   └── seed.ts        # Dados de exemplo
│   ├── routes/
│   │   ├── create-course.ts
│   │   ├── get-course-by-id.ts
│   │   └── get-courses.ts
│   ├── tests/
│   │   └── factories/
│   │       └── make-course.ts
│   ├── app.ts             # Configuração da aplicação
│   └── server.ts          # Servidor principal
├── drizzle/               # Migrações do banco
├── coverage/              # Relatórios de cobertura de testes
├── server.ts              # Servidor principal
├── drizzle.config.ts      # Configuração do Drizzle
├── vitest.config.ts       # Configuração dos testes
└── docker-compose.yml     # Configuração do PostgreSQL
```

## 🛠️ Scripts Disponíveis

- `pnpm dev` - Inicia o servidor em modo desenvolvimento com hot reload
- `pnpm db:generate` - Gera novas migrações baseadas no schema
- `pnpm db:migrate` - Executa migrações pendentes
- `pnpm db:studio` - Abre o Drizzle Studio para visualizar dados
- `pnpm db:seed` - Popula o banco com dados de exemplo
- `pnpm test` - Executa todos os testes com cobertura
- `pnpm pretest` - Executa migrações antes dos testes

### Comandos de Configuração

```bash
# Setup automático (recomendado)
./setup.sh

# Copiar arquivo de exemplo
cp env.example .env

# Editar variáveis de ambiente (opcional)
nano .env
```

## 🧪 Testes

O projeto inclui uma suite completa de testes:

- **Testes de integração** para todas as rotas da API
- **Factories** para criação de dados de teste
- **Cobertura de código** com relatórios detalhados
- **Configuração automática** do banco de teste

Para executar os testes:

```bash
pnpm test
```

Para ver a cobertura de código:

```bash
pnpm test
# Os relatórios estarão disponíveis em ./coverage/
```

## ✅ Husky (pre-commit)

Este projeto utiliza o Husky para garantir qualidade antes de cada commit.

- **O que acontece no pre-commit**: automaticamente é executado `pnpm test`.
- **Se os testes passarem**: o commit prossegue normalmente.
- **Se os testes falharem**: o commit é bloqueado até que os problemas sejam corrigidos.

### Pré-requisitos para o hook funcionar

- Tenha as dependências instaladas: `pnpm install`.
- Garanta que o banco esteja em execução: `docker-compose up -d`.
- Variáveis de ambiente de teste: os comandos de teste usam `dotenv -e .env.test`. Se você tiver um arquivo `.env.test`, ele será carregado. Caso contrário, serão usados valores do ambiente atual.

### Dicas úteis

- Execute os testes localmente antes de commitar:

```bash
pnpm test
```

- Em situações excepcionais (por exemplo, WIP), é possível pular o hook:

```bash
git commit -m "wip: algo" --no-verify
```

Use `--no-verify` com cautela, apenas quando realmente necessário.

## 🔧 Configurações

### Desenvolvimento

- Logs formatados com `pino-pretty`
- Documentação automática habilitada
- Validação de tipos com Zod
- Hot reload com `--watch`
- Cobertura de testes habilitada

### Produção

- Logs otimizados
- Documentação desabilitada
- Validação de tipos mantida

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

### Padrões de Desenvolvimento

- Mantenha a cobertura de testes alta
- Siga os padrões de TypeScript estabelecidos
- Use Zod para validação de dados
- Mantenha a estrutura de pastas organizada

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Autor

**Juan Vieira Prado** durante o Desafio Sua Primeira API com Node.js

---
