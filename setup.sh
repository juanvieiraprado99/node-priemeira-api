#!/bin/bash

echo "🚀 Configurando Node Primeira API..."

# Verificar se o arquivo .env já existe
if [ -f ".env" ]; then
    echo "⚠️  Arquivo .env já existe. Pulando criação..."
else
    echo "📝 Criando arquivo .env..."
    cp env.example .env
    echo "✅ Arquivo .env criado com sucesso!"
fi

# Instalar dependências
echo "📦 Instalando dependências..."
npm run install

# Verificar se o Docker está rodando
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker não está rodando. Por favor, inicie o Docker e execute novamente."
    exit 1
fi

# Iniciar banco de dados
echo "🐳 Iniciando banco de dados..."
docker-compose up -d

# Aguardar o banco estar pronto
echo "⏳ Aguardando banco de dados..."
sleep 5

# Executar migrações
echo "🗄️  Executando migrações..."
npm run db:migrate

echo "🎉 Configuração concluída!"
echo ""
echo "Para iniciar o servidor, execute:"
echo "  npm run dev"
echo ""
echo "Para ver a documentação da API:"
echo "  http://localhost:3333/docs"
echo ""
echo "Para executar os testes:"
echo "  npm run test"
