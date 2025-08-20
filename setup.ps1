# Script de configuração para Windows PowerShell
# Configurando Node Primeira API

Write-Host "🚀 Configurando Node Primeira API..." -ForegroundColor Green

# Verificar se o arquivo .env já existe
if (Test-Path ".env") {
    Write-Host "⚠️  Arquivo .env já existe. Pulando criação..." -ForegroundColor Yellow
} else {
    Write-Host "📝 Criando arquivo .env..." -ForegroundColor Blue
    
    # Criar arquivo .env com valores diretos
    @"
# Configurações do Banco de Dados
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=desafioNode
POSTGRES_HOST=localhost
POSTGRES_PORT=5432

# URL de conexão com o banco (valores diretos)
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/desafioNode

# Ambiente
NODE_ENV=development
"@ | Out-File -FilePath ".env" -Encoding UTF8
    
    Write-Host "✅ Arquivo .env criado com sucesso!" -ForegroundColor Green
}

# Instalar dependências
Write-Host "📦 Instalando dependências..." -ForegroundColor Blue
npm run install

# Verificar se o Docker está rodando
try {
    docker info | Out-Null
    Write-Host "🐳 Docker está rodando..." -ForegroundColor Green
} catch {
    Write-Host "❌ Docker não está rodando. Por favor, inicie o Docker e execute novamente." -ForegroundColor Red
    exit 1
}

# Iniciar banco de dados
Write-Host "🐳 Iniciando banco de dados..." -ForegroundColor Blue
docker-compose up -d

# Aguardar o banco estar pronto
Write-Host "⏳ Aguardando banco de dados..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Executar migrações
Write-Host "🗄️  Executando migrações..." -ForegroundColor Blue
npm run db:migrate

Write-Host "🎉 Configuração concluída!" -ForegroundColor Green
Write-Host ""
Write-Host "Para iniciar o servidor, execute:" -ForegroundColor Cyan
Write-Host "  npm run dev" -ForegroundColor White
Write-Host ""
Write-Host "Para ver a documentação da API:" -ForegroundColor Cyan
Write-Host "  http://localhost:3333/docs" -ForegroundColor White
Write-Host ""
Write-Host "Para executar os testes:" -ForegroundColor Cyan
Write-Host "  npm run test" -ForegroundColor White
