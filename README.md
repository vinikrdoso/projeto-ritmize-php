# 🥁 RITMIZE - Sistema de Gestão de Escola de Música

Sistema web para gestão de alunos, aulas, pagamentos e notificações de uma escola de música.

## 📋 Funcionalidades

- **Dashboard** - Visão geral com cards de pagamentos, aulas e notificações
- **Login/Logout** - Sistema de autenticação
- **Perfil** - Gestão de dados pessoais e foto
- **Aulas** - Histórico de presença e turmas
- **Financeiro** - Gestão de mensalidades e pagamentos
- **Notificações** - Sistema de avisos e comunicados

## 📁 Estrutura do Projeto

```
ritmize/
├── assets/                 # Recursos estáticos
│   ├── css/               # Estilos CSS
│   ├── js/                # JavaScript
│   └── img/               # Imagens e ícones
├── system/                 # Sistema MVC
│   ├── core/              # Classes principais
│   ├── controllers/       # Controladores
│   └── models/            # Modelos
├── templates/              # Templates Twig
├── vendor/                 # Dependências Composer
├── public/                 # Arquivos públicos
├── index.php              # Dashboard principal
├── login.php              # Sistema de login
├── logout.php             # Sistema de logout
├── perfil.php             # Página de perfil
├── aulas.php              # Página de aulas
├── financeiro.php         # Página financeira
├── composer.json          # Dependências
└── README.md              # Este arquivo
```

## 🎯 Como Usar

1. **Acesse o sistema**: `http://localhost/ritmize/`
2. **Faça login** com as credenciais fornecidas
3. **Navegue pelas seções**:
   - Dashboard: Visão geral
   - Perfil: Dados pessoais
   - Aulas: Histórico de presença
   - Financeiro: Pagamentos

## 🚀 Instalação

### Pré-requisitos

- PHP 8.1 ou superior
- MySQL 5.7 ou superior
- Composer
- Servidor web (Apache/Nginx)

### Passos

1. **Clone o repositório**
   ```bash
   git clone https://github.com/vinikrdoso/projeto-ritmize-php.git
   cd projeto-ritmize-php
   ```

2. **Instale as dependências**
   ```bash
   composer install
   ```

3. **Configure o banco de dados**
   - Crie um banco MySQL chamado `ritmize_lms`
   - Importe o arquivo `database.sql` incluído no projeto:
     ```bash
     mysql -u root -p ritmize_lms < database.sql
     ```
   - Configure as credenciais em `system/core/Database.php`

4. **Configure o servidor web**
   - Aponte o DocumentRoot para a pasta do projeto
   - Certifique-se que o mod_rewrite está habilitado (Apache)

5. **Configure o timezone**
   - O sistema está configurado para `Europe/Lisbon`
   - Pode ser alterado nos arquivos .php se necessário

## 🔧 Configuração

### Banco de Dados

Edite `system/core/Database.php`:

```php
private $host = 'localhost';
private $dbname = 'ritmize_lms';
private $username = 'seu_usuario';
private $password = 'sua_senha';
```
---

**RITMIZE** - Sistema de Gestão de Escola de Música 🎵 